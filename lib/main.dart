// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sirm_task/screen/Home_screen.dart';
import 'package:sirm_task/screen/animal_details.dart' as AnimalDetails; // Alias added
import 'package:sirm_task/screen/animal_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Data App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/animal_list', page: () => AnimalListScreen()),
        GetPage(
          name: '/animal_details',
          page: () => AnimalDetails.AnimalDetailsScreen(animal: ''),
        ),
      ],
    );
  }
}
