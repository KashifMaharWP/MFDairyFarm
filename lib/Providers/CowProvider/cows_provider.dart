// import 'dart:convert';
// import 'dart:developer';

// import 'package:dairyfarmflow/Screens/AdminScreen/VacinationScreen/animal_list.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:simple_toast_message/simple_toast.dart';

// import '../../API/global_api.dart';
// import '../../Model/get_cow_model.dart';
// import '../user_detail.dart';

// class CowsProvider extends ChangeNotifier{

// CowsResponse? cowList;
// bool _isCowListLoad=false;

// bool get isCowListLoad=>_isCowListLoad;

// setisCowListLoad(bool value) {
//     _isCowListLoad = value;
//     notifyListeners();
//   }

//  fetchCows(BuildContext context) async {
//   try{
//     setisCowListLoad(true);
//     var headers = {
//     'Authorization':
//         'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
//   };
//   final url=Uri.parse('${GlobalApi.baseApi}${GlobalApi.getAnimal}');

//   final response = await http.get(url, headers: headers);

//   final cowsResponse=json.decode(response.body);
//       CowsResponse cowsModelList = CowsResponse.fromJson(cowsResponse);
//   if (response.statusCode == 200) {

//     cowList=cowsModelList;
//     //debugger();
//     setisCowListLoad(false);
//   }
//   }
//   catch(e){
//     SimpleToast.showErrorToast(context, "Error", e.toString());
//     setisCowListLoad(false);
//   }

// }
// }
import 'dart:convert';
import 'dart:developer';

import 'package:dairyfarmflow/Screens/AdminScreen/VacinationScreen/animal_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:simple_toast_message/simple_toast.dart';

import '../../API/global_api.dart';
import '../../Model/get_cow_model.dart';
import '../user_detail.dart';

class CowsProvider extends ChangeNotifier {
  CowsResponse? cowList;
  bool _isCowListLoad = false;

  bool get isCowListLoad => _isCowListLoad;

  setisCowListLoad(bool value) {
    _isCowListLoad = value;
    notifyListeners();
  }

  // Fetch the cows from the API
  fetchCows(BuildContext context) async {
    try {
      setisCowListLoad(true);
      var headers = {
        'Authorization':
            'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
      };
      final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.getAnimal}');

      final response = await http.get(url, headers: headers);

      final cowsResponse = json.decode(response.body);
      CowsResponse cowsModelList = CowsResponse.fromJson(cowsResponse);
      if (response.statusCode == 200) {
        cowList = cowsModelList;
        setisCowListLoad(false);
      } else {
        SimpleToast.showErrorToast(context, "Error", "Failed to load cows.");
        setisCowListLoad(false);
      }
    } catch (e) {
      SimpleToast.showErrorToast(context, "Error", e.toString());
      setisCowListLoad(false);
    }
  }

  // Remove the cow from the list immediately for optimistic UI update
  void removeCowById(String cowId) {
    cowList?.cows.removeWhere((cow) => cow.id == cowId);
    notifyListeners(); // Notify listeners to update the UI
  }

  // Restore the cow to the list (in case the deletion fails)
  void restoreCowById(Cow cow) {
    cowList?.cows.add(cow);
    notifyListeners(); // Notify listeners to update the UI
  }

  // Delete the cow via API
  Future<void> deleteCow(BuildContext context, String cowId) async {
    try {
      // Find the cow to remove and store it for restoration if necessary
      Cow? cowToDelete = cowList?.cows.firstWhere(
        (cow) => cow.id == cowId,
        orElse: () => throw Exception(
            "Cow with id $cowId not found"), // Throw an exception if cow is not found
      );

      if (cowToDelete != null) {
        // Optimistic UI update: Remove the cow immediately
        removeCowById(cowId);

        var headers = {
          'Authorization':
              'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
        };
        final url =
            Uri.parse('${GlobalApi.baseApi}${GlobalApi.deleteAnimal}/$cowId');
        final response = await http.delete(url, headers: headers);

        if (response.statusCode == 200) {
          // Successfully deleted, now re-fetch the cows list
          fetchCows(context);
        } else {
          // If deletion fails, restore the cow to the list
          restoreCowById(cowToDelete);
          SimpleToast.showErrorToast(context, "Error", "Failed to delete cow.");
        }
      }
    } catch (e) {
      SimpleToast.showErrorToast(context, "Error", e.toString());
    }
  }
}
