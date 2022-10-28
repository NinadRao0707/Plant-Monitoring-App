#include <ESP8266WiFi.h>
#include <WiFiClientSecure.h>
#include <PubSubClient.h>
#include <ArduinoJson.h>
#include <time.h>
#include "secrets.h"
#include "DHT.h"
#include <Wire.h>
#include <BH1750.h>

// SETTING UP DHT SENSOR PIN
#define DHTPIN 2      // Digital pin connected to the DHT sensor
#define DHTTYPE DHT11 // DHT 11

DHT dht(DHTPIN, DHTTYPE);

// SETTING UP SOIL MOISTURE SENSOR PIN
const int sensor_pin = A0; // Analog read pin for moisture sensor

BH1750 lightMeter;

unsigned long lastMillis = 0;
unsigned long previousMillis = 0;

#define AWS_IOT_PUBLISH_TOPIC "esp8266/pub"
#define AWS_IOT_SUBSCRIBE_TOPIC "esp8266/sub"

WiFiClientSecure net;

BearSSL::X509List cert(cacert);
BearSSL::X509List client_crt(client_cert);
BearSSL::PrivateKey key(privkey);

PubSubClient client(net);

time_t now;
time_t nowish = 1510592825;

void NTPConnect(void)
{
    Serial.print("Setting time using SNTP");
    configTime(TIME_ZONE * 3600, 0 * 3600, "pool.ntp.org", "time.nist.gov");
    now = time(nullptr);
    while (now < nowish)
    {
        delay(500);
        Serial.print(".");
        now = time(nullptr);
    }
    Serial.println("done!");
    struct tm timeinfo;
    gmtime_r(&now, &timeinfo);
    Serial.print("Current time: ");
    Serial.print(asctime(&timeinfo));
}

void messageReceived(char *topic, byte *payload, unsigned int length)
{
    Serial.print("Received [");
    Serial.print(topic);
    Serial.print("]: ");
    for (int i = 0; i < length; i++)
    {
        Serial.print((char)payload[i]);
    }
    Serial.println();
}

void connectAWS()
{
    delay(3000);
    WiFi.mode(WIFI_STA);
    WiFi.begin(WIFI_SSID, WIFI_PASSWORD);

    Serial.println(String("Attempting to connect to SSID: ") + String(WIFI_SSID));

    while (WiFi.status() != WL_CONNECTED)
    {
        Serial.print(".");
        delay(1000);
    }

    NTPConnect();

    net.setTrustAnchors(&cert);
    net.setClientRSACert(&client_crt, &key);

    client.setServer(MQTT_HOST, 8883);
    client.setCallback(messageReceived);

    Serial.println("Connecting to AWS IOT");

    while (!client.connect(THINGNAME))
    {
        Serial.print(".");
        delay(1000);
    }

    if (!client.connected())
    {
        Serial.println("AWS IoT Timeout!");
        return;
    }
    // Subscribe to a topic
    client.subscribe(AWS_IOT_SUBSCRIBE_TOPIC);

    Serial.println("AWS IoT Connected!");
}

void publishMessage(float moisture, float humidity, float temperature, float light)
{
    StaticJsonDocument<200> doc;
    doc["time"] = millis();
    doc["moisture"] = moisture;
    doc["humidity"] = humidity;
    doc["temperature"] = temperature;
    doc["light"] = light;
    char jsonBuffer[512];
    serializeJson(doc, jsonBuffer); // print to client

    client.publish(AWS_IOT_PUBLISH_TOPIC, jsonBuffer);
}

void setup()
{
    Serial.begin(9600);

    Wire.begin();
    lightMeter.begin();

    connectAWS();
}

void loop()
{
    float humidity = dht.readHumidity() / 2;
    float temperature = dht.readTemperature();
    float moisture_reading = analogRead(sensor_pin);
    float moisture_percentage = (100.00 - ((moisture_reading / 1023.00) * 100.00));
    float lux = lightMeter.readLightLevel();

    Serial.print("Soil Moisture(%) = ");
    Serial.print(moisture_percentage);
    Serial.print(", ");
    Serial.print("Humidity = ");
    Serial.print(humidity);
    Serial.print(", ");
    Serial.print("Temperature = ");
    Serial.print(temperature);
    Serial.print(", ");
    Serial.print("Light = ");
    Serial.print(lux);
    Serial.println(".");
    delay(1000);

    now = time(nullptr);

    if (!client.connected())
    {
        connectAWS();
    }
    else
    {
        client.loop();
        if (millis() - lastMillis > 1000)
        {
            lastMillis = millis();
            if (moisture_percentage > 0 && !isnan(humidity) && humidity < 100 && !isnan(temperature))
            {
                publishMessage(moisture_percentage, humidity, temperature, lux);
            }
        }
    }
}