class FeedConsumption {
  final String? id;
  final int? morning;
  final int? evening;
  final int? total;
  final String? date;
  final CreatedBy? createdBy;

  FeedConsumption({
    this.id,
    this.morning,
    this.evening,
    this.total,
    this.date,
    this.createdBy,
  });

  factory FeedConsumption.fromJson(Map<String, dynamic> json) {
    return FeedConsumption(
      id: json['_id'],
      morning: json['morning'],
      evening: json['evening'],
      total: json['total'],
      date: json['date'],
      createdBy: json['createdBy'] != null
          ? CreatedBy.fromJson(json['createdBy'])
          : null,
    );
  }
}

class CreatedBy {
  final String? name;
  final String? id;

  CreatedBy({this.name, this.id});

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      name: json['name'],
      id: json['_id'],
    );
  }
}
