class MedicalRecordResponse {
  final bool success;
  final String message;
  final List<MonthlyMedicalRecord> monthlyMedicalRecords;

  MedicalRecordResponse({
    required this.success,
    required this.message,
    required this.monthlyMedicalRecords,
  });

  factory MedicalRecordResponse.fromJson(Map<String, dynamic> json) {
    return MedicalRecordResponse(
      success: json['success'],
      message: json['message'],
      monthlyMedicalRecords: (json['monthlyMedicalRecord'] as List)
          .map((record) => MonthlyMedicalRecord.fromJson(record))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'monthlyMedicalRecord':
          monthlyMedicalRecords.map((record) => record.toJson()).toList(),
    };
  }
}

class MonthlyMedicalRecord {
  final Cow cow;
  final int totalVaccine;
  final List<MedicalRecord> medicalRecords;

  MonthlyMedicalRecord({
    required this.cow,
    required this.totalVaccine,
    required this.medicalRecords,
  });

  factory MonthlyMedicalRecord.fromJson(Map<String, dynamic> json) {
    return MonthlyMedicalRecord(
      cow: Cow.fromJson(json['cow']),
      totalVaccine: json['totalVaccine'],
      medicalRecords: (json['medicalRecords'] as List)
          .map((record) => MedicalRecord.fromJson(record))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cow': cow.toJson(),
      'totalVaccine': totalVaccine,
      'medicalRecords': medicalRecords.map((record) => record.toJson()).toList(),
    };
  }
}

class MedicalRecord {
  final String id;
  final String cowId;
  final String date;
  final String vaccineType;
  final String dairyFarmId;
  final String createdBy;
  final int version;

  MedicalRecord({
    required this.id,
    required this.cowId,
    required this.date,
    required this.vaccineType,
    required this.dairyFarmId,
    required this.createdBy,
    required this.version,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      id: json['_id'],
      cowId: json['cowId'],
      date: json['date'],
      vaccineType: json['vaccineType'],
      dairyFarmId: json['dairyFarmId'],
      createdBy: json['createdBy'],
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'cowId': cowId,
      'date': date,
      'vaccineType': vaccineType,
      'dairyFarmId': dairyFarmId,
      'createdBy': createdBy,
      '__v': version,
    };
  }
}

class Cow {
  final String id;
  final int animalNumber;
  final String image;

  Cow({
    required this.id,
    required this.animalNumber,
    required this.image,
  });

  factory Cow.fromJson(Map<String, dynamic> json) {
    return Cow(
      id: json['_id'],
      animalNumber: json['animalNumber'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'animalNumber': animalNumber,
      'image': image,
    };
  }
}
