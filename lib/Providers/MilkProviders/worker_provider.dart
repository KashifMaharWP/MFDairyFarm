import 'dart:convert';
import 'dart:developer';

import 'package:dairyfarmflow/API/global_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:simple_toast_message/simple_toast.dart';

import '../../Model/Worker/task_model.dart';
import '../../Model/Worker/user_task_model.dart';
import '../user_detail.dart';

class WorkerProvider extends ChangeNotifier {
  bool isLoading = false;
  bool _isTaskLoading=false;
  bool get isTaskLoading => _isTaskLoading;
  TaskModel? TaskList;
  

   

  setTaskLoading(bool value) {
    _isTaskLoading = value;
    notifyListeners();
  }

  Future<void> addTask(BuildContext context, String id, String description,
      String dueDate, String createdtAt) async {
    isLoading = true;
    //notifyListeners();

    final url = Uri.parse("${GlobalApi.baseApi}${GlobalApi.addTask}");
    try {
      dynamic body = {
        "description": description,
        "assignedTo": id,
        "createdAt": createdtAt,
        "dueDate": dueDate
      };
      final headers = {
        'Authorization':
            'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
      };
      final response = await http.post(url, body: body, headers: headers);
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        isLoading = false;
        notifyListeners();
        SimpleToast.showSuccessToast(
            context, "Success", jsonResponse['message']);
      } else {
         isLoading = false;
        notifyListeners();
        SimpleToast.showErrorToast(context, "Error", jsonResponse['message']);
      }
    } catch (e) {
       isLoading = false;
        notifyListeners();
      SimpleToast.showErrorToast(context, "Error", e.toString());
    }
  }



  // Get All Workers Tasks 

  fetchAllTasks(BuildContext context)async{
     setTaskLoading(true);
    final url = Uri.parse("${GlobalApi.baseApi}${GlobalApi.getAllTasks}");
    try{


      final headers = {
        'Authorization':
            'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
      };
      //debugger();
      final response = await http.get(url, headers: headers);
        final taskResponse=json.decode(response.body);
      TaskModel TaskmodelList = TaskModel.fromJson(taskResponse);
      if(response.statusCode == 200){
        TaskList=TaskmodelList;
        setTaskLoading(false);
      
      }else{
        SimpleToast.showErrorToast(context, "Error", TaskmodelList.message.toString());
        setTaskLoading(false);
      }

    }catch(e){
      SimpleToast.showErrorToast(context, "Error", e.toString());
    }
    

  }

  fetchTaskById(BuildContext context)async{
   // final id = Provider.of<UserDetail>(context, listen: false).id;
    String id ='67727231fa6ea6db2684d557';
   
    isLoading =true;
    //notifyListeners();
    final url = Uri.parse("${GlobalApi.baseApi}${GlobalApi.getTaskById}$id");
    print(url);
    try{
       final headers = {
        'Authorization':
            'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
      };
      //debugger();
      final response = await http.get(url, headers: headers);
      final taskResponse=json.decode(response.body);
      TaskModel TaskmodelList = TaskModel.fromJson(taskResponse);
      if(response.statusCode=='200'){
        TaskList=TaskmodelList;
        return TaskList;
      }

    }catch(err){
      SimpleToast.showErrorToast(context, "Error", err.toString());

    }
    return TaskList;
    
  }


   updateTask(BuildContext context,String id) async{
    //setTaskLoading(true);
    final url = Uri.parse("${GlobalApi.baseApi}${GlobalApi.taskStatus}$id");
    try{
      final headers = {
        'Authorization':
            'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
      };
      //debugger();
      final respnonse = await http.patch(url, headers: headers);
      final jsonResponse = jsonDecode(respnonse.body);
      if(jsonResponse['success']== true){
        final index =
            TaskList!.tasks!.indexWhere((task) => task!.sId == id);
        if (index != -1) {
            //TaskModel task=TaskList.tasks;
            TaskList!.tasks![index].taskStatus = !(TaskList?.tasks![index].taskStatus??false);
        }
        
        //setTaskLoading(false);
        notifyListeners();
        //SimpleToast.showSuccessToast(context, 'Success', jsonResponse['message']);
      }
      else{
        SimpleToast.showErrorToast(context, "Error", jsonResponse['message']);
       // setTaskLoading(false);
      }
    }
    catch(err){
      //SimpleToast.showErrorToast(context, "Error", err.toString());

    }

  }
}
