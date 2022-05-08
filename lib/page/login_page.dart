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
      body: Stack(//Stack的宽高将以宽高最大的子widget为基础
          children: [
            Container(
                width: double.infinity,
                child: Image.asset('assets/imgs/ic_login.png',height: 200,fit: BoxFit.fitWidth,)),
            Positioned(child: Icon(Icons.arrow_back,color: Colors.black,),top: 35,left: 10,),
            Positioned(
                top: 0,
                left: 0,
                child:Container(
                  width: 300,
                  color: Colors.red,
                  // decoration: BoxDecoration(
                  //   color: Colors.red,
                  //   borderRadius:BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                  // ),
                  // child: Column(
                  //   children: [
                  //     Expanded(child: TextField(
                  //       decoration: InputDecoration(
                  //         labelText: '账号',
                  //       ),
                  //     )),
                  //     Expanded(child: TextField(
                  //       decoration: InputDecoration(
                  //         labelText: '密码',
                  //       ),
                  //     )),
                  //     TextButton(onPressed: () {
                  //       print("aaa");
                  //     },
                  //     child: Text('登录'))
                  //   ],
                  // ),
                )
            ),


          ],
      ),
    );
  }
}
