import 'dart:convert';

import 'package:dairyfarmflow/API/global_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class RegistrationProvider extends ChangeNotifier {
  //Dairy Registration Fields
  String dairyName = "";
  String ownerName = "";
  String location = "";
  String registrationDate = "";

  //Admin Registration Fields
  String name = "";
  String email = "";
  String password = "";
  String dairyFarmId = "";

//function to register the Dairy and admin
  Future<bool> registerDairy() async {
    //creating the map for body
    // map for the admin
    bool isRegestered = false;

    final dairyMap = {
      "name": dairyName,
      "ownerName": ownerName,
      "location": location,
      "registrationDate": registrationDate,
    };

    print("My Send Data: $dairyMap");
    //storing the complete url
    final url = "${GlobalApi.baseApi}daiyfarm/register";

    //going to hit the API
    Future.delayed(const Duration(seconds: 5));
    final response = await post(Uri.parse(url), body: dairyMap);

    //printing the response body
    print("Regcompany API response: ${response.body}");

    final companyJson = await jsonDecode(response.body);
    print("Status Code: ${response.statusCode}");
    if (response.statusCode == 200) {
      print(response.body);
      isRegestered = true;
      dairyFarmId = await companyJson["dairyFarm"]["_id"].toString();
      print("Print from getting: $dairyFarmId");
    }
    // comId != null? return true: return false;
    return isRegestered;
  }

  void registerAdmin() async {
    final adminMap = {
      "name": name,
      "email": email,
      "password": password,
      "dairyFarmId": dairyFarmId,
    };

    final url = "${GlobalApi.baseApi}user/createAdmin";
    print("My send data$adminMap");
    Future.delayed(const Duration(seconds: 5));
    final response = await post(Uri.parse(url), body: adminMap);

    //printing the response body
    print("createAdmin API response: ${response.body}");
  }
}
