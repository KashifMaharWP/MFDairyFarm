class FeedInventoryResponse {
  final String message;
  final bool success;
  final FeedInventory feedInventory;

  FeedInventoryResponse({
    required this.message,
    required this.success,
    required this.feedInventory,
  });

  // Factory constructor to create an instance from JSON
  factory FeedInventoryResponse.fromJson(Map<String, dynamic> json) {
    return FeedInventoryResponse(
      message: json['message'],
      success: json['success'],
      feedInventory: FeedInventory.fromJson(json['feedInventory']),
    );
  }

  // Convert an instance to JSON
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
  final int feedAmount;
  final String createdBy;
  final String dairyFarmId;
  final int v;

  FeedInventory({
    required this.id,
    required this.feedAmount,
    required this.createdBy,
    required this.dairyFarmId,
    required this.v,
  });

  // Factory constructor to create an instance from JSON
  factory FeedInventory.fromJson(Map<String, dynamic> json) {
    return FeedInventory(
      id: json['_id'],
      feedAmount: json['feedAmount'],
      createdBy: json['createdBy'],
      dairyFarmId: json['dairyFarmId'],
      v: json['__v'],
    );
  }

  // Convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'feedAmount': feedAmount,
      'createdBy': createdBy,
      'dairyFarmId': dairyFarmId,
      '__v': v,
    };
  }
}
