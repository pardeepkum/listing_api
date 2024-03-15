import 'dart:convert';

class userModel {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  userModel({this.userId, this.id, this.title, this.completed});

  factory userModel.fromJson(Map<String, dynamic> json) {
    return userModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'completed': completed,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
