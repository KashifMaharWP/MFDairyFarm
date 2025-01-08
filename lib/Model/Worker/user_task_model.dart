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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['description'] = this.description;
    data['taskStatus'] = this.taskStatus;
    data['assignedTo'] = this.assignedTo;
    data['createdAt'] = this.createdAt;
    data['dueDate'] = this.dueDate;
    data['dairyFarmId'] = this.dairyFarmId;
    data['__v'] = this.iV;
    return data;
  }
}
