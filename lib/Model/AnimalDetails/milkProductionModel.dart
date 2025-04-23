class CowDetailsResponse {
  final List<MilkRecord>? milkRecords;
  final num? milkCount;
  final List<FeedRecord>? feedRecords;
  final num? feedConsumptionCount;
  final List<MedicalRecord>? medicalRecords;
  final num? vaccinationCount;

  CowDetailsResponse({
    this.milkRecords,
    this.milkCount,
    this.feedRecords,
    this.feedConsumptionCount,
    this.medicalRecords,
    this.vaccinationCount,
  });

  factory CowDetailsResponse.fromJson(Map<String, dynamic> json) {
  final data = json['data']; // Extracting "data" first

  return CowDetailsResponse(
    milkRecords: data['milk']?['milkProductionRecordByCowIdBetweenTwoDates'] != null
        ? (data['milk']['milkProductionRecordByCowIdBetweenTwoDates'] as List)
            .map((e) => MilkRecord.fromJson(e))
            .toList()
        : null,
    milkCount: data['milk']?['milkCount'],

    feedRecords: data['feedConsumtion']?['feedConsumtionRecordBetweenTwoDatesByCowId'] != null
        ? (data['feedConsumtion']['feedConsumtionRecordBetweenTwoDatesByCowId'] as List)
            .map((e) => FeedRecord.fromJson(e))
            .toList()
        : null,
    feedConsumptionCount: (data['feedConsumtion']?['feedConsumtionCount'] as num?)?.toDouble(),

    medicalRecords: data['medical']?['cowMedicalRecordBetweenTwoDates'] != null
        ? (data['medical']['cowMedicalRecordBetweenTwoDates'] as List)
            .map((e) => MedicalRecord.fromJson(e))
            .toList()
        : null,
    vaccinationCount: data['medical']?['vaccinationCount'],
  );
}
}

class MilkRecord {
  final String id;
  final double morning;
  final double evening;
  final double total;
  final String date;

  MilkRecord({
    required this.id,
    required this.morning,
    required this.evening,
    required this.total,
    required this.date,
  });

  factory MilkRecord.fromJson(Map<String, dynamic> json) {
    return MilkRecord(
      id: json['_id'],
      morning: (json['morning'] as num).toDouble(),
      evening: (json['evening'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      date: json['date'],
    );
  }
}

class FeedRecord {
  final String id;
  final double morning;
  final double evening;
  final double total;
  final String date;

  FeedRecord({
    required this.id,
    required this.morning,
    required this.evening,
    required this.total,
    required this.date,
  });

  factory FeedRecord.fromJson(Map<String, dynamic> json) {
    return FeedRecord(
      id: json['_id'],
      morning: (json['morning'] as num).toDouble(),
      evening: (json['evening'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      date: json['date'],
    );
  }
}

class MedicalRecord {
  final String id;
  final String date;
  final String vaccineType;

  MedicalRecord({
    required this.id,
    required this.date,
    required this.vaccineType,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      id: json['_id'],
      date: json['date'],
      vaccineType: json['vaccineType'],
    );
  }
}
