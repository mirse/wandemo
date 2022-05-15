import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils{
  static void  showToast(var msg){
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
    );
  }
}