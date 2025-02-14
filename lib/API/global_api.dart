import 'package:intl/intl.dart';

class GlobalApi {
  static String baseApi = "https://backend.customizablewear.com/api/";
  //static String baseApi = "https://www.api.customizablewear.com/api/";
  static String loginApi = "user/login";
  static String signUpAPI = "user/signup";
  static String addAnimal = "cow/register";
  static String getAnimal = "cow/getCows";
  static String deleteAnimal = 'cow/';
  static String updateAnimal = 'cow/updateCow';
  static String getMilkCount =
      'milk/getMilkCountRecordByDate/';
  static String addMorningFeed = "feed/morningFeed";
  static String getMilkRecord = 'milk/getMilkRecordByDate/';
  static String addEveningFeed = "feed/eveningFeed";
  static String updateMilkRecord = 'milk/updateMilkRecordById';
  static String getFeedConsumption = 'feed/getFeedConsumtionRecordByMonth/';
  static String getFeedConsumptionCount =
      'feed/getTodayFeedConsumtionCount/';
  static String addMorningMilk = "milk/morningMilkProduction";
  static String addEveningMilk = "milk/eveningMilkProduction";
  static String addFeedAmount = "feedInventory/addFeed";
  static String deleteMilkRecord = 'milk/deleteMilkRecordById';
  static String addMedical = 'medicalRecord/add';
  static String getMedicalRecord = 'medicalRecord/getMonthlyMedicalRecord';
  static String getMedicalRecordById = "medicalRecord/getCowMedicalRecord";
  static String getSoldMilk = "milkSale/getMilkSaleRecordByMonth/";
  static String addMilkSale = 'milkSale/addSaleMilk';
  static String updateMilkSold = "milkSale/updateMilkSaleRecordById/";
  static String daleteMilkSold = "milkSale/deleteMilkSaleRecordById/";
  static String addTask = "task/create";
  static String getAllTasks ="task/getTasks";
  static String getTaskById ="task/getTaskByUserId/";
  static String taskStatus ='task/toggleTask/';
  static String getAnimalDetailById ='milk/getMilkRecordOfMonthById?id=';
  static String getVacineDetail="medicalRecord/getCowMedicalRecord/";
  static String deleteVacine="medicalRecord/deleteMedicalRecord/";

  static String addVendor="milkSaleVendor/";
  static String fetchVendorList="milkSaleVendor/";

  static String updateCowMilk="milk/updateMilkRecordById/";
  static String deleteCowMilk="milk/deleteMilkRecordById/";
   static String feedInventory="feedInventory/";

   static String deleteFeedConsumption="feed/deleteFeedConsumtionRecordById/";
   static String UpdateFeedInventory="feedInventory/plusAmount/";
  
  
}
