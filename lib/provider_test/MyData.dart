import 'package:flutter/material.dart';

class Mydata extends ChangeNotifier{
  String Data = " i am string from Mydata";
  int number = 10;

  void changeData(String newString) {
    Data = newString;
    notifyListeners();
  }


}