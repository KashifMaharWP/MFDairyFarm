class VendorMilkSaleListResponse {
  final bool success;
  final String message;
  final List<MilkSaleRecord> milkSaleRecords;

  VendorMilkSaleListResponse({
    required this.success,
    required this.message,
    required this.milkSaleRecords,
  });

  factory VendorMilkSaleListResponse.fromJson(Map<String, dynamic> json) {
    return VendorMilkSaleListResponse(
      success: json['success'],
      message: json['message'],
      milkSaleRecords: (json['milkSaleRecordBetweenTwoDatesByVendorId'] ?? json['monthlyMilkRecord'] ?? [])
          .map<MilkSaleRecord>((e) => MilkSaleRecord.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'milkSaleRecordBetweenTwoDatesByVendorId': milkSaleRecords.map((e) => e.toJson()).toList(),
    };
  }
}

class MilkSaleRecord {
  final String id;
  final String vendorId;
  final num amountSold;
  final String date;
  final num totalPayment;
  final String dairyFarmId;

  MilkSaleRecord({
    required this.id,
    required this.vendorId,
    required this.amountSold,
    required this.date,
    required this.totalPayment,
    required this.dairyFarmId,
  });

  factory MilkSaleRecord.fromJson(Map<String, dynamic> json) {
    return MilkSaleRecord(
      id: json['_id'] ?? '',
      vendorId: json['vendorId'] ?? '',
      amountSold: json['amount_sold'] ?? 0,
      date: json['date'] ?? '',
      totalPayment: json['total_payment'] ?? 0,
      dairyFarmId: json['dairyFarmId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'vendorId': vendorId,
      'amount_sold': amountSold,
      'date': date,
      'total_payment': totalPayment,
      'dairyFarmId': dairyFarmId,
    };
  }
}
