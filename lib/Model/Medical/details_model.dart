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
        cowMedicalRecord!.add(new CowMedicalRecord.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.cowMedicalRecord != null) {
      data['cowMedicalRecord'] =
          this.cowMedicalRecord!.map((v) => v.toJson()).toList();
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
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['date'] = this.date;
    data['vaccineType'] = this.vaccineType;
    data['dairyFarmId'] = this.dairyFarmId;
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
