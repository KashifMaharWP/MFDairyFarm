class TodayMilkRecord {
  final String id;
  final String cowId;
  final num morning;
  final String date;
  final CreatedBy createdBy;
  final num evening;
  final num total;
  final Cow cow;

  TodayMilkRecord({
    required this.id,
    required this.cowId,
    required this.morning,
    required this.date,
    required this.createdBy,
    required this.evening,
    required this.total,
    required this.cow,
  });

  factory TodayMilkRecord.fromJson(Map<String, dynamic> json) {
    return TodayMilkRecord(
      id: json['_id'],
      cowId: json['cowId'],
      morning: json['morning'],
      date: json['date'],
      createdBy: CreatedBy.fromJson(json['createdBy']),
      evening: json['evening'],
      total: json['total'],
      cow: Cow.fromJson(json['cow']),
    );
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
}
