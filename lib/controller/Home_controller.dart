import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirm_task/model/model_class.dart';

class HomeController extends GetxController {
  var loading = true.obs;
  var listData = <userModel>[].obs;
  var filteredTodos = <userModel>[].obs;
  var page = 1.obs;
  var searchText = ''.obs;
  final _prefsKey = 'todos';
  EasyRefreshController refreshController = EasyRefreshController();

  @override
  void onInit() {
    super.onInit();
    loadTodos();
    fetchTodos();
  }

  void saveTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todosJsonList = listData.map((todo) => todo.toJsonString()).toList();
    await prefs.setStringList(_prefsKey, todosJsonList);
  }

  void loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todosJsonList = prefs.getStringList(_prefsKey);
    if (todosJsonList != null) {
      listData.assignAll(todosJsonList.map((json) => userModel.fromJson(jsonDecode(json))));
      filterData();
    }
  }

  void addData(String title) {
    int userId = DateTime.now().millisecondsSinceEpoch;
    userModel newTodo = userModel(
      userId: userId,
      id: listData.isEmpty ? 1 : listData.last.id! + 1,
      title: title,
      completed: false,
    );
    listData.add(newTodo);
    saveTodos();
    filterData();
  }

  void fetchTodos() async {
    try {
      loading(true);
      var response = await Dio().get(
        'https://jsonplaceholder.typicode.com/todos?_page=${page.value}&_limit=50',
      );
      List<userModel> fetchedTodos = (response.data as List)
          .map((json) => userModel.fromJson(json))
          .toList();
      if (page.value == 1) {
        listData.clear();
        filteredTodos.clear();
      }
      listData.addAll(fetchedTodos);
      filterData();
    } catch (e) {
      print(e);
    } finally {
      loading(false);
    }
  }

  void filterData() {
    final searchQuery = searchText.value.toLowerCase();
    if (searchQuery.isNotEmpty) {
      final result = listData.where((todo) => todo.title!.toLowerCase().contains(searchQuery));
      filteredTodos.assignAll(result);
    } else {
      filteredTodos.assignAll(listData);
    }
  }


  void dataCompletion(int index) {
    listData[index].completed = !listData[index].completed!;
    saveTodos();
    filteredTodos.refresh();
  }
}
