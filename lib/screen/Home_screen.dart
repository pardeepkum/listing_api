import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:sirm_task/controller/Home_controller.dart';

import 'animal_list.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      leading: const Text(''),
        centerTitle: true,
        title: TextField(
          onChanged: (value) {
            controller.searchText.value = value;
            controller.filterData();
          },
          decoration: InputDecoration(
            hintText: 'Search Data',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          style: const TextStyle(color: Colors.black45),
        ),
      ),
      body: Obx(
            () => EasyRefresh(
          controller: controller.refreshController,
          onRefresh: () async {
            controller.page.value = 1;
            controller.fetchTodos();
            controller.refreshController.finishRefresh();
          },
          onLoad: () async {
            controller.page.value++;
            controller.fetchTodos();
            controller.refreshController.finishLoad();
          },
          child: ListView.builder(
            itemCount: controller.filteredTodos.length,
            itemBuilder: (context, index) {
              var data = controller.filteredTodos[index];
              return ListTile(
                title:  Row(
                  children: [
                    Expanded(
                      child: Text(data.title.toString()),
                    ),

                  ],
                ),
                leading: CircleAvatar(
                  child: Text(data.id.toString()),
                ),
                trailing: Checkbox(
                  value: data.completed,
                  onChanged: (bool? value) {
                    controller.dataCompletion(index);
                  },
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 0),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(AnimalListScreen());
                },
                child: const Text('Animal Screen'),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              _showAddDataDialog(context);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void _showAddDataDialog(BuildContext context) {
    TextEditingController dataTitleController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Data"),
          content: TextField(
            controller: dataTitleController,
            decoration: const InputDecoration(hintText: "Enter Data here"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                String title = dataTitleController.text;
                if (title.isNotEmpty) {
                  controller.addData(title);
                  Navigator.pop(context);
                }
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}
