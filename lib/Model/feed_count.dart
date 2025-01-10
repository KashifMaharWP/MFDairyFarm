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
        todayFeedConsumtionCount!.add(TodayFeedConsumtionCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (todayFeedConsumtionCount != null) {
      data['todayFeedConsumtionCount'] =
          todayFeedConsumtionCount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TodayFeedConsumtionCount {
  Null nId;
  int? morning;
  int? evening;

  TodayFeedConsumtionCount({this.nId, this.morning, this.evening});

  TodayFeedConsumtionCount.fromJson(Map<String, dynamic> json) {
    nId = json['_id'];
    morning = json['morning'];
    evening = json['evening'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = nId;
    data['morning'] = morning;
    data['evening'] = evening;
    return data;
  }
}
