import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oktoast/oktoast.dart';

class ToastUtils{
  static void showMyToast(var msg){
    // Fluttertoast.showToast(
    //     msg: msg,
    //     backgroundColor: Colors.grey,
    //     textColor: Colors.white,
    //     toastLength: Toast.LENGTH_SHORT,
    // );
    showToast(
      msg,
      position:ToastPosition(align: Alignment.bottomCenter, offset: 0.0)
    );
  }
}