import 'dart:convert';

import 'package:dairyfarmflow/API/global_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:simple_toast_message/simple_toast.dart';

import '../../Model/Worker/task_model.dart';
import '../user_detail.dart';

class WorkerProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<void> addTask(BuildContext context, String id, String description,
      String dueDate, String createdtAt) async {
    isLoading = true;
    notifyListeners();

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

  Future<TaskModel?> fetchAllTasks(BuildContext context)async{
    isLoading =true;
    notifyListeners();
    final url = Uri.parse("${GlobalApi.baseApi}${GlobalApi.getAllTasks}");
    try{


      final headers = {
        'Authorization':
            'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
      };

      final response = await http.get(url, headers: headers);
      TaskModel taskModel = TaskModel.fromJson(json.decode(response.body));
      if(response.statusCode == 200){
       return taskModel;

      }else{
        SimpleToast.showErrorToast(context, "Error", taskModel.message.toString());
      }

    }catch(e){
      SimpleToast.showErrorToast(context, "Error", e.toString());
    }

  }
}
