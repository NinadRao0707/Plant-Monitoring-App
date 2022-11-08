// ignore_for_file: unused_import

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plant_monitoring_system/screens/HomePage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
