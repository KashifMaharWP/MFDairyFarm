import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../API/global_api.dart';
import '../../Model/get_cow_model.dart';
import '../user_detail.dart';

class CowsData{
  Future<CowsResponse?> fetchCows(BuildContext context) async {
  
  var headers = {
    'Authorization':
        'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
  };
  var request = http.Request(
    'GET',
    Uri.parse('${GlobalApi.baseApi}${GlobalApi.getAnimal}'),
  );

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final jsonString = await response.stream.bytesToString();
    final jsonData = json.decode(jsonString);
    return CowsResponse.fromJson(jsonData);
  } else {
    if (kDebugMode) {
      print("Error: ${response.reasonPhrase}");
    }
    return null;
  }
}
}
