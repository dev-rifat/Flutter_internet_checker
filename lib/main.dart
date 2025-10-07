import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_chacker/pages/network_screen.dart';
import 'controller/network_controller.dart' show NetworkController;

void main() {
  // Initialize controller before app runs
  Get.put(NetworkController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Internet Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NetworkScreen(),
    );
  }
}
