import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class ToastUtils{
  static void showMyToast(var msg){
    showToast(
      msg,
      position:ToastPosition(align: Alignment.bottomCenter, offset: 0.0),
      backgroundColor: Colors.grey,
      textStyle: TextStyle(fontSize: 16),
      textPadding: EdgeInsets.all(8)
    );
  }
}