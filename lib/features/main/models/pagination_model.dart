abstract class Pagination {
  int? pageNumber;
  int? totalPages;

  Pagination({this.pageNumber, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNumber'] = this.pageNumber;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Tasks {
  String? id;
  String? title;
  String? description;
  String? createdAt;
  String? status;

  Tasks({this.id, this.title, this.description, this.createdAt, this.status});

  Tasks.fromJson(Map<String, dynamic> json) {
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
