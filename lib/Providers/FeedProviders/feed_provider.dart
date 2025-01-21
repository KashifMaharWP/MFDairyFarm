import 'dart:convert';
import 'package:dairyfarmflow/API/global_api.dart';
import 'package:dairyfarmflow/Model/feed_count.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:simple_toast_message/simple_toast.dart';
import '../../Model/feed_consume.dart';

class FeedProvider extends ChangeNotifier {
  bool _isloading = false;
  bool get isLoading => _isloading;
  FeedConsumptionResponse? feedConsumeRecord;
  int? morningFeed = 0;
  int? eveningFeed = 0;
  int usedFeed = 0;
  String? errorMessage;
  int totalFeedFromItem = 0;
  int totalFeedStored = 0;

  // Fetch feed consumption data
  Future<void> fetchFeedConsumption(BuildContext context, String month) async {
    _isloading = true;
    notifyListeners(); // Notify listeners that loading has started

    try {
      final headers = {
        'Authorization':
            'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
      };
      final url = Uri.parse(
          '${GlobalApi.baseApi}${GlobalApi.getFeedConsumption}$month');
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        feedConsumeRecord = FeedConsumptionResponse.fromJson(jsonData);
        _isloading = false;
        notifyListeners(); // Notify listeners with updated data
      } else {
        _isloading = false;
        errorMessage = response.reasonPhrase;
        notifyListeners(); // Notify listeners if an error occurs
      }
    } catch (e) {
      _isloading = false;
      errorMessage = 'Error: $e';
      notifyListeners(); // Notify listeners in case of an exception
    }
  }

  // Fetch feed count
  Future<FeedCount?> fetchFeedCount(BuildContext context) async {
    _isloading = true;
    notifyListeners();

    final headers = {
      'Authorization':
          'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
    };
    final url =
        Uri.parse('${GlobalApi.baseApi}${GlobalApi.getFeedConsumptionCount}');

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        FeedCount feedCount = FeedCount.fromJson(jsonData);
        morningFeed = feedCount.todayFeedConsumtionCount![0].morning;
        eveningFeed = feedCount.todayFeedConsumtionCount![0].evening;
        usedFeed = morningFeed! + eveningFeed!;
        _isloading = false;
        notifyListeners(); // Notify listeners after fetching feed count
      } else {
        _isloading = false;
        errorMessage = response.reasonPhrase;
        notifyListeners(); // Notify listeners on failure
      }
    } catch (e) {
      _isloading = false;
      errorMessage = 'Exception occurred: $e';
      notifyListeners(); // Notify listeners in case of an exception
    }

    return null;
  }

  // Fetch feed inventory amount
  Future<int?> fetchFeed(BuildContext context) async {
    _isloading = true;
    notifyListeners();

    final headers = {
      'Authorization':
          'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
    };
    final url = Uri.parse('${GlobalApi.baseApi}feedInventory/feedAmount');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      _isloading = false;
      notifyListeners();
      return int.tryParse(jsonData['feedInventory']['feedAmount'].toString());
    } else {
      _isloading = false;
      errorMessage = response.reasonPhrase;
      notifyListeners(); // Notify listeners on failure
      return null;
    }
  }

  // Send morning feed data
  Future<void> sendMorningFeedData({
    required String cowId,
    required String date,
    required String morning,
    required BuildContext context,
  }) async {
    _isloading = true;
    notifyListeners();

    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.addMorningFeed}');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
    };

    final body = jsonEncode({
      'cowId': cowId,
      'date': date,
      'morning': int.parse(morning),
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        final message = jsonDecode(response.body);
        SimpleToast.showSuccessToast(
            context, "Feed Added", "${message['message']}");
      } else {
        final message = jsonDecode(response.body);
        SimpleToast.showInfoToast(
            context, "Feed Already Added", "${message['message']}");
      }
      _isloading = false;
      notifyListeners();
    } catch (e) {
      SimpleToast.showErrorToast(context, "Error occurred", "$e");
      _isloading = false;
      notifyListeners();
    }
  }

  // Send evening feed data
  Future<void> sendEveningFeedData({
    required String cowId,
    required String date,
    required String evening,
    required BuildContext context,
  }) async {
    _isloading = true;
    notifyListeners();

    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.addEveningFeed}');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
    };

    final body = jsonEncode({
      'cowId': cowId,
      'date': date,
      'evening': int.parse(evening),
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        final message = jsonDecode(response.body);
        SimpleToast.showSuccessToast(
            context, "Feed Added", "${message['message']}");
      } else {
        final message = jsonDecode(response.body);
        SimpleToast.showInfoToast(
            context, "Feed Already Added", "${message['message']}");
      }
      _isloading = false;
      notifyListeners();
    } catch (e) {
      SimpleToast.showErrorToast(context, "Error occurred", "$e");
      _isloading = false;
      notifyListeners();
    }
  }

  // Add feed inventory amount
  Future<void> addFeedInventory({
    required int feedAmount,
    required BuildContext context,
  }) async {
    _isloading = true;
    notifyListeners();

    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.addFeedAmount}');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
    };

    final body = jsonEncode({
      'feedAmount': feedAmount,
    });

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final message = jsonDecode(response.body);
        SimpleToast.showSuccessToast(
            context, "Feed Added", "${message['message']}");
      } else {
        final message = jsonDecode(response.body);
        SimpleToast.showErrorToast(
            context, "Feed Not Added", "${message['message']}");
      }
      _isloading = false;
      notifyListeners();
    } catch (e) {
      SimpleToast.showErrorToast(context, "Error occurred", "$e");
      _isloading = false;
      notifyListeners();
    }
  }
}
