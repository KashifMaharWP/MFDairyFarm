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

class CowsProvider extends ChangeNotifier{

CowsResponse? cowList;
bool _isCowListLoad=false;

bool get isCowListLoad=>_isCowListLoad;

setisCowListLoad(bool value) {
    _isCowListLoad = value;
    notifyListeners();
  }

 fetchCows(BuildContext context) async {
  try{
    setisCowListLoad(true);
    var headers = {
    'Authorization':
        'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
  };
  final url=Uri.parse('${GlobalApi.baseApi}${GlobalApi.getAnimal}');

  final response = await http.get(url, headers: headers);

  final cowsResponse=json.decode(response.body);
      CowsResponse cowsModelList = CowsResponse.fromJson(cowsResponse);
  if (response.statusCode == 200) {
   
    cowList=cowsModelList;
    //debugger();
    setisCowListLoad(false);
  }
  }
  catch(e){
    SimpleToast.showErrorToast(context, "Error", e.toString());
    setisCowListLoad(false);
  }
  
}
}
