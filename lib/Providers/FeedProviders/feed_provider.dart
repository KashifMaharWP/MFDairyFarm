import 'dart:convert';
import 'dart:developer';
import 'package:dairyfarmflow/API/global_api.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:simple_toast_message/simple_toast.dart';
import '../../Model/feed_consume.dart';

class FeedProvider extends ChangeNotifier {
  bool _isloading = false;
  bool get isLoading => _isloading;
  //bool isloading = false;

  String? errorMessage;
  int totalFeedFromItem = 0;
  int totalFeedStored = 0;

  List<FeedConsumption>? feedConsumptions;

  Future<void> fetchFeedConsumption(BuildContext context,String Date) async {
    _isloading = true;
    //notifyListeners();

    final headers = {
      'Authorization':
          'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
    };
    final url =
        Uri.parse('${GlobalApi.baseApi}${GlobalApi.getFeedConsumption}$Date');
    final response = await http.get(url, headers: headers);
//debugger();
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['success'] == true) {
        feedConsumptions = (jsonData['feedConsumtion'] as List)
            .map((item) => FeedConsumption.fromJson(item))
            .toList();

        // Calculate total feed used
        totalFeedFromItem = feedConsumptions!.fold<dynamic>(
          0,
          (sum, feed) => sum + feed.total,
        );
      } else {
        errorMessage = jsonData['message'];
      }
    } else {
      errorMessage = response.reasonPhrase;
    }

    _isloading = false;
    notifyListeners();
  }

  Future<int?> fetchFeed(BuildContext context) async {
    final headers = {
      'Authorization':
          'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
    };
    final url = Uri.parse('${GlobalApi.baseApi}feedInventory/feedAmount');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return int.tryParse(jsonData['feedInventory']['feedAmount'].toString());
    } else {
      errorMessage = response.reasonPhrase;
      notifyListeners();
      return null;
    }
  }

  Future<void> sendMorningFeedData(
      {
        required String cowId,
        required String date,
      required String morning,
      required BuildContext context}) async {
    _isloading = true;
    notifyListeners();
    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.addMorningFeed}');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
    };

    final body = jsonEncode({
      'cowId': cowId,
      'date': date,
      'morning': int.parse(morning),
    });
    print(jsonDecode(body));

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        final message = jsonDecode(response.body);
         print(message['message']);
        SimpleToast.showSuccessToast(
            context, "Feed Added", "${message['message']}");
        _isloading = false;
        notifyListeners();
        // showSuccessSnackbar(message['message'], context);
      } else {
        final message = jsonDecode(response.body);
         print(message['message']);
        SimpleToast.showInfoToast(
            context, "Feed Already Added", "${message['message']}");
        _isloading = false;
        notifyListeners();
        //showErrorSnackbar(message['message'], context);
      }
    } catch (e) {
      SimpleToast.showErrorToast(context, "Error occurred", "$e");
      _isloading = false;
      notifyListeners();
      //showErrorSnackbar("An error occurred: $e", context);
    }
  }

  Future<void> sendEveningFeedData(
      {
        required String cowId,
        required String date,
      required String evening,
      required BuildContext context}) async {
    _isloading = true;
    notifyListeners();
    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.addEveningFeed}');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
    };

    final body = jsonEncode({
      'cowId':cowId,
      'date': date,
      'evening': int.parse(evening),
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        final message = jsonDecode(response.body);
         print(message['message']);
        SimpleToast.showSuccessToast(
            context, "Feed Added", "${message['message']}");
        _isloading = false;
        notifyListeners();
        //showSuccessSnackbar(message["message"], context);
      } else {
        final message = jsonDecode(response.body);
        print(message['message']);
        SimpleToast.showInfoToast(
            context, "Feed Already Added", "${message['message']}");
        _isloading = false;
        notifyListeners();
        // showErrorSnackbar(
        //     "Failed to send data. Status code: ${response.statusCode}",
        //     context);
      }
    } catch (e) {
      SimpleToast.showErrorToast(context, "An Error occurred", "$e");
      _isloading = false;
      notifyListeners();
      //showErrorSnackbar("An error occurred: $e", context);
    }
  }

  Future<void> addFeedInventory(
      {required int feedAmount, required BuildContext context}) async {
    _isloading = true;
    notifyListeners();
    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.addFeedAmount}');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
    };

    final body = jsonEncode({
      'feedAmount': feedAmount,
    });
    // print(jsonDecode(body));

    try {
      final response = await http.put(
        url,
        headers: headers,
        body: body,
      );
      print("object324");
      if (response.statusCode == 200) {
        final message = jsonDecode(response.body);
        SimpleToast.showSuccessToast(
            context, "Feed Added", "${message['message']}");
        _isloading = false;
        notifyListeners();
        // print("object");
        // showSuccessSnackbar(
        //     "Data successfully sent! ${response.statusCode}", context);
      } else {
        final message = jsonDecode(response.body);
        SimpleToast.showErrorToast(
            context, "Feed Not Added", "${message['message']}");
        _isloading = false;
        notifyListeners();
        // showErrorSnackbar(
        //     "Failed to send data.${response.statusCode}", context);
      }
    } catch (e) {
      SimpleToast.showErrorToast(context, "Error occurred:", "$e");
      _isloading = false;
      notifyListeners();
      //showErrorSnackbar("An error occurred: $e", context);
    }
  }

  // Future<List<FeedConsumption>?> fetchFeedConsumption1(
  //     BuildContext context,) async {
  //   final headers = {
  //     'Authorization':
  //         'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
  //   };
  //   final url =
  //       Uri.parse('${GlobalApi.baseApi}${GlobalApi.getFeedConsumption}/$Date');
  //   final response = await http.get(url, headers: headers);
    
  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     if (jsonData['success'] == true) {
  //       _isloading = false;
  //       notifyListeners();
  //       final feedConsumptionList = (jsonData['feedConsumtion'] as List)
  //           .map((item) => FeedConsumption.fromJson(item))
  //           .toList();
  //       return feedConsumptionList;
  //     } else {
  //       _isloading = false;
  //       notifyListeners();
  //       // Handle failure response
  //       print('Error: ${jsonData['message']}');
  //       return null;
  //     }
  //   } else {
  //     _isloading = false;
  //     notifyListeners();
  //     print('Failed to fetch data. Error: ${response.reasonPhrase}');
  //     return null;
  //   }
  // }


}
