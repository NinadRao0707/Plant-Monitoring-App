# 🌱 Plant Environment Monitoring System
> _A complete plant care ecosystem_

## Introduction

Plants at home requires as much care as any plant present in a garden or a science lab. If they are not watered regularly or cared for enough, they may wilt and eventually die. Sometimes watering the plant regularly or just moving it to a more sun-lit area can make huge improvements to the plant's environment providing it with a greater chance of flourishing and/or blooming fully. Reminding the user to water the plant at a predicted time when the soil of the plant is about to dry-up will allow the user to plan the watering schedule for that plant if he/she is not available when the soil dries up.

## Overview

The system is composed of four major components:

✅ Mobile App (Flutter)\
✅ Cloud Server (AWS IoT Core)\
✅ Hardware (NodeMCU ESP8266)\
✅ Backend (Flask using Python)

## Features

Monitoring plant health is very important for their fast growth. In this busy world, people usually forget to water their plants which leads to bad growth and health of their plants. For ensuring complete development of plants it is necessary to develop proper surrounding conditions in which plants grow. We are now going to make a small Plant Monitoring system whose data will be displayed on the mobile screen. This system monitors the temperature, humidity, moisture levels in the soil and provides an opportunity to study the existing systems, along with their features and drawbacks.

Plant Monitoring System uses following components:

⚡️ESP8266 board as the main controller as well as remote connectivity\
⚡️DHT11 Temperature and Humidity Sensor to measure the temperature and the humidity of the environment\
⚡️Resistive Soil Moisture Sensor to detect the percentage of moisture present in the soil\
⚡️BH1750 Light Intensity Sensor for measuring the light flux

## Dependencies

📄 [Flutter](https://flutter.dev/)\
📄 [Cupertino Icons](https://pub.dev/packages/cupertino_icons)\
📄 [Flutter Chart](https://pub.dev/packages/fl_chart)\
📄 [Sync Fusion Flutter Charts](https://pub.dev/packages/syncfusion_flutter_charts)\
📄 [Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons)\
📄 [Get](https://pub.dev/packages/get)\
📄 [MQTT Client](https://pub.dev/packages/mqtt_client)\
📄 [HTTP Request](https://pub.dev/packages/http)\
📄 [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications)\
📄 [Timezone](https://pub.dev/packages/timezone)\
📄 [RXDart](https://pub.dev/packages/rxdart)

## Details

## Mobile App

The application is built upon Flutter which is an open-source UI software development kit (SDK) created by Google. It is widely used to develop cross-platform applications for Android, iOS, websites etc. By coding in Dart, an open-source programming language for developing the Flutter app, the app can be built upon any operating system and create a consistent user app experience for various mobile devices.

The functions which we have implemented are:

⚡️Created the landing page for our application\
⚡️Alerts the user by showing them notifications on watering the plant based on their date and time of the mobile application\
⚡️Created a function to make the UI of the notification to be shown to the user\
⚡️To display the sensor readings and display a graph depicting the health of the plant along with the date and time to water the plant

## Cloud Server

AWS IoT provides the cloud services that connect your IoT devices to other devices and AWS cloud services. AWS IoT provides device software that can help you integrate your IoT devices into AWS IoT-based solutions. If your devices can connect to AWS IoT, AWS IoT can connect them to the cloud services that AWS provides. The AWS IoT Core message broker supports devices and clients that use MQTT and MQTT over WSS protocols to publish and subscribe to messages. It also supports devices and clients that use the HTTPS protocol to publish messages.

To connect to AWS, we have used the mqtt_client package. It is a server and browser based MQTT client for Dart. The client is designed to take as much MQTT protocol work off the user as possible, connection protocol is handled automatically as are the message exchanges needed to support the different QOS levels and the keep alive mechanism. This allows the user to concentrate on publishing/subscribing and not the details of MQTT itself.

## Hardware

As mentioned earlier, we have used the following components:

⚡️ESP8266 board as the main controller as well as remote connectivity\
⚡️DHT11 Temperature and Humidity Sensor to measure the temperature and the humidity of the environment\
⚡️Resistive Soil Moisture Sensor to detect the percentage of moisture present in the soil\
⚡️BH1750 Light Intensity Sensor for measuring the light flux

We have implemented the following circuit to make the necessary connections to the AWS IoT Core.

<img src="https://user-images.githubusercontent.com/67018142/198600631-97e66a38-90a9-42d9-bfec-1e546bb078a0.png" width="500" />

## Backend

Flask is a micro web framework written in Python. It is classified as a microframework because it does not require particular tools or libraries. It has no database abstraction layer, form validation, or any other components where pre-existing third-party libraries provide common functions. Using Flask, we have built and used REST API for fetching prediction from analytics application to achieve the following objectives.

✅ Notify the user to move the plant to an area with more sunlight when it does not have enough light conditions\
✅ Notify the user to water the plant when the soil does not have enough moisture content\
✅ Getting the estimated time for watering the plant before the soil moisture decreases below a threshold\
✅ Provide the home plant of the user with appropriate environmental conditions for better growth

## Getting started

#### 1. [Setup Flutter](https://flutter.dev/docs/get-started/install)

#### 2. Clone the repository

```sh
$ git clone https://github.com/NinadRao0707/Plant-Monitoring-App.git
$ cd Plant-Monitoring-App/
```

#### 3. Go to project root and execute the following command in console to get the required dependencies:

```sh
flutter pub get
```

#### 4. Go to main.dart file root and execute the following command in console to run the app:

```sh
flutter run
```

#### Make sure the circuit is on and everything is connected.

## Show your support

Give a ⭐️ if this project helped you!

👤 **Ninad Rao**\
👤 **V Krishnasubramaniam**\
👤 **Shalaka Waghamale**
