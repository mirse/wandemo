import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/app_theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  var _timeOut = 10;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn);
    animation = Tween(begin: 0.0, end: 300.0).animate(animation);
    // animation.addStatusListener((status) {
    //   if(status == AnimationStatus.completed){
    //     animationController.reverse()
    //   }
    //   else{
    //
    //   }
    // });

    animationController.repeat(reverse: true);

    Timer.periodic(Duration(seconds: 1), (timer) {
      _timeOut--;
      if (_timeOut <= 0) {
        Get.off('/');
      } else {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //return Container(color: Colors.blue,);
    return AnnotatedRegion(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            color: Colors.grey.shade300,
            child: Stack(
              children: [
                AnimatedImage(
                  animation: animation,
                  child: Image.asset('assets/imgs/ic_zan.png'),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.only(top:ScreenUtil().statusBarHeight  ,right: 10.w),
                      child: TextButton(
                        onPressed: () {
                          Get.off('/');
                        },
                        child: Container(
                          width: 80.w,
                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              Text("${_timeOut}s"),
                              SizedBox(width: 10,),
                              Text('Skip',style: TextStyle(color: Colors.black),)
                            ],
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey.shade500),
                          // side: MaterialStateProperty.all(
                          //     BorderSide(width: 1, color: Colors.blueAccent)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          minimumSize: MaterialStateProperty.all(Size(60, 40)),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
        value: lightSystemUiStyle);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key? key, required this.animation, this.child})
      : super(key: key, listenable: animation);
  Widget? child;
  Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
