class FeedCount {
  bool? success;
  String? message;
  List<TodayFeedConsumtionCount>? todayFeedConsumtionCount;

  FeedCount({this.success, this.message, this.todayFeedConsumtionCount});

  FeedCount.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['todayFeedConsumtionCount'] != null) {
      todayFeedConsumtionCount = <TodayFeedConsumtionCount>[];
      json['todayFeedConsumtionCount'].forEach((v) {
        todayFeedConsumtionCount!.add(new TodayFeedConsumtionCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.todayFeedConsumtionCount != null) {
      data['todayFeedConsumtionCount'] =
          this.todayFeedConsumtionCount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TodayFeedConsumtionCount {
  Null? nId;
  int? morning;
  int? evening;

  TodayFeedConsumtionCount({this.nId, this.morning, this.evening});

  TodayFeedConsumtionCount.fromJson(Map<String, dynamic> json) {
    nId = json['_id'];
    morning = json['morning'];
    evening = json['evening'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.nId;
    data['morning'] = this.morning;
    data['evening'] = this.evening;
    return data;
  }
}
