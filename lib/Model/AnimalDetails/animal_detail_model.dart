class AnimalDetailModel {
  bool? success;
  String? message;
  List<MilkProductionMonthlyRecord>? milkProductionMonthlyRecord;
  int? milkCount;

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
            .add(new MilkProductionMonthlyRecord.fromJson(v));
      });
    }
    milkCount = json['milkCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.milkProductionMonthlyRecord != null) {
      data['milkProductionMonthlyRecord'] =
          this.milkProductionMonthlyRecord!.map((v) => v.toJson()).toList();
    }
    data['milkCount'] = this.milkCount;
    return data;
  }
}

class MilkProductionMonthlyRecord {
  String? sId;
  int? morning;
  int? evening;
  int? total;
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
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['morning'] = this.morning;
    data['evening'] = this.evening;
    data['total'] = this.total;
    data['date'] = this.date;
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
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
