import 'pagination_model.dart';

class TaskList extends Pagination {
  TaskList({this.tasks});
  List<Tasks>? tasks;
  TaskList.fromJson(Map<String, dynamic> json) {
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(new Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Task {
  String? id;
  String? title;
  String? description;
  String? createdAt;
  String? status;

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
