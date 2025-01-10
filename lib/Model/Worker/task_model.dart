class TaskModel {
  bool? success;
  String? message;
  List<Tasks>? tasks;

  TaskModel({this.success, this.message, this.tasks});

  TaskModel.fromJson(Map<String, dynamic> json) {
    success = json['success']??'';
    message = json['message']??'';
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
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
    sId = json['_id']??'';
    description = json['description']??'';
    taskStatus = json['taskStatus']??false;
    createdAt = json['createdAt']??'';
    dueDate = json['dueDate']??'';
    assignedTo = json['assignedTo'] != null
        ? AssignedTo.fromJson(json['assignedTo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['description'] = description;
    data['taskStatus'] = taskStatus??false;
    data['createdAt'] = createdAt;
    data['dueDate'] = dueDate;
    if (assignedTo != null) {
      data['assignedTo'] = assignedTo!.toJson();
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
    name = json['name']??'';
    email = json['email']??'';
    sId = json['_id']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['_id'] = sId;
    return data;
  }
}
