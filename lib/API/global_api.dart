import 'package:intl/intl.dart';

class GlobalApi {
  //static String baseApi = "https://api.customizablewear.com/api/";
  static String baseApi = "http://localhost:3000/api/";
  static String loginApi = "user/login";
  static String signUpAPI = "user/signup";
  static String addAnimal = "cow/register";
  static String getAnimal = "cow/getCows";
  static String getMilkCount =
      'milk/getMilkCountRecordByDate/${DateFormat("EEE MMM dd yyyy").format(DateTime.now())}';
  static String addMorningFeed = "feed/morningFeed";
  static String getMilkRecord = 'milk/getMilkRecordByDate/';
  static String addEveningFeed = "feed/eveningFeed";
  static String updateMilkRecord = 'milk/updateMilkRecordById';
  static String getFeedConsumption = 'feed/getFeedConsumtionRecordByMonth/';
  static String addMorningMilk = "milk/morningMilkProduction";
  static String addEveningMilk = "milk/eveningMilkProduction";
  static String addFeedAmount = "feedInventory/addFeed";
  static String deleteMilkRecord = 'milk/deleteMilkRecordById';
  static String addMedical = 'medicalRecord/add';
  static String getMedicalRecord = 'medicalRecord/getMonthlyMedicalRecord/Dec';
}
