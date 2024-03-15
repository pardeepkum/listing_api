import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimalDetailsScreen extends StatelessWidget {
  final String animal = Get.arguments as String;


  AnimalDetailsScreen({Key? key, required String animal,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // print("animal name:-  >$animal");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Animal Details'),
      ),
      body: Center(
        child: Text(
          'Details for $animal',
          style: const TextStyle(fontSize: 20, color: Colors.black87),
        ),
      ),
    );
  }
}
