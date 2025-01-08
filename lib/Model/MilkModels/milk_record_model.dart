class MilkRecordModel {
  bool? success;
  String? message;
  List<MilkProductionMonthlyRecord>? milkProductionMonthlyRecord;

  MilkRecordModel(
      {this.success, this.message, this.milkProductionMonthlyRecord});

  MilkRecordModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['milkProductionMonthlyRecord'] != null) {
      milkProductionMonthlyRecord = <MilkProductionMonthlyRecord>[];
      json['milkProductionMonthlyRecord'].forEach((v) {
        milkProductionMonthlyRecord!
            .add(new MilkProductionMonthlyRecord.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.milkProductionMonthlyRecord != null) {
      data['milkProductionMonthlyRecord'] =
          this.milkProductionMonthlyRecord!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MilkProductionMonthlyRecord {
  String? sId;
  String? cowId;
  int? morning;
  int? evening;
  int? total;
  String? date;
  CreatedBy? createdBy;
  Cow? cow;

  MilkProductionMonthlyRecord(
      {this.sId,
      this.cowId,
      this.morning,
      this.evening,
      this.total,
      this.date,
      this.createdBy,
      this.cow});

  MilkProductionMonthlyRecord.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cowId = json['cowId'];
    morning = json['morning'];
    evening = json['evening'];
    total = json['total'];
    date = json['date'];
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
    cow = json['cow'] != null ? new Cow.fromJson(json['cow']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['cowId'] = this.cowId;
    data['morning'] = this.morning;
    data['evening'] = this.evening;
    data['total'] = this.total;
    data['date'] = this.date;
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    if (this.cow != null) {
      data['cow'] = this.cow!.toJson();
    }
    return data;
  }
}

class CreatedBy {
  String? name;
  String? sId;

  CreatedBy({this.name, this.sId});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['_id'] = this.sId;
    return data;
  }
}

class Cow {
  int? animalNumber;
  String? sId;
  String? image;

  Cow({this.animalNumber, this.sId, this.image});

  Cow.fromJson(Map<String, dynamic> json) {
    animalNumber = json['animalNumber'];
    sId = json['_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['animalNumber'] = this.animalNumber;
    data['_id'] = this.sId;
    data['image'] = this.image;
    return data;
  }
}
