class InventoryFeedResponse {
  final String message;
  final bool success;
  final FeedInventory feedInventory;

  InventoryFeedResponse({
    required this.message,
    required this.success,
    required this.feedInventory,
  });

  factory InventoryFeedResponse.fromJson(Map<String, dynamic> json) {
    return InventoryFeedResponse(
      message: json['message'],
      success: json['success'],
      feedInventory: FeedInventory.fromJson(json['feedInventory']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
      'feedInventory': feedInventory.toJson(),
    };
  }
}

class FeedInventory {
  final String id;
  final num totalAmount;
  final num availableAmount;
  final String date;
  final String createdBy;
  final String dairyFarmId;
  final int version;

  FeedInventory({
    required this.id,
    required this.totalAmount,
    required this.availableAmount,
    required this.date,
    required this.createdBy,
    required this.dairyFarmId,
    required this.version,
  });

  factory FeedInventory.fromJson(Map<String, dynamic> json) {
    return FeedInventory(
      id: json['_id'],
      totalAmount: json['totalAmount'],
      availableAmount: json['availableAmount'],
      date: json['date'],
      createdBy: json['createdBy'],
      dairyFarmId: json['dairyFarmId'],
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'totalAmount': totalAmount,
      'availableAmount': availableAmount,
      'date': date,
      'createdBy': createdBy,
      'dairyFarmId': dairyFarmId,
      '__v': version,
    };
  }
}
