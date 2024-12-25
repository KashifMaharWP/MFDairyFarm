import 'dart:convert';
import 'package:dairyfarmflow/API/global_api.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:simple_toast_message/simple_toast.dart';

class RegisterUserProvider extends ChangeNotifier {
  int _feedConsumed = 0;
  get feedConsumed => _feedConsumed;

  Future<void> feedConsumedFunction(int feeddata) async {
    _feedConsumed = feeddata;
    print("feed in provider $feedConsumed");
    // return _feedConsumed;
    //notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> registerUser(
      {required String name,
      required String email,
      required String password,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
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

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final userJson = jsonDecode(response.body);

        SimpleToast.showSuccessToast(
            context, "User Register!", "${userJson['message']}");
        _isLoading = false;
        notifyListeners();
      } else {
        final userJson = jsonDecode(response.body);

        _isLoading = false;
        notifyListeners();
        SimpleToast.showErrorToast(
            context, "Error Message", "${userJson['message']}");
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      SimpleToast.showErrorToast(context, "An Error Occurred", "$e");
    }
  }
}
