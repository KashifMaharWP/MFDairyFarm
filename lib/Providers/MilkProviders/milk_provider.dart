import 'dart:convert';

import 'package:dairyfarmflow/API/global_api.dart';
import 'package:dairyfarmflow/Functions/showPopsScreen.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MilkProvider extends ChangeNotifier {
  Future<void> sendMorningMilkData(
      {required String cowId,
      required String date,
      required String morning,
      required BuildContext context}) async {
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
        showSuccessSnackbar(message['message'], context);
      } else {
        final message = jsonDecode(response.body);
        showErrorSnackbar(message['message'], context);
      }
    } catch (e) {
      showErrorSnackbar("An error occurred: $e", context);
    }
  }

  Future<void> sendEveningMilkData(
      {required String cowId,
      required String date,
      required String evening,
      required BuildContext context}) async {
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
        showSuccessSnackbar(userJson['message'], context);
      } else {
        final message = jsonDecode(response.body);
        showErrorSnackbar(message['message'], context);
      }
    } catch (e) {
      showErrorSnackbar("An Error occured: $e", context);
    }
  }

  Future<void> upadetMilkData(
      {required String id,
      required int morning,
      required int evening,
      required int total,
      required BuildContext context}) async {
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
        showSuccessSnackbar(userJson['message'], context);
      } else {
        final message = jsonDecode(response.body);
        showErrorSnackbar(message['message'], context);
      }
    } catch (e) {
      showErrorSnackbar("An Error occured: $e", context);
    }
  }

  Future<void> deleteMilkData({
    required String id,
    required BuildContext context,
  }) async {
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
        showSuccessSnackbar(jsonResponse['message'], context);
      } else {
        try {
          final message = jsonDecode(response.body);
          showErrorSnackbar(message['message'], context);
        } catch (_) {
          showErrorSnackbar(
              'Failed to delete milk record: ${response.body}', context);
        }
      }
    } catch (e) {
      showErrorSnackbar("An error occurred: $e", context);
      print('Error: $e');
    }
  }
}
