import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SecondScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //Scolor: Colors.white,
        child:
            Image.network("https://img.icons8.com/color/144/000000/sprout.png"),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 250, 247, 250),
              Color.fromARGB(255, 214, 245, 187)
            ],
            end: Alignment.bottomLeft,
            begin: Alignment.topRight,
          ),
        ));
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                Text(
                  "Crassula",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Living Coral, RattleSnake Plant",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 107, 104, 104)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: Container(
                          width: 100.0,
                          height: 150.0,
                          child: Image.network(
                              "https://images.unsplash.com/photo-1509423350716-97f9360b4e09?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80")),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 229, 238, 208),
                          border: Border.all(
                              width: 5,
                              color: Color.fromARGB(255, 229, 238, 208)),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        width: 150.0,
                        height: 150.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 100.0,
                              height: 100.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                        child: Text(
                                          "34°C",
                                          style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Temperature"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 229, 238, 208),
                          border: Border.all(
                              width: 5,
                              color: Color.fromARGB(255, 229, 238, 208)),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        width: 150.0,
                        height: 150.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 100.0,
                              height: 100.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                          child: Image.network(
                                              "https://img.icons8.com/external-phatplus-solid-phatplus/20/000000/external-humidity-weather-phatplus-solid-phatplus.png")),
                                      Container(
                                        child: Text(
                                          " Humidity",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Moderate"),
                                  Text("sparse spraying")
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 229, 238, 208),
                          border: Border.all(
                              width: 5,
                              color: Color.fromARGB(255, 229, 238, 208)),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        width: 150.0,
                        height: 150.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 100.0,
                              height: 100.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                          child: Image.network(
                                              "https://img.icons8.com/ios/20/000000/water.png")),
                                      Container(
                                        child: Text(
                                          "Watering",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Moderate"),
                                  Text("1-2 times/week")
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(25),
                        child: Column(
                          children: [
                            Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              padding: const EdgeInsets.all(10),
                              child: const Text(
                                "Most crassula plants grown as houseplants originated from the eastern cape of South Africa. If you have the proper climate, the plants look terrific in the garden, but all look just as excellent indoors.",
                                //overflow: TextOverflow.fade,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
                Text(
                  "Description",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                    height: 150,
                    child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        palette: <Color>[
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
                              xValueMapper: (SalesData sales, _) => sales.year,
                              yValueMapper: (SalesData sales, _) => sales.sales,
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: false))
                        ]))
              ]),
        ),
      ),
    ));
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
