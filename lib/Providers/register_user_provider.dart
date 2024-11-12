import 'dart:convert';

import 'package:dairyfarmflow/API/global_api.dart';
import 'package:dairyfarmflow/Functions/showPopsScreen.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class RegisterUserProvider extends ChangeNotifier {
  Future<void> registerUser(
      {required String name,
      required String email,
      required String password,
      required BuildContext context}) async {
    final url = Uri.parse('${GlobalApi.baseApi}user/createUser');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
    };

    final body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });
    print(jsonDecode(body));

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        showSuccessSnackbar("User Created successfully!", context);
      } else {
        showErrorSnackbar("Failed to Create User", context);
      }
    } catch (e) {
      showErrorSnackbar("An error occurred: $e", context);
    }
  }
}
