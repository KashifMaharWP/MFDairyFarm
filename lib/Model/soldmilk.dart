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
  String? vendorName;
  int? amountSold;
  String? date;
  int? totalPayment;
  String? dairyFarmId;
  int? iV;

  MonthlyMilkRecord(
      {this.sId,
      this.vendorName,
      this.amountSold,
      this.date,
      this.totalPayment,
      this.dairyFarmId,
      this.iV});

  MonthlyMilkRecord.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vendorName = json['vendorName'];
    amountSold = json['amount_sold'];
    date = json['date'];
    totalPayment = json['total_payment'];
    dairyFarmId = json['dairyFarmId'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['vendorName'] = vendorName;
    data['amount_sold'] = amountSold;
    data['date'] = date;
    data['total_payment'] = totalPayment;
    data['dairyFarmId'] = dairyFarmId;
    data['__v'] = iV;
    return data;
  }
}
