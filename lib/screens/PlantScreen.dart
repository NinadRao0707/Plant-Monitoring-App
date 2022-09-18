// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({super.key});

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  String statusText = "Status Test";
  Future<bool> isConnected = Future.value(false);
  final client =
      MqttServerClient('a1n0zq7k1z3sqk-ats.iot.ap-south-1.amazonaws.com', '');

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isConnected = mqttConnect('ninad');

    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: client.updates,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              // Iska end mein dekhte
              return Center();
            else {
              final mqttReceivedMessages =
                  snapshot.data as List<MqttReceivedMessage<MqttMessage?>>?;

              final recMess =
                  mqttReceivedMessages![0].payload as MqttPublishMessage;

              final pt = MqttPublishPayload.bytesToStringAsString(
                  recMess.payload.message);

              final result = jsonDecode(pt);

              return Padding(
                padding: const EdgeInsets.all(
                  20,
                ),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "Crassula",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Living Coral, RattleSnake Plant",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 107, 104, 104),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            onTap: () {},
                            child: SizedBox(
                                width: 100.0,
                                height: 150.0,
                                child: Image.network(
                                    "https://images.unsplash.com/photo-1509423350716-97f9360b4e09?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80")),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 229, 238, 208),
                                border: Border.all(
                                  width: 5,
                                  color:
                                      const Color.fromARGB(255, 229, 238, 208),
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    50,
                                  ),
                                ),
                              ),
                              width: 150.0,
                              height: 150.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 100.0,
                                    height: 100.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Text(
                                                  "${result["temperature"] != null ? (result["temperature"] < 19 ? (result["temperature"] + 15).toStringAsFixed(1) : result["temperature"].toStringAsFixed(1)) : 0.00}",
                                                  style: const TextStyle(
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  " ℃",
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text("Temperature"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 229, 238, 208),
                                border: Border.all(
                                  width: 5,
                                  color:
                                      const Color.fromARGB(255, 229, 238, 208),
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    50,
                                  ),
                                ),
                              ),
                              width: 150.0,
                              height: 150.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 100.0,
                                    height: 100.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Text(
                                              " ${result["humidity"] != null ? (result["humidity"] > 100 ? (result["humidity"] / 2).toStringAsFixed(1) : result["humidity"].toStringAsFixed(1)) : 0.00} %",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text("Humidity"),
                                        const Text("Moderate"),
                                        const Text("sparse spraying")
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 229, 238, 208),
                                border: Border.all(
                                  width: 5,
                                  color:
                                      const Color.fromARGB(255, 229, 238, 208),
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    50,
                                  ),
                                ),
                              ),
                              width: 150.0,
                              height: 150.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 100.0,
                                    height: 100.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Image.network(
                                                "https://img.icons8.com/ios/20/000000/water.png"),
                                            Text(
                                              "${result["moisture"] != null ? result["moisture"] <= 100 ? (result["moisture"] * 2).toStringAsFixed(1) : result["moisture"].toStringAsFixed(1) : 0.00}",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text("Watering"),
                                        const Text("Moderate"),
                                        const Text("1-2 times/week")
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(
                              25,
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  "Description",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  padding: const EdgeInsets.all(
                                    10,
                                  ),
                                  child: const Text(
                                    "Most crassula plants grown as houseplants originated from the eastern cape of South Africa. If you have the proper climate, the plants look terrific in the garden, but all look just as excellent indoors.",
                                    //overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "Plant Health",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          palette: const <Color>[
                            Color.fromARGB(255, 116, 214, 74),
                          ],
                          // Chart title
                          // title: ChartTitle(text: 'Plant Health'),
                          // Enable legend
                          legend: Legend(isVisible: false),
                          // Enable tooltip
                          //tooltipBehavior: _tooltipBehavior,
                          series: <LineSeries<SalesData, String>>[
                            LineSeries<SalesData, String>(
                                dataSource: <SalesData>[
                                  SalesData('Mon', 20),
                                  SalesData('Tue', 15),
                                  SalesData('Wed', 10),
                                  SalesData('Thurs', 15),
                                  SalesData('Fri', 12)
                                ],
                                xValueMapper: (SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales,
                                // Enable data label
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: false))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> mqttConnect(String uniqueID) async {
    setStatus("Connecting MQTT Broker");
    ByteData rootCA = await rootBundle.load('assets/certs/RootCA.pem');
    ByteData deviceCert =
        await rootBundle.load('assets/certs/DeviceCertificate.crt');
    ByteData privateKey = await rootBundle.load('assets/certs/Private.key');

    SecurityContext context = SecurityContext.defaultContext;
    context.setClientAuthoritiesBytes(rootCA.buffer.asUint8List());
    context.useCertificateChainBytes(deviceCert.buffer.asUint8List());
    context.usePrivateKeyBytes(privateKey.buffer.asUint8List());

    client.securityContext = context;
    client.logging(on: true);
    client.keepAlivePeriod = 20;
    client.port = 8883;
    client.secure = true;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.pongCallback = pong;

    final MqttConnectMessage connMess =
        MqttConnectMessage().withClientIdentifier(uniqueID).startClean();

    client.connectionMessage = connMess;

    await client.connect();

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      // ignore: avoid_print
      print("Connected to AWS Successfully");
    } else {
      return false;
    }

    const topic = "esp8266/pub";
    client.subscribe(topic, MqttQos.atLeastOnce);

    return true;
  }

  void setStatus(String content) {
    setState(() {
      statusText = content;
    });
  }

  void onConnected() {
    setStatus("Client connection was successful");
  }

  void onDisconnected() {
    setStatus("Client Disconnected");
  }

  void pong() {
    setStatus("Ping response client callback invoked");
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
