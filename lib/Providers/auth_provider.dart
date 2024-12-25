import 'dart:convert';
import 'package:dairyfarmflow/API/global_api.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Screens/Dashboard/Dashboard.dart';
import 'package:dairyfarmflow/Screens/Dashboard/UserDashboard/user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  String _message = '';
  bool _isLoading = false;

  String get message => _message;
  bool get isLoading => _isLoading;

  //Sign Up//

  Future<void> signUp(
      String name, String email, String password, BuildContext context) async {
    
    final body = {"name": name, "email": email, "password": password};

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("${GlobalApi.baseApi}${GlobalApi.signUpAPI}"),
        body: body,
      );

      final userJson = jsonDecode(response.body);
     // print(userJson);

      if (response.statusCode == 200) {
        _message = userJson["message"];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              _message,
              style: TextStyle(fontSize: screenWidth * .045),
            ),
          ),
        );
      } else {
        _message = userJson["message"];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              _message,
              style: TextStyle(fontSize: screenWidth * .045),
            ),
          ),
        );
      }
    } catch (e) {
      _message = 'An error occurred. Please try again.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            _message,
            style: TextStyle(fontSize: screenWidth * .045),
          ),
        ),
      );
      debugPrint('Error occurred: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Login Method//

  Future<bool> login(
      String email, String password, BuildContext context) async {
    bool authUser = false;
    _isLoading = true;
    notifyListeners();
    final body = {"email": email, "password": password};


    try {
      final response = await http.post(
        Uri.parse("${GlobalApi.baseApi}${GlobalApi.loginApi}"),
        body: body,
      );

      final jsonresponse = jsonDecode(response.body);
      print(jsonresponse);

      if (response.statusCode == 200) {
        final userJson = jsonDecode(response.body);
        String role = userJson['user_']['role'];

        Provider.of<UserDetail>(context, listen: false).setUserDetail(userJson);

        debugPrint('API Body: ${response.body}');
        authUser = true;
        if (role == 'Admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const UserDashboard()),
          );
        }
      } else {
        final userJson = jsonDecode(response.body);
        _message = userJson['message'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              _message,
              style: TextStyle(fontSize: screenWidth * .045),
            ),
          ),
        );
      }
    } catch (e) {
      _message = 'An error occurred. Please try again.';
      debugPrint('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            _message,
            style: TextStyle(fontSize: screenWidth * .045),
          ),
        ),
      );
    }

    _isLoading = false;
    notifyListeners();

    return authUser;
  }
}
