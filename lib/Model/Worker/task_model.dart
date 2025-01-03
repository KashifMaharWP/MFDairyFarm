class TaskModel {
  bool? success;
  String? message;
  List<Tasks>? tasks;

  TaskModel({this.success, this.message, this.tasks});

  TaskModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(new Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tasks {
  String? sId;
  String? description;
  bool? taskStatus;
  String? createdAt;
  String? dueDate;
  AssignedTo? assignedTo;

  Tasks(
      {this.sId,
      this.description,
      this.taskStatus,
      this.createdAt,
      this.dueDate,
      this.assignedTo});

  Tasks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    taskStatus = json['taskStatus'];
    createdAt = json['createdAt'];
    dueDate = json['dueDate'];
    assignedTo = json['assignedTo'] != null
        ? new AssignedTo.fromJson(json['assignedTo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['description'] = this.description;
    data['taskStatus'] = this.taskStatus;
    data['createdAt'] = this.createdAt;
    data['dueDate'] = this.dueDate;
    if (this.assignedTo != null) {
      data['assignedTo'] = this.assignedTo!.toJson();
    }
    return data;
  }
}

class AssignedTo {
  String? name;
  String? email;
  String? sId;

  AssignedTo({this.name, this.email, this.sId});

  AssignedTo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['_id'] = this.sId;
    return data;
  }
}
