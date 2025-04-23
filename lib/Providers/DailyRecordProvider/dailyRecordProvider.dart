import 'dart:convert';
import 'dart:developer';
import 'package:dairyfarmflow/API/global_api.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DairyRecordProvider extends ChangeNotifier {
  bool _isLoading = false;
  num totalMorningMilk = 0;
  num totalEveningMilk = 0;
  num milkCount = 0;
  
  num totalMorningFeed = 0;
  num totalEveningFeed = 0;
  num totalFeed = 0;
  
  num totalSoldAmount = 0;

  bool get isLoading => _isLoading;

  Future<void> fetchDailyRecords(BuildContext context, String startDate, String endDate) async {
    _isLoading = true;
    notifyListeners();

    try {
      final token = Provider.of<UserDetail>(context, listen: false).token;

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token"
      };
      
      // Milk Production API
      final milkUrl = Uri.parse('${GlobalApi.baseApi}${GlobalApi.fetchMilkRecord}').replace(queryParameters: {
        "startdate": startDate,
        "enddate": endDate
      });
      final milkResponse = await http.get(milkUrl, headers: headers);
      
      if (milkResponse.statusCode == 200) {
        final milkData = json.decode(milkResponse.body);
        totalMorningMilk = milkData['milkCount'] ?? 0;
       totalEveningMilk = milkData['milkProductionRecordBetweenTwoDates']
    .fold<num>(0, (num sum, item) => sum + ((item['evening'] ?? 0) as num));

        milkCount = milkData['milkCount'] ?? 0;
      }

      // Feed Consumption API
      final feedUrl = Uri.parse('${GlobalApi.baseApi}${GlobalApi.fetchFeedConsumption}').replace(queryParameters: {
        "startdate": startDate,
        "enddate": endDate
      });
      final feedResponse = await http.get(feedUrl, headers: headers);
      if (feedResponse.statusCode == 200) {
        final feedData = json.decode(feedResponse.body);
        
        totalMorningFeed = feedData['feedConsumtionCountBetweenDates']['morningFeedConsumtioinCount'] ?? 0;
        totalEveningFeed = feedData['feedConsumtionCountBetweenDates']['eveningFeedConsumtioinCount'] ?? 0;
        totalFeed = feedData['feedConsumtionCountBetweenDates']['total'] ?? 0;
      }

      // Milk Sales API
      final saleUrl = Uri.parse('${GlobalApi.baseApi}${GlobalApi.fetchMilkSale}').replace(queryParameters: {
        "startdate": startDate,
        "enddate": endDate
      });
      final saleResponse = await http.get(saleUrl, headers: headers);
      if (saleResponse.statusCode == 200) {
        final saleData = json.decode(saleResponse.body);
        totalSoldAmount = saleData['milkSaleRecordBetweenTwoDates']
    .fold<num>(0, (num sum, item) => sum + ((item['amount_sold'] ?? 0) as num));
      }

    } catch (error) {
      print("Error fetching records: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
