class TodayMilkCountResponse {
  final bool success;
  final String message;
  final List<MilkCount> todayMilkCount;

  TodayMilkCountResponse({
    required this.success,
    required this.message,
    required this.todayMilkCount,
  });

  factory TodayMilkCountResponse.fromJson(Map<String, dynamic> json) {
    return TodayMilkCountResponse(
      success: json['success'],
      message: json['message'],
      todayMilkCount: (json['todayMilkCount'] as List)
          .map((data) => MilkCount.fromJson(data))
          .toList(),
    );
  }
}

class MilkCount {
  final String? id;
  final int morning;
  final int evening;

  MilkCount({
    this.id,
    required this.morning,
    required this.evening,
  });

  factory MilkCount.fromJson(Map<String, dynamic> json) {
    return MilkCount(
      id: json['_id'],
      morning: json['morning'],
      evening: json['evening'],
    );
  }
}
