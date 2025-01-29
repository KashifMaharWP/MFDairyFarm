class SoldMilkModel {
  final bool? success;
  final String? message;
  final List<SoldMilkRecord>? monthlyMilkRecord;

  SoldMilkModel({
    this.success,
    this.message,
    this.monthlyMilkRecord,
  });

  factory SoldMilkModel.fromJson(Map<String, dynamic> json) {
    return SoldMilkModel(
      success: json['success'],
      message: json['message'],
      monthlyMilkRecord: (json['monthlyMilkRecord'] as List<dynamic>?)
          ?.map((record) => SoldMilkRecord.fromJson(record))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'monthlyMilkRecord':
          monthlyMilkRecord?.map((record) => record.toJson()).toList(),
    };
  }
}

class SoldMilkRecord {
  final String? id;
  final num? amountSold;
  final String? date;
  final num? totalPayment;
  final Vendor? vendor;

  SoldMilkRecord({
    this.id,
    this.amountSold,
    this.date,
    this.totalPayment,
    this.vendor,
  });

  factory SoldMilkRecord.fromJson(Map<String, dynamic> json) {
    return SoldMilkRecord(
      id: json['_id'],
      amountSold: json['amount_sold'],
      date: json['date'],
      totalPayment: json['total_payment'],
      vendor: json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'amount_sold': amountSold,
      'date': date,
      'total_payment': totalPayment,
      'vendor': vendor?.toJson(),
    };
  }
}

class Vendor {
  final String? id;
  final String? name;

  Vendor({
    this.id,
    this.name,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
