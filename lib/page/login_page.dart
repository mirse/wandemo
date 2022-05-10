import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
    controller?.addListener(() {});
  }

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
                        child: Theme(
                          data: ThemeData(
                              primaryColor: Colors.yellow,// 主色，决定导航栏颜色
                              primarySwatch:Colors.brown // 主题颜色样本
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              //去除下划线
                              labelText: '账号',
                              hintText: '请输入账号',
                              filled: true,
                              //是否填充
                              // fillColor: Colors.grey,//填充颜色
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),

                              ),
                              isCollapsed: true,
                              //高度包裹
                              contentPadding: EdgeInsets.all(10),
                              icon: Icon(Icons.person),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  controller?.clear();
                                },
                              ),
                                // enabledBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(color: Color(0xffB6B6B6), width: 0.5)),
                                // focusedBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(color: Color(0xffFD3F2A), width: 1)),

                            ),
                            // maxLength: 5,
                            controller: controller,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        margin: EdgeInsets.fromLTRB(15, 25, 15, 0)),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '密码',
                          hintText: '请输入密码',
                        ),
                        obscureText: true,
                      ),
                      margin: EdgeInsets.all(10),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: () {
                          print("aaa");
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          side: MaterialStateProperty.all(
                              BorderSide(width: 1, color: Colors.blueAccent)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          minimumSize: MaterialStateProperty.all(Size(200, 40)),
                        ),
                        child: Text(
                          '登录',
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
