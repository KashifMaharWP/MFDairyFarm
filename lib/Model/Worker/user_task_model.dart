class UserTaskModel {
  bool? success;
  String? message;
  List<Tasks>? tasks;

  UserTaskModel({this.success, this.message, this.tasks});

  UserTaskModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
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
  String? assignedTo;
  String? createdAt;
  String? dueDate;
  String? dairyFarmId;
  int? iV;

  Tasks(
      {this.sId,
      this.description,
      this.taskStatus,
      this.assignedTo,
      this.createdAt,
      this.dueDate,
      this.dairyFarmId,
      this.iV});

  Tasks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    taskStatus = json['taskStatus'];
    assignedTo = json['assignedTo'];
    createdAt = json['createdAt'];
    dueDate = json['dueDate'];
    dairyFarmId = json['dairyFarmId'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['description'] = description;
    data['taskStatus'] = taskStatus;
    data['assignedTo'] = assignedTo;
    data['createdAt'] = createdAt;
    data['dueDate'] = dueDate;
    data['dairyFarmId'] = dairyFarmId;
    data['__v'] = iV;
    return data;
  }
}
