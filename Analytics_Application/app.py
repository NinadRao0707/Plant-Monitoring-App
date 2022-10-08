# pip install awsiotsdk

from flask import Flask, send_file, jsonify
from flask_cors import CORS, cross_origin
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pandas import Series
from statsmodels.tsa.statespace.sarimax import SARIMAX

import time
import datetime
from awscrt import mqtt
import json
import AWSIoTPythonSDK.MQTTLib as AWSIoTPyMQTT

app = Flask(__name__)
cors = CORS(app)

dataframe = {
    "datetime": [],
    "moisture": [],
    "humidity": [],
    "temperature": [],
    "light": [],
}

ENDPOINT = "a1n0zq7k1z3sqk-ats.iot.ap-south-1.amazonaws.com"
CLIENT_ID = "1"
PATH_TO_CERT = "DeviceCertificate.crt"
PATH_TO_KEY = "Private.key"
PATH_TO_ROOT = "RootCA.pem"
MESSAGE = "Hello World"
TOPIC = "esp8266/pub"
RANGE = 20

final_pred = ""


@app.route("/")
# ‘/’ URL is bound with hello_world() function.
def hello_world():
    return "Hello World"


@app.route("/create_dataset")
def create_dataset():

    myAWSIoTMQTTClient = AWSIoTPyMQTT.AWSIoTMQTTClient(CLIENT_ID)
    myAWSIoTMQTTClient.configureEndpoint(ENDPOINT, 8883)
    myAWSIoTMQTTClient.configureCredentials(PATH_TO_ROOT, PATH_TO_KEY, PATH_TO_CERT)
    myAWSIoTMQTTClient.connect()
    print("Client Connected")

    # call back to trigger when a message is received
    def on_data_received(client, userdata, message):
        print(
            "Received message from topic '{}': {}".format(
                message.topic, message.payload
            )
        )
        data = json.loads(message.payload)
        time = datetime.datetime.now()
        moisture = data["moisture"]
        humidity = data["humidity"]
        temperature = data["temperature"]
        light = data["light"]
        dataframe["datetime"].append(time)
        dataframe["moisture"].append(moisture)
        dataframe["humidity"].append(humidity)
        dataframe["temperature"].append(temperature)
        dataframe["light"].append(light)

    # Publish to the same topic in a loop forever
    loopCount = 0
    while loopCount <= 1000:
        myAWSIoTMQTTClient.subscribe(
            topic=TOPIC, QoS=mqtt.QoS.AT_LEAST_ONCE, callback=on_data_received
        )
        loopCount += 1
        time.sleep(1)

    myAWSIoTMQTTClient.unsubscribe(TOPIC)
    df = pd.DataFrame(dataframe)
    print("Training dataset:")
    print(df)

    df.to_csv("train.csv")

    return "Training dataset created"


@app.route("/visualize")
def visualize():
    df = pd.read_csv("train.csv")
    df["datetime"] = pd.to_datetime(df.datetime, infer_datetime_format=True)

    df.index = df["datetime"]
    ts = df["moisture"]
    plt.figure(figsize=(13, 7))
    plt.plot(ts, label="Moisture")
    plt.title("Time Series")
    plt.xlabel("Time")
    plt.ylabel("Moisture (%)")
    plt.legend(loc="best")
    # plt.savefig('training_dataset.png')

    return send_file("training_dataset.png", mimetype="image/gif")


@app.route("/train")
def train():
    df = pd.read_csv("train.csv")
    df["datetime"] = pd.to_datetime(df.datetime, infer_datetime_format=True)
    df.index = df["datetime"]

    plt.figure(figsize=(13, 7))
    plt.plot(df["moisture"], color="black")
    plt.title("Time Series")
    plt.xlabel("Time")
    plt.ylabel("Moisture (%)")
    plt.legend(loc="best")

    # return send_file('train_test_dataset.png', mimetype='image/gif')

    y = df["moisture"]
    SARIMAXmodel = SARIMAX(y, order=(1, 0, 1))
    SARIMAXmodel = SARIMAXmodel.fit()

    y_pred = SARIMAXmodel.get_forecast(len(df.index) + 1000)
    y_pred_df = y_pred.conf_int(alpha=0.05)
    y_pred_df["Predictions"] = SARIMAXmodel.predict(
        start=y_pred_df.index[0], end=y_pred_df.index[-1]
    )
    y_pred_df["datetime"] = [
        df["datetime"].iloc[-1] + datetime.timedelta(seconds=i * 2)
        for i in range(len(y_pred_df))
    ]
    y_pred_df.index = y_pred_df["datetime"]
    for index, row in y_pred_df.iterrows():
        if row["Predictions"] <= 10:
            print("Water the plant before:", index)
            global final_pred
            final_pred = index.strftime("%Y-%m-%d %H:%M:%S.%f")
            plt.axvline(index)
            plt.axhline(10)
            break

    y_pred_out = y_pred_df["Predictions"]
    plt.plot(y_pred_out, color="red", label="Predictions")
    plt.savefig("prediction_dataset.png")
    return send_file("prediction_dataset.png", mimetype="image/gif")


@app.route("/predict")
@cross_origin()
def predict():
    return final_pred


if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)
