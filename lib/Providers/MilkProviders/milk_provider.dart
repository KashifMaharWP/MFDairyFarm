import 'dart:convert';
import 'dart:developer';

import 'package:dairyfarmflow/API/global_api.dart';
import 'package:dairyfarmflow/Functions/showPopsScreen.dart';
import 'package:dairyfarmflow/Model/AnimalDetails/milkProductionModel.dart';
import 'package:dairyfarmflow/Model/vendorMilkSalelistModel.dart';
import 'package:dairyfarmflow/Model/vendorResponse.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/VendorList/VendorMilkSale.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:simple_toast_message/simple_toast.dart';

class MilkProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

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
      'morning': double.parse(morning),
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
      'evening': double.parse(evening),
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
      required double morning,
      required double evening,
      required double total,
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

  Future<void> saleMilk(
      {required String venderId,
      required String date,
      required String milkAmount,
      required String totalAmount,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.addMilkSale}');
    // print(url);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
    };

    final body = jsonEncode({
      'vendorId': venderId,
      'date': date,
      'amount_sold': double.parse(milkAmount),
      'total_payment': 100,
    });
    //debugger();

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
            context, "Milk Sold", "${userJson['message']}");
        _isLoading = false;
        notifyListeners();
        //showSuccessSnackbar(userJson['message'], context);
      } else {
        final message = jsonDecode(response.body);
        SimpleToast.showInfoToast(context, "Error", "${message['message']}");
        _isLoading = false;
        notifyListeners();
        //showErrorSnackbar(message['message'], context);
        print('Error 400: ${response.body}');
      }
    } catch (e) {
      SimpleToast.showErrorToast(context, "Error occured", "$e");

      _isLoading = false;
      notifyListeners();
      //showErrorSnackbar("An Error occured: $e", context);
    }
  }

  AddVender(BuildContext context, String vendorName) async {
    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.addVendor}');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
    };

    final body = jsonEncode({
      'name': vendorName,
    });
    // debugger();

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // final userJson = jsonDecode(response.body);
        // print(userJson['message']);
        SimpleToast.showSuccessToast(
            context, "Vendor Created", "Vender Created Successfully}");
        _isLoading = false;
        notifyListeners();
        //showSuccessSnackbar(userJson['message'], context);
      }
    } catch (e) {
      SimpleToast.showErrorToast(context, "Error occured", "$e");
      _isLoading = false;
      notifyListeners();
      //showErrorSnackbar("An Error occured: $e", context);
    }
  }

  List<Vendor> _vendors = [];

  List<Vendor> get vendors => _vendors;

  Future<void> fetchVendors(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.fetchVendorList}');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization':
            "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
      };
      final response = await http.get(url, headers: headers);
      // debugger();
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final vendorResponse = VendorResponse.fromJson(data);
        _vendors = vendorResponse.vendors;
      } else {
        throw Exception('Failed to load vendors');
      }
    } catch (error) {
      print('Error fetching vendors: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  getPDFRecord(String id, String initialDate, String finalDate,
      BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse(
              '${GlobalApi.baseApi}${GlobalApi.milkRecordBetweenDates}$id')
          .replace(queryParameters: {
        "startdate": initialDate,
        "enddate": finalDate
      });

      final headers = {
        'Content-Type': 'application/json',
        'Authorization':
            "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
      };

      final response = await http.get(url, headers: headers);

      print("API Response: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print("API : ${jsonData}");
        final parsedData = CowDetailsResponse.fromJson(jsonData);

        print("Feed : ${parsedData.feedRecords![0].evening}");
        return parsedData;
      } else {
        print("Failed with status code: ${response.statusCode}");
        return null;
      }
    } catch (error) {
      print('Error fetching data: $error');
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  fetchVendorsRecord(
      BuildContext context, String id, String initialDate, finalDate) async {
    _isLoading = true;
    notifyListeners();

    try {
      final url =
          Uri.parse('${GlobalApi.baseApi}${GlobalApi.fetchVendorMilkRecord}$id')
              .replace(queryParameters: {
        "startdate": initialDate,
        "enddate": finalDate
      });

      final headers = {
        'Content-Type': 'application/json',
        'Authorization':
            "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
      };
      final response = await http.get(url, headers: headers);
       //debugger();
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final vendorResponse = VendorMilkSaleListResponse.fromJson(data);
        return vendorResponse;
      } else {
        throw Exception('Failed to load vendors');
      }
    } catch (error) {
      print('Error fetching vendors: $error');
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  fetchVendorsMonthSale(
      BuildContext context, String id,) async {
    _isLoading = true;
    notifyListeners();

    try {
      final url =
          Uri.parse('${GlobalApi.baseApi}${GlobalApi.fetchVendorMonthSale}$id');
             

      final headers = {
        'Content-Type': 'application/json',
        'Authorization':
            "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
      };
      final response = await http.get(url, headers: headers);
       
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Data: ${data}");
        final vendorResponse = VendorMilkSaleListResponse.fromJson(data);
        return vendorResponse;
      } else {
        throw Exception('Failed to load vendors');
      }
    } catch (error) {
      print('Error fetching vendors: $error');
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
