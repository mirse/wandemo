import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        //Stack的fit属性 默认是适应子widget大小 , 即如果没有定位的widget,Stack的宽高将以宽高最大的子widget为基础
        children: [
          Positioned(
            height: 220,
            child: Container(
                //  width: MediaQuery.of(context).size.width,
                child: Image.asset(
              'assets/imgs/ic_login.png',
              fit: BoxFit.fitWidth,
            )),
          ),
          Positioned(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            top: 35,
            left: 10,
          ),
          Positioned.fill(
              //Positioned.fill方法将填充Stack的整个空间。
              top: 200,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '账号',
                          hintText: '请输入账号'
                        ),
                      ),
                      margin: EdgeInsets.all(10),
                    ),
                    Container(
                        child: TextField(
                      decoration: InputDecoration(
                        labelText: '密码',
                          hintText: '请输入密码'
                      ),),
                      margin: EdgeInsets.all(10),
                    ),
                    SizedBox(height: 30,),
                    TextButton(
                          onPressed: () {
                            print("aaa");
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.transparent),
                            side: MaterialStateProperty.all(BorderSide(
                              width: 1,
                              color: Colors.blueAccent
                            )),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)
                            )),
                            minimumSize: MaterialStateProperty.all(Size(200, 40)),
                          ),
                          child: Text('登录',style: TextStyle(color: Colors.black),)),

                  ],
                ),
              )),
        ],
      ),
    );
  }
}
