import 'dart:convert';

import 'package:dairyfarmflow/Model/Medical/details_model.dart';
import 'package:dairyfarmflow/Model/medical.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_toast_message/simple_toast.dart';
import 'package:http/http.dart' as http;
import '../../API/global_api.dart';
import '../user_detail.dart';

class AddMedical extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  MedicalRecordResponse? medicalData;
  MedicalDetailModel? singleMedicalDetail;
  final List<MedicalRecordResponse> _milkRecords = [];
  //Map<String, dynamic>? _milkCountData;
  // bool _isLoading = true;
  String? _errorMessage;

  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<MedicalRecordResponse> get milkRecords => _milkRecords;
  //Map<String, dynamic>? get milkCountData => _milkCountData;

  String? get errorMessage => _errorMessage;

  fetchMedicalRecords(BuildContext context) async {
    setIsLoading(true);
    final date = DateFormat("EEE MMM dd yyyy").format(DateTime.now());
    final String token =
        Provider.of<UserDetail>(context, listen: false).token.toString();
    final String apiUrl =
        '${GlobalApi.baseApi}${GlobalApi.getMedicalRecord}/$date';
    final headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      // debugger();
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        MedicalRecordResponse detailModel =
            MedicalRecordResponse.fromJson(jsonResponse);
        medicalData = detailModel;
        setIsLoading(false);
      }
    } catch (e) {
      throw Exception('Exception occurred: $e');
    }
    setIsLoading(false);
  }

  Future<void> addMedicalRecord(
      {required String cowId,
      required String date,
      required String medical,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.addMedical}');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
    };

    final body = jsonEncode({
      'cowId': cowId,
      'date': date,
      'vaccineType': medical,
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
            context, "Record Added", "${message['message']}");
        _isLoading = false;
        notifyListeners();
        //showSuccessSnackbar(message['message'], context);
      } else {
        _isLoading = false;
        notifyListeners();
        final message = jsonDecode(response.body);
        SimpleToast.showErrorToast(context, "Error", "${message['message']}");
        // showErrorSnackbar(message['message'], context);
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      SimpleToast.showErrorToast(context, "Error Message", "$e");
      //showErrorSnackbar("An error occurred: $e", context);
    }
  }

  fetchMedicalDetails(BuildContext context, String id, String month) async {
    final url = Uri.parse(
        '${GlobalApi.baseApi}${GlobalApi.getMedicalRecordById}/$id/$month');
    setIsLoading(true);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
    };
    try {
      final response = await http.get(url, headers: headers);
      final jsonResponse = jsonDecode(response.body);
      // debugger();
      if (response.statusCode == 200) {
        MedicalDetailModel model =
            MedicalDetailModel.fromJson(json.decode(response.body));
        singleMedicalDetail = model;
        setIsLoading(false);
      }
    } catch (err) {
      SimpleToast.showErrorToast(context, "Error", err.toString());
      setIsLoading(false);
    }
  }

  Future<void> DeleteMedicalRecord(BuildContext context, String id) async {
    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.deleteVacine}$id');
    print('DELETE URL: $url'); // Debugging: Print the full URL

    setIsLoading(true); // Set loading to true while the request is in progress
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
    };

    try {
      final response =
          await http.delete(url, headers: headers); // Send DELETE request
      print(
          'Response: ${response.statusCode} - ${response.body}'); // Debugging: Print the response

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body); // Parse response body
        notifyListeners();
        SimpleToast.showInfoToast(
            context, "Vaccine", "Vaccine Deleted"); // Show success message
      } else {
        final jsonResponse =
            jsonDecode(response.body); // Handle failure response
        SimpleToast.showErrorToast(context, "Error",
            jsonResponse['message'] ?? 'Failed to delete vaccine.');
      }
    } catch (err) {
      print('Error: $err'); // Debugging: Print the error
      SimpleToast.showErrorToast(context, "Error", err.toString());
    } finally {
      setIsLoading(
          false); // Stop loading, whether the request succeeds or fails
    }
  }
}
