class MedicalDetailModel {
  bool? success;
  String? message;
  List<CowMedicalRecord>? cowMedicalRecord;

  MedicalDetailModel({this.success, this.message, this.cowMedicalRecord});

  MedicalDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['cowMedicalRecord'] != null) {
      cowMedicalRecord = <CowMedicalRecord>[];
      json['cowMedicalRecord'].forEach((v) {
        cowMedicalRecord!.add(CowMedicalRecord.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (cowMedicalRecord != null) {
      data['cowMedicalRecord'] =
          cowMedicalRecord!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CowMedicalRecord {
  String? sId;
  String? date;
  String? vaccineType;
  String? dairyFarmId;
  CreatedBy? createdBy;

  CowMedicalRecord(
      {this.sId,
      this.date,
      this.vaccineType,
      this.dairyFarmId,
      this.createdBy});

  CowMedicalRecord.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    date = json['date'];
    vaccineType = json['vaccineType'];
    dairyFarmId = json['dairyFarmId'];
    createdBy = json['createdBy'] != null
        ? CreatedBy.fromJson(json['createdBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['date'] = date;
    data['vaccineType'] = vaccineType;
    data['dairyFarmId'] = dairyFarmId;
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
