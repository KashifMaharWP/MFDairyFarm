import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dairyfarmflow/API/global_api.dart';
import 'package:dairyfarmflow/Model/Medical/details_model.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/VacinationScreen/medical_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:simple_toast_message/simple_toast.dart';

import '../Model/AnimalDetails/animal_detail_model.dart';
import '../Model/get_cow_model.dart';

class AnimalRegistratinProvider extends ChangeNotifier {
  CowsResponse? cowsList;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String message = '';
  String _milkCount='';
 String get milkCount =>_milkCount;
 bool _isDataFetched=false;
 AnimalDetailModel? animalDetail;
 String _vacineCount='';

 String get vacineCount=>_vacineCount;

 bool get isDataFetched=> _isDataFetched;

 setIsDataFetched(bool value){
  _isDataFetched=value;
  notifyListeners();
 }
  // get message => _message;

  Future<void> uploadAnimalData(BuildContext context, String animalNumber,
      String breed, age, File image) async {
    _isLoading = true;
    notifyListeners();
    if (animalNumber.isEmpty || breed.isEmpty) {
      SimpleToast.showInfoToast(context, 'Alert', "Add Required Fields!");
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${GlobalApi.baseApi}${GlobalApi.addAnimal}'),
    );

    // Add headers and fields

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        image.path,
        filename: basename(image.path),
      ),
    );

    request.headers['Authorization'] =
        'Bearer ${Provider.of<UserDetail>(context, listen: false).token}';
    request.fields['animalNumber'] = animalNumber;
    request.fields['breed'] = breed;
    request.fields['age'] = int.parse(age).toString();
    
    // Send request and handle response
    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        _isLoading = false;
        notifyListeners();
        message = "Animal data uploaded successfully!";
        SimpleToast.showSuccessToast(context, "Success Message", message);
      } else {
        _isLoading = false;
        notifyListeners();
        message = "Failed to upload data ${response.statusCode}";
        SimpleToast.showErrorToast(context, "Error Message", message);
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      message = "Error uploading data: $e";
      SimpleToast.showErrorToast(context, "Error Message", message);
    }
  }
   fetchCows(BuildContext context) async {
  
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

 UpdateMilkRecord(String id, morningMilk,eveningMilk,totalMilk,BuildContext context,)async{
    try {
     // setIsDataFetched(true);
      var headers = {
        'Authorization':
            'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
      };
      final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.updateCowMilk}$id');
      final body={
        "morning":morningMilk,
        "evening":eveningMilk,
        "total":totalMilk
      };
      final response = await http.patch(url,body: body, headers: headers);
      //debugger();
      if (response.statusCode == 200) {
       // cowList = cowsModelList;
       
       // setIsDataFetched(false);
      } else {
        SimpleToast.showErrorToast(context, "Error", "Failed to load cows.");
      //  setIsDataFetched(false);
      }
    } catch (e) {
      SimpleToast.showErrorToast(context, "Error", e.toString());
    //  setIsDataFetched(false);
    }
  }



   getAnimalDetailById(BuildContext context, String id,month)async{
    setIsDataFetched(true);
    final url = Uri.parse("${GlobalApi.baseApi}${GlobalApi.getAnimalDetailById}$id&date=${month}");
    print(url);

    var headers = {
    'Authorization':
        'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
  };

    try{
      final response = await http.get(url,headers: headers);
      AnimalDetailModel detailModel = AnimalDetailModel.fromJson(json.decode(response.body));
      //debugger();
      if(response.statusCode==200){
        _milkCount =detailModel.milkCount.toString();
        animalDetail=detailModel;
        
        setIsDataFetched(false);
      }
    }catch(error){
      
    }
  }

  getVacineDetail(BuildContext context,String month,year, id,)async{
    setIsDataFetched(true);
    final url = Uri.parse("${GlobalApi.baseApi}${GlobalApi.getVacineDetail}$id/$month");
    print(url);

    var headers = {
    'Authorization':
        'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
  };

    try{
      final response = await http.get(url,headers: headers);
     // MedicalDetailModel detailModel = MedicalDetailModel.fromJson(json.decode(response.body));
    
      //debugger();
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        _vacineCount =data['vaccinationCount'].toString();
        //animalDetail=detailModel;
        setIsDataFetched(false);
      }
    }catch(error){
      
    }
  }


  deleteMilk(String id, BuildContext context)async{
   // setIsDataFetched(true);
    final url = Uri.parse("${GlobalApi.baseApi}${GlobalApi.deleteCowMilk}$id");
    print(url);

    var headers = {
    'Authorization':
        'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
  };

    try{
      final response = await http.delete(url,headers: headers);
     // MedicalDetailModel detailModel = MedicalDetailModel.fromJson(json.decode(response.body));
    
      //debugger();
      if(response.statusCode==200){
      //  setIsDataFetched(false);
      }
    }catch(error){
      
    }
  }
}
