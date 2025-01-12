import 'dart:convert';
import 'dart:developer';

import 'package:dairyfarmflow/Model/Medical/details_model.dart';
import 'package:dairyfarmflow/Model/medical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
        '${GlobalApi.baseApi}${GlobalApi.getMedicalRecord}/${date}';
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
        '${GlobalApi.baseApi}${GlobalApi.getMedicalRecordById}/${id}/$month');
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
}
