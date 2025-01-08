import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier{
  String filtering ='';


  void filter(String selected){
    filtering = selected;
    notifyListeners();
    
  }
}