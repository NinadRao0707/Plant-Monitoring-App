#include <pgmspace.h>

#define SECRET

const char WIFI_SSID[] = "";     // WiFi SSID
const char WIFI_PASSWORD[] = ""; // WiFi Password

#define THINGNAME "ESP8266"

int8_t TIME_ZONE = -5; // NYC(USA): -5 UTC

const char MQTT_HOST[] = ""; // MQTT Host

static const char cacert[] PROGMEM = R"EOF(
-----BEGIN CERTIFICATE-----
-----END CERTIFICATE-----
)EOF"; // AWS IoT Certificate

static const char client_cert[] PROGMEM = R"KEY(
-----BEGIN CERTIFICATE-----
-----END CERTIFICATE-----
)KEY"; // AWS IoT Certificate

// Copy contents from  XXXXXXXX-private.pem.key here â–¼
static const char privkey[] PROGMEM = R"KEY(
-----BEGIN RSA PRIVATE KEY-----
-----END RSA PRIVATE KEY-----
)KEY"; // AWS IoT Certificate