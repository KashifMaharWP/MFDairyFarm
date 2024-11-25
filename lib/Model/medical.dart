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
  final String id;
  final String date;
  final String vaccineType;
  final String dairyFarmId;
  final CreatedBy createdBy;
  final Cow cow;

  MonthlyMedicalRecord({
    required this.id,
    required this.date,
    required this.vaccineType,
    required this.dairyFarmId,
    required this.createdBy,
    required this.cow,
  });

  factory MonthlyMedicalRecord.fromJson(Map<String, dynamic> json) {
    return MonthlyMedicalRecord(
      id: json['_id'],
      date: json['date'],
      vaccineType: json['vaccineType'],
      dairyFarmId: json['dairyFarmId'],
      createdBy: CreatedBy.fromJson(json['createdBy']),
      cow: Cow.fromJson(json['cow']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'date': date,
      'vaccineType': vaccineType,
      'dairyFarmId': dairyFarmId,
      'createdBy': createdBy.toJson(),
      'cow': cow.toJson(),
    };
  }
}

class CreatedBy {
  final String name;
  final String id;

  CreatedBy({
    required this.name,
    required this.id,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      name: json['name'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      '_id': id,
    };
  }
}

class Cow {
  final int animalNumber;
  final String id;
  final String image;

  Cow({
    required this.animalNumber,
    required this.id,
    required this.image,
  });

  factory Cow.fromJson(Map<String, dynamic> json) {
    return Cow(
      animalNumber: json['animalNumber'],
      id: json['_id'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'animalNumber': animalNumber,
      '_id': id,
      'image': image,
    };
  }
}
