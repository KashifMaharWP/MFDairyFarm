import 'dart:convert';
import 'dart:developer';
import 'package:dairyfarmflow/API/global_api.dart';
import 'package:dairyfarmflow/Model/feedInventory.dart';
import 'package:dairyfarmflow/Model/feed_count.dart';
import 'package:dairyfarmflow/Model/feed_inventory.dart';
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
  int feedTotal=0;
  int feedAvailable=0;
  int feedUsed=0;
  String? feedId;
  InventoryFeedResponse? feedInventory;
  

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
        ;
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

  fetchFeed(BuildContext context, String month) async {
    _isloading = true;
  var headers = {
    'Authorization':
        'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
  };
  var request = http.Request(
    'GET',
    Uri.parse('${GlobalApi.baseApi}${GlobalApi.feedInventory}$month'),
  );

  request.headers.addAll(headers);
  //debugger();
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final jsonString = await response.stream.bytesToString();
    final jsonData = json.decode(jsonString);
    InventoryFeedResponse feedInventoryResponse= InventoryFeedResponse.fromJson(jsonData);
    feedInventory=feedInventoryResponse;
   feedTotal=feedInventory!.feedInventory.totalAmount;
   feedAvailable=feedInventory!.feedInventory.availableAmount;
    feedUsed=feedTotal-feedAvailable;
    feedId=feedInventory!.feedInventory.id;
   // totalFeedStored=feedInventory.feedInventory!.feedAmount;
    _isloading = false;
    notifyListeners();
  } 
  //debugger();
}

  // Fetch feed count
  // Fetch feed count
  fetchFeedCount(BuildContext context, String formattedDate) async {
    _isloading = true;
    notifyListeners();

    final headers = {
      'Authorization':
          'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
    };

    // Assuming the API now accepts a full date (e.g., "Wed Jan 22 2025") in the URL
    final url = Uri.parse(
        '${GlobalApi.baseApi}${GlobalApi.getFeedConsumptionCount}$formattedDate');

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        FeedCountResponse feedCount = FeedCountResponse.fromJson(jsonData);

        // Assuming todayFeedConsumptionCount contains data for the specified date
        morningFeed = feedCount.todayFeedConsumptionCount[0].morning;
        eveningFeed = feedCount.todayFeedConsumptionCount[0].evening;
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
      'morning': double.parse(morning),
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
      'evening': double.parse(evening),
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
    required double feedAmount,
    required BuildContext context,
   required String Date,
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
      'totalAmount': feedAmount,
      "date":Date

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


  // Add feed inventory amount
  Future<void> UpdateInventory({
    required int feedAmount,
    required String id,
    required BuildContext context,
  }) async {
   // _isloading = true;
    notifyListeners();

    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.UpdateFeedInventory}$id');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
    };

    final body = jsonEncode({
      'addAmount': feedAmount,
    });
    //debugger();
    try {
      final response = await http.patch(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final message = jsonDecode(response.body);
        
        SimpleToast.showSuccessToast(
            context, "Feed Added", "${message['message']}");
      }
     // _isloading = false;
      notifyListeners();
    } catch (e) {
      SimpleToast.showErrorToast(context, "Error occurred", "$e");
    //  _isloading = false;
      notifyListeners();
    }
  }


   DeleteFeed(
     String feedId,
    BuildContext context,
  ) async {
    _isloading = true;
    notifyListeners();

    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.deleteFeedConsumption}$feedId');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
    };

    

    try {
      final response = await http.delete(url, headers: headers,);

      if (response.statusCode == 200) {
       
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
