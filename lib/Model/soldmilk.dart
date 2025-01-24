class SoldMilkModel {
  bool? success;
  String? message;
  List<MonthlyMilkRecord>? monthlyMilkRecord;

  SoldMilkModel({this.success, this.message, this.monthlyMilkRecord});

  SoldMilkModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['monthlyMilkRecord'] != null) {
      monthlyMilkRecord = <MonthlyMilkRecord>[];
      json['monthlyMilkRecord'].forEach((v) {
        monthlyMilkRecord!.add(MonthlyMilkRecord.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (monthlyMilkRecord != null) {
      data['monthlyMilkRecord'] =
          monthlyMilkRecord!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MonthlyMilkRecord {
  String? sId;
  int? amountSold;
  String? date;
  int? totalPayment;
  Vendor? vendor;

  MonthlyMilkRecord(
      {this.sId, this.amountSold, this.date, this.totalPayment, this.vendor});

  MonthlyMilkRecord.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    amountSold = json['amount_sold'];
    date = json['date'];
    totalPayment = json['total_payment'];
    vendor = json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['amount_sold'] = amountSold;
    data['date'] = date;
    data['total_payment'] = totalPayment;
    if (vendor != null) {
      data['vendor'] = vendor!.toJson();
    }
    return data;
  }
}

class Vendor {
  String? sId;
  String? name;
  int? iV;

  Vendor({this.sId, this.name, this.iV});

  Vendor.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['__v'] = iV;
    return data;
  }
}
