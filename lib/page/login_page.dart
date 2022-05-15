import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wandemo/http/http_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/toast_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controller = TextEditingController();
  bool _isObscure  = true;
  String _userName = '';
  String _pwd = '';
  bool _isLoginable = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      _userName = _controller.text;
      setState(() {
        _isLoginable = _getLoginable();
      });
    });
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
                              //isCollapsed: true,//高度包裹
                              contentPadding: EdgeInsets.only(left: 10,top: 0, bottom: 0),
                              icon: Icon(Icons.person),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  _controller.clear();
                                },
                              ),
                                // enabledBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(color: Color(0xffB6B6B6), width: 0.5)),
                                // focusedBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(color: Color(0xffFD3F2A), width: 1)),

                            ),
                            // maxLength: 5,
                            controller: _controller,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        margin: EdgeInsets.fromLTRB(15, 25, 15, 0)),
                    //obscureText: true,
                    Container(
                        child: Theme(
                          data: ThemeData(
                              primaryColor: Colors.yellow,// 主色，决定导航栏颜色
                              primarySwatch:Colors.brown // 主题颜色样本
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              //去除下划线
                              labelText: '密码',
                              hintText: '请输入密码',
                              filled: true,
                              //是否填充
                              // fillColor: Colors.grey,//填充颜色
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(5)),

                              ),
                              //isCollapsed: true,//高度包裹
                              contentPadding: EdgeInsets.only(left: 10,top: 0, bottom: 0),
                              icon: Icon(Icons.vpn_key_sharp),
                              suffixIcon: IconButton(
                                icon: Icon(_isObscure?Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                              // enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(color: Color(0xffB6B6B6), width: 0.5)),
                              // focusedBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(color: Color(0xffFD3F2A), width: 1)),

                            ),
                            // maxLength: 5,

                            style: TextStyle(fontSize: 15),
                            obscureText:_isObscure,
                            onChanged: (value){
                              _pwd = value;
                              setState(() {
                                _isLoginable = _getLoginable();
                              });
                            },
                          ),
                        ),
                        margin: EdgeInsets.fromLTRB(15, 25, 15, 0)
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20,left: 30,right: 30),
                      child: TextButton(
                          onPressed:_isLoginable?() {
                            FocusScope.of(context).unfocus();
                            _login();
                          }:null,
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(_isLoginable?Colors.blue.shade300:Colors.grey.shade300),
                            // side: MaterialStateProperty.all(
                            //     BorderSide(width: 1, color: Colors.blueAccent)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18))),
                            minimumSize: MaterialStateProperty.all(Size(double.infinity, 40)),
                          ),
                          child: Text(
                            '登录',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20,left: 30,right: 30),
                      child: TextButton(
                          onPressed:() {
                            //注册
                          },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.grey.shade300),
                            // side: MaterialStateProperty.all(
                            //     BorderSide(width: 1, color: Colors.blueAccent)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18))),
                            minimumSize: MaterialStateProperty.all(Size(double.infinity, 40)),
                          ),
                          child: Text(
                            '注册',
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  bool _getLoginable(){
    return _userName.isNotEmpty && _pwd.isNotEmpty;
  }

  void _login(){
    HttpManager().login(
        data: FormData.fromMap(
          {'username':_userName,'password':_pwd},
        ),
        success: (data){
          ToastUtils.showToast('登录成功');
        },fail:(errorCode,msg){
          print('登录失败:${errorCode},${msg}');
          ToastUtils.showToast('登录失败：${msg}');
        }
        );
  }
}
