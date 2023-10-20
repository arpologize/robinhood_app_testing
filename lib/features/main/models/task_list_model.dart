import 'package:robinhood_app_testing/utils/extension/extension.dart';

class TaskList {
  TaskList({this.tasks, this.pageNumber, this.totalPages});
  int? pageNumber;
  int? totalPages;
  List<Task>? tasks;
  TaskList.fromJson(Map<String, dynamic> json) {
    if (json['tasks'] != null) {
      tasks = <Task>[];
      json['tasks'].forEach((v) {
        tasks!.add(new Task.fromJson(v));
      });
    }
    pageNumber = json['pageNumber'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    data['pageNumber'] = this.pageNumber;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Task {
  String? id;
  String? title;
  String? description;
  String? createdAt;
  String? status;

  DateTime get createdAtDate => (createdAt ?? '').toDateTime();
  Task({this.id, this.title, this.description, this.createdAt, this.status});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['createdAt'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['status'] = this.status;
    return data;
  }
}
