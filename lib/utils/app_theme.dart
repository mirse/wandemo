import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.blueAccent,
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.blueAccent,
      elevation: 0.0,
      systemOverlayStyle: darkSystemUiStyle
  ),
  textTheme: TextTheme(
      headline1:TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.normal),
      bodyText1: TextStyle(color: Colors.black,fontSize: 15),
      bodyText2: TextStyle(color: Colors.black,fontSize: 12)
  ),
  shadowColor: Colors.blueGrey.shade300,
  cardColor: Colors.white,
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor:Colors.black,
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0.0,
      systemOverlayStyle: lightSystemUiStyle
  ),
    textTheme: TextTheme(
      headline1:TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
      bodyText1: TextStyle(color: Colors.white,fontSize: 15),
      bodyText2: TextStyle(color: Colors.white,fontSize: 12),
    ),
    shadowColor: Colors.blueGrey,
    cardColor: Colors.black,
);

///导航栏透明并且状态栏字体颜色为白色
SystemUiOverlayStyle lightSystemUiStyle = SystemUiOverlayStyle.light.copyWith(
  systemNavigationBarColor: Colors.transparent,
);

///导航栏透明并且状态栏字体颜色为黑色
SystemUiOverlayStyle darkSystemUiStyle = SystemUiOverlayStyle.dark.copyWith(
  systemNavigationBarColor: Colors.transparent,
);