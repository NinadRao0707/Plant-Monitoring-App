// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';

import 'PlantScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PlantScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 250, 247, 250),
            Color.fromARGB(255, 214, 245, 187)
          ],
          end: Alignment.bottomLeft,
          begin: Alignment.topRight,
        ),
      ),
      child:
          Image.network("https://img.icons8.com/color/144/000000/sprout.png"),
    );
  }
}
