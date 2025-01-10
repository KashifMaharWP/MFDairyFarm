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
            .add(MilkProductionMonthlyRecord.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (milkProductionMonthlyRecord != null) {
      data['milkProductionMonthlyRecord'] =
          milkProductionMonthlyRecord!.map((v) => v.toJson()).toList();
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
        ? CreatedBy.fromJson(json['createdBy'])
        : null;
    cow = json['cow'] != null ? Cow.fromJson(json['cow']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['cowId'] = cowId;
    data['morning'] = morning;
    data['evening'] = evening;
    data['total'] = total;
    data['date'] = date;
    if (createdBy != null) {
      data['createdBy'] = createdBy!.toJson();
    }
    if (cow != null) {
      data['cow'] = cow!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['_id'] = sId;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['animalNumber'] = animalNumber;
    data['_id'] = sId;
    data['image'] = image;
    return data;
  }
}
