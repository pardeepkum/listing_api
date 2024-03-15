import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimalListScreen extends StatelessWidget {
  final List<String> animals = [
    'Dog',
    'Cat',
    'Sparrow',
    'Pigeon',
    'Octopus',
    'Rhino',
    'Leopard',
    'Lion',
    'Jaguar',
  ];

  AnimalListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animal List'),
      ),
      body: ListView.builder(
        itemCount: animals.length,
        itemBuilder: (context, index) {
          final animal = animals[index];
          return ListTile(
            title: Text(animal),
            onTap: () {
              Get.toNamed('/animal_details', arguments: animal);
            },
          );
        },
      ),
    );
  }
}
