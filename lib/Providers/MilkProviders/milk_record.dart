import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:dairyfarmflow/Model/soldmilk.dart';
import 'package:dairyfarmflow/Providers/MilkProviders/milk_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_toast_message/simple_toast.dart';

import '../../API/global_api.dart';
import '../../Functions/showPopsScreen.dart';
import '../../Model/add_milk.dart';
import '../user_detail.dart';

class MilkRecordProvider extends ChangeNotifier {
  String evening = "0";
  String morning = "0";
  String total = "0";
  String eveningMilk = "0";
  String morningMilk = "0";
  //String filtering ='';

  List<TodayMilkRecord> _milkRecords = [];
  Map<String, dynamic>? _milkCountData;
  bool _isLoading = true;
  String? _errorMessage;

  List<TodayMilkRecord> get milkRecords => _milkRecords;
  Map<String, dynamic>? get milkCountData => _milkCountData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<SoldMilkModel> filteredMilkData = [];
  String totalMilk = "0";

  void lister() {
    notifyListeners();
  }

  Future<int> fetchMilkSoldForDate(
      BuildContext context, String month, String filterDate) async {
    final headers = {
      'Authorization':
          'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
    };
    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.getSoldMilk}$month');

    try {
      final response = await http.get(url, headers: headers);
      //debugger();
      if (response.statusCode == 200) {
        final data = SoldMilkModel.fromJson(json.decode(response.body));
        final records = data.monthlyMilkRecord;

        // Group records by date
        final groupedByDate = groupBy(records!, (record) => record.date);

        // Calculate total amount_sold for all vendors for each date
        final datewiseTotals = groupedByDate.map((date, records) {
          final totalSold = records.fold(
              0, (sum, record) => sum + record.amountSold!.toInt());

          return MapEntry(date, totalSold);
        });

        // Return the total for the requested date
        if (datewiseTotals.containsKey(filterDate)) {
          totalMilk = datewiseTotals[filterDate].toString();
          return datewiseTotals[filterDate]!;
        } else {
          //print("No data found for the given date: $filterDate");
          totalMilk = "0";
          return 0; // No data for the date
        }
      } else {
        final errorResponse = json.decode(response.body);
        print("Error: ${errorResponse['message']}");
        return 0; // Handle error
      }
    } catch (e) {
      print("An error occurred: $e");
      return 0; // Handle exception
    }
  }

  Future<void> fetchMilkRecords(BuildContext context) async {
    final date = DateFormat("EEE MMM dd yyyy").format(DateTime.now());
    print(date);

    _isLoading = true;
    _errorMessage = null;
    //notifyListeners();

    final String token =
        Provider.of<UserDetail>(context, listen: false).token.toString();
    final String apiUrl = '${GlobalApi.baseApi}${GlobalApi.getMilkRecord}$date';
    final headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        // print(jsonResponse);
        if (jsonResponse['success'] == true) {
          List<dynamic> records = await jsonResponse['todayMilkRecord'];
          _milkRecords = records
              .map((record) => TodayMilkRecord.fromJson(record))
              .toList();
          //  print(_milkRecords);
        } else {
          _errorMessage = jsonResponse['message'] ?? 'Failed to fetch records';
        }
      } else {
        _errorMessage =
            'HTTP Error: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      _errorMessage = 'Exception occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
fetchMilkCount(BuildContext context, String month) async {
    _isLoading = true;
    _errorMessage = null;
    // notifyListeners();

    final headers = {
      'Authorization':
          'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
    };
    final url =
        Uri.parse('${GlobalApi.baseApi}${GlobalApi.getMilkCount}$month');

    try {
      final response = await http.get(url, headers: headers);

        // debugger();
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        if (jsonData['success'] == true) {
          _milkCountData = jsonData;
         morningMilk =_milkCountData!['todayMilkCount'][0]['morning'].toString();
          eveningMilk = _milkCountData!['todayMilkCount'][0]['evening'].toString();
         // total =(_milkCountData!['todayMilkCount'][0]['morning']+_milkCountData!['todayMilkCount'][0]['evening']).toString();
         total=(double.parse(morningMilk)+double.parse(eveningMilk)).toString();
          notifyListeners();
          //print(_milkCountData!['todayMilkCount'][0]['morning']);
          
          return MilkDataRecord(
        date: month,
        morningMilk: double.parse(morningMilk)??0,
        eveningMilk: double.parse(eveningMilk)??0,
        totalMilk: double.parse(total)??0,
      );
        } else {
          _errorMessage = jsonData['message'] ?? 'Failed to fetch milk count';
          morningMilk = "0";
          eveningMilk = '0';
          total = "0";
          notifyListeners();
          return null;
        }
      } else {
        _errorMessage =
            'HTTP Error: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      _errorMessage = 'Exception occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sold Milk Record Provider by Month

//   Future<SoldMilkModel?> fetchMilkSold(BuildContext context,String month) async {

//     // final date = DateFormat("EEE MMM dd yyyy").format(DateTime.now());
//   final headers = {
//     'Authorization':
//         'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
//   };
//   final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.getSoldMilk}$month');

//   try {
//     final response = await http.get(url, headers: headers);

//     if (response.statusCode == 200) {
//     //  debugger();
//       return SoldMilkModel.fromJson(json.decode(response.body));
//     } else {

//       final errorResponse = json.decode(response.body);
//       print("Error: ${errorResponse['message']}");

//     }
//   } catch (e) {

//     print("An error occurred: $e");
//     return null;
//   }
//   return null;
// }
  Future<List<SoldMilkRecord>> fetchMilkSoldByDate(
      BuildContext context, String date) async {
    final headers = {
      'Authorization':
          'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
    };
    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.getSoldMilk}$date');

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final soldMilkModel =
            SoldMilkModel.fromJson(json.decode(response.body));

        // Filter records by the given date
        final filteredData = soldMilkModel.monthlyMilkRecord
                ?.where((record) => record.date == date)
                .toList() ??
            [];

        return filteredData;
      } else {
        final errorResponse = json.decode(response.body);
        print("Error: ${errorResponse['message']}");
        return [];
      }
    } catch (e) {
      print("An error occurred: $e");
      return [];
    }
  }

  Future<void> upadetMilkSold(
      {required String id,
      required String vendorName,
      required String datePicker,
      required int amountSold,
      required int totalPayment,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.updateMilkSold}$id');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
    };

    final body = jsonEncode({
      'vendorName': vendorName,
      'amount_sold': amountSold,
      'total_payment': totalPayment,
      'date': datePicker
    });

    try {
      final response = await http.patch(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final userJson = jsonDecode(response.body);
        print(userJson['message']);
        SimpleToast.showSuccessToast(
            context, "Milk Updated", "${userJson['message']}");
        _isLoading = false;
        notifyListeners();
        //showSuccessSnackbar(userJson['message'], context);
      } else {
        final message = jsonDecode(response.body);
        SimpleToast.showErrorToast(
            context, "Updating Error", "${message['message']}");
        _isLoading = false;
        notifyListeners();
        //showErrorSnackbar(message['message'], context);
      }
    } catch (e) {
      SimpleToast.showErrorToast(context, "Error occured", "$e");
      _isLoading = false;
      notifyListeners();
      // showErrorSnackbar("An Error occured: $e", context);
    }
  }

  Future<void> deleteMilkSold({
    required String id,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();
    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.daleteMilkSold}$id');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer ${Provider.of<UserDetail>(context, listen: false).token}",
    };

    try {
      final response = await http.delete(url, headers: headers);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('Success Message: ${jsonResponse['message']}');
        SimpleToast.showSuccessToast(
            context, "Milk Deleted", "${jsonResponse['message']}");
        _isLoading = false;
        notifyListeners();
        //showSuccessSnackbar(jsonResponse['message'], context);
      }
    } catch (e) {
      print(e);
    }
  }

  void deleteRecord(BuildContext context, String id) async {
    await Provider.of<MilkProvider>(context, listen: false)
        .deleteMilkData(id: id, context: context);
    notifyListeners();
    //Navigator.pop(context);
  }

  Future<void> sendMorningMilkData(
      {required String cowId,
      required String date,
      required String morning,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.addMorningMilk}');

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

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final message = jsonDecode(response.body);
        SimpleToast.showSuccessToast(
            context, "Milk Added", "${message['message']}");
        _isLoading = false;
        notifyListeners();
        //showSuccessSnackbar(message['message'], context);
      } else {
        _isLoading = false;
        notifyListeners();
        final message = jsonDecode(response.body);
        SimpleToast.showInfoToast(
            context, "Milk Already Added", "${message['message']}");
        // showErrorSnackbar(message['message'], context);
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      SimpleToast.showErrorToast(context, "Error Message", "$e");
      //showErrorSnackbar("An error occurred: $e", context);
    }
  }

  Future<void> sendEveningMilkData(
      {required String cowId,
      required String date,
      required String evening,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.addEveningMilk}');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
    };

    final body = jsonEncode({
      'cowId': cowId,
      'date': date,
      'evening': int.parse(evening),
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final userJson = jsonDecode(response.body);
        print(userJson['message']);
        SimpleToast.showSuccessToast(
            context, "Milk Added", "${userJson['message']}");
        _isLoading = false;
        notifyListeners();
        //showSuccessSnackbar(userJson['message'], context);
      } else {
        final message = jsonDecode(response.body);
        SimpleToast.showInfoToast(
            context, "Milk Alrady Added", "${message['message']}");
        _isLoading = false;
        notifyListeners();
        //showErrorSnackbar(message['message'], context);
      }
    } catch (e) {
      SimpleToast.showErrorToast(context, "Error occured", "$e");
      _isLoading = false;
      notifyListeners();
      //showErrorSnackbar("An Error occured: $e", context);
    }
  }

  Future<void> upadetMilkData(
      {required String id,
      required int morning,
      required int evening,
      required int total,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    final url =
        Uri.parse('${GlobalApi.baseApi}${GlobalApi.updateMilkRecord}/$id');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
    };

    final body =
        jsonEncode({'morning': morning, 'evening': evening, 'total': total});

    try {
      final response = await http.patch(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final userJson = jsonDecode(response.body);
        print(userJson['message']);
        SimpleToast.showSuccessToast(
            context, "Milk Updated", "${userJson['message']}");
        _isLoading = false;
        notifyListeners();
        //showSuccessSnackbar(userJson['message'], context);
      } else {
        final message = jsonDecode(response.body);
        SimpleToast.showErrorToast(
            context, "Updating Error", "${message['message']}");
        _isLoading = false;
        notifyListeners();
        //showErrorSnackbar(message['message'], context);
      }
    } catch (e) {
      SimpleToast.showErrorToast(context, "Error occured", "$e");
      _isLoading = false;
      notifyListeners();
      // showErrorSnackbar("An Error occured: $e", context);
    }
  }

  Future<void> deleteMilkData({
    required String id,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();
    final url =
        Uri.parse('${GlobalApi.baseApi}${GlobalApi.deleteMilkRecord}/$id');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer ${Provider.of<UserDetail>(context, listen: false).token}",
    };

    try {
      final response = await http.delete(url, headers: headers);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('Success Message: ${jsonResponse['message']}');
        SimpleToast.showSuccessToast(
            context, "Milk Deleted", "${jsonResponse['message']}");
        _isLoading = false;
        notifyListeners();
        //showSuccessSnackbar(jsonResponse['message'], context);
      } else {
        try {
          final message = jsonDecode(response.body);
          SimpleToast.showErrorToast(
              context, "Milk Added", "${message['message']}");
          _isLoading = false;
          notifyListeners();
          //showErrorSnackbar(message['message'], context);
        } catch (_) {
          _isLoading = false;
          notifyListeners();
          showErrorSnackbar(
              'Failed to delete milk record: ${response.body}', context);
        }
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      SimpleToast.showErrorToast(context, "Error occured", "$e");
      // showErrorSnackbar("An error occurred: $e", context);
      print('Error: $e');
    }
  }
}


class MilkDataRecord {
  final String date;
  final num morningMilk;
  final num eveningMilk;
  final num totalMilk;

  MilkDataRecord({
    required this.date,
    required this.morningMilk,
    required this.eveningMilk,
    required this.totalMilk,
  });
}
