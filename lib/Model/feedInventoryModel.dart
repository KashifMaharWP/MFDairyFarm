class FeedInventoryModel {
  final String id;
  final double totalAmount;
  final double availableAmount;
  final String date;
  final String createdBy;
  final String dairyFarmId;
  final List<FeedHistory> history;

  FeedInventoryModel({
    required this.id,
    required this.totalAmount,
    required this.availableAmount,
    required this.date,
    required this.createdBy,
    required this.dairyFarmId,
    required this.history,
  });

  factory FeedInventoryModel.fromJson(Map<String, dynamic> json) {
    return FeedInventoryModel(
      id: json['_id'],
      totalAmount: (json['totalAmount'] as num).toDouble(),
      availableAmount: (json['availableAmount'] as num).toDouble(),
      date: json['date'],
      createdBy: json['createdBy'],
      dairyFarmId: json['dairyFarmId'],
      history: (json['history'] as List)
          .map((item) => FeedHistory.fromJson(item))
          .toList(),
    );
  }
}

class FeedHistory {
  final String date;
  final double changeAmount;
  final double updatedAmount;
  final String action;
  final String modifiedBy;
  final String id;

  FeedHistory({
    required this.date,
    required this.changeAmount,
    required this.updatedAmount,
    required this.action,
    required this.modifiedBy,
    required this.id,
  });

  factory FeedHistory.fromJson(Map<String, dynamic> json) {
    return FeedHistory(
      date: json['date'],
      changeAmount: (json['changeAmount'] as num).toDouble(),
      updatedAmount: (json['updatedAmount'] as num).toDouble(),
      action: json['action'],
      modifiedBy: json['modifiedBy'],
      id: json['_id'],
    );
  }
}
