class AnimalDetailModel {
  bool? success;
  String? message;
  List<MilkProductionMonthlyRecord>? milkProductionMonthlyRecord;
  num? milkCount;

  AnimalDetailModel(
      {this.success,
      this.message,
      this.milkProductionMonthlyRecord,
      this.milkCount});

  AnimalDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['milkProductionMonthlyRecord'] != null) {
      milkProductionMonthlyRecord = <MilkProductionMonthlyRecord>[];
      json['milkProductionMonthlyRecord'].forEach((v) {
        milkProductionMonthlyRecord!
            .add(MilkProductionMonthlyRecord.fromJson(v));
      });
    }
    milkCount = json['milkCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (milkProductionMonthlyRecord != null) {
      data['milkProductionMonthlyRecord'] =
          milkProductionMonthlyRecord!.map((v) => v.toJson()).toList();
    }
    data['milkCount'] = milkCount;
    return data;
  }
}

class MilkProductionMonthlyRecord {
  String? sId;
  num? morning;
  num? evening;
  num? total;
  String? date;
  CreatedBy? createdBy;

  MilkProductionMonthlyRecord(
      {this.sId,
      this.morning,
      this.evening,
      this.total,
      this.date,
      this.createdBy});

  MilkProductionMonthlyRecord.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    morning = json['morning'];
    evening = json['evening'];
    total = json['total'];
    date = json['date'];
    createdBy = json['createdBy'] != null
        ? CreatedBy.fromJson(json['createdBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['morning'] = morning;
    data['evening'] = evening;
    data['total'] = total;
    data['date'] = date;
    if (createdBy != null) {
      data['createdBy'] = createdBy!.toJson();
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
