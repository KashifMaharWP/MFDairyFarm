import 'dart:convert';

import 'package:dairyfarmflow/API/global_api.dart';
import 'package:dairyfarmflow/Model/feedInventory.dart';
import 'package:dairyfarmflow/Model/feedInventoryModel.dart';
import 'package:dairyfarmflow/Model/feed_inventory.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class FeedInventoryProvider with ChangeNotifier {
 
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  static Future<FeedInventoryModel?> fetchFeedInventory( BuildContext context, String date) async {
    final url = Uri.parse("${GlobalApi.baseApi}${GlobalApi.monthlyFeedInventory}$date");
final headers = {
        'Authorization':
            'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
      };
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return FeedInventoryModel.fromJson(jsonData['feedInventory']);
      } else {
        throw Exception("Failed to load feed inventory");
      }
    } catch (e) {
      print("Error fetching feed inventory: $e");
      return null;
    }
  }
}

