# pip install awsiotsdk

from flask import Flask
import pandas as pd
import numpy as np 
import matplotlib.pyplot as plt
from pandas import Series

import time
import datetime
from awscrt import mqtt
import json
import AWSIoTPythonSDK.MQTTLib as AWSIoTPyMQTT

app = Flask(__name__)

dataframe = {'datetime':[], 'moisture':[]}

ENDPOINT = "a1n0zq7k1z3sqk-ats.iot.ap-south-1.amazonaws.com"
CLIENT_ID = "1"
PATH_TO_CERT = "DeviceCertificate.crt"
PATH_TO_KEY = "Private.key"
PATH_TO_ROOT = "RootCA.pem"
MESSAGE = "Hello World"
TOPIC = "esp8266/pub"
RANGE = 20



@app.route('/')
# ‘/’ URL is bound with hello_world() function.
def hello_world():
    return 'Hello World'


@app.route('/create_dataset')
def create_dataset():

    myAWSIoTMQTTClient = AWSIoTPyMQTT.AWSIoTMQTTClient(CLIENT_ID)
    myAWSIoTMQTTClient.configureEndpoint(ENDPOINT, 8883)
    myAWSIoTMQTTClient.configureCredentials(PATH_TO_ROOT, PATH_TO_KEY, PATH_TO_CERT)
    myAWSIoTMQTTClient.connect()
    print("Client Connected")

    # call back to trigger when a message is received
    def on_data_received(client, userdata, message):
        print("Received message from topic '{}': {}".format(message.topic, message.payload))
        data = json.loads(message.payload)
        time = datetime.datetime.now()
        moisture = data["moisture"]
        dataframe["datetime"].append(time);
        dataframe["moisture"].append(moisture);

    # Publish to the same topic in a loop forever
    loopCount = 0
    while loopCount<=10:
        myAWSIoTMQTTClient.subscribe(topic=TOPIC, QoS=mqtt.QoS.AT_LEAST_ONCE, callback=on_data_received)
        loopCount += 1
        time.sleep(1)

    myAWSIoTMQTTClient.unsubscribe(TOPIC)
    df = pd.DataFrame(dataframe)
    print("Training dataset:")
    print(df)

    df.to_csv('train.csv')

    return "Training dataset created"

@app.route('/visualize_dataset')
def visualize_dataset():
    df = pd.read_csv('train.csv')
    df.index = df['datetime']
    ts = df['moisture'] 
    plt.figure(figsize=(13,7)) 
    plt.plot(ts, label='Moisture') 
    plt.title('Time Series') 
    plt.xlabel("Time(year-month)") 
    plt.ylabel("moisture (%)") 
    plt.legend(loc='best')
    plt.show()

    return "Hi"


if __name__ == '__main__':
    app.run()