import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../API/global_api.dart';
import '../../Model/add_milk.dart';
import '../user_detail.dart';

class MilkRecordProvider extends ChangeNotifier {
  List<TodayMilkRecord> _milkRecords = [];
  Map<String, dynamic>? _milkCountData;
  bool _isLoading = true;
  String? _errorMessage;

  List<TodayMilkRecord> get milkRecords => _milkRecords;
  Map<String, dynamic>? get milkCountData => _milkCountData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchMilkRecords(BuildContext context) async {
    final date = DateFormat("EEE MMM dd yyyy").format(DateTime.now());
    print(date);
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final String token =
        Provider.of<UserDetail>(context, listen: false).token.toString();
    final String apiUrl =
        '${GlobalApi.baseApi}${GlobalApi.getMilkRecord}Sun Nov 17 2024';
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
          print(_milkRecords);
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

  Future<void> fetchMilkCount(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final headers = {
      'Authorization':
          'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
    };
    final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.getMilkCount}');

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        if (jsonData['success'] == true) {
          _milkCountData = jsonData;
        } else {
          _errorMessage = jsonData['message'] ?? 'Failed to fetch milk count';
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
}
