class FeedCountResponse {
  final bool success;
  final String message;
  final List<FeedConsumptionCount> todayFeedConsumptionCount;

  FeedCountResponse({
    required this.success,
    required this.message,
    required this.todayFeedConsumptionCount,
  });

  factory FeedCountResponse.fromJson(Map<String, dynamic> json) {
    return FeedCountResponse(
      success: json['success'],
      message: json['message'],
      todayFeedConsumptionCount: (json['todayFeedConsumtionCount'] as List)
          .map((item) => FeedConsumptionCount.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'todayFeedConsumtionCount':
          todayFeedConsumptionCount.map((item) => item.toJson()).toList(),
    };
  }
}

class FeedConsumptionCount {
  final String? id;
  final int morning;
  final int evening;

  FeedConsumptionCount({
    this.id,
    required this.morning,
    required this.evening,
  });

  factory FeedConsumptionCount.fromJson(Map<String, dynamic> json) {
    return FeedConsumptionCount(
      id: json['_id'],
      morning: json['morning'],
      evening: json['evening'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'morning': morning,
      'evening': evening,
    };
  }
}
