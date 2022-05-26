import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wandemo/notifier/login_notifier.dart';
import '../controller/login_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  Widget loginWidget(BuildContext context) {
    return SingleChildScrollView(
        //fix bottom overflowed by
        child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: ChangeNotifierProvider(
                create: (ctx) => LoginNotifier(),
                child: Consumer<LoginNotifier>(
                  builder: (ctx, login, child) {
                    return Column(
                      children: [
                        Container(
                            child: Theme(
                              data: ThemeData(
                                  primaryColor: Colors.yellow, // 主色，决定导航栏颜色
                                  primarySwatch: Colors.brown // 主题颜色样本
                                  ),
                              child: TextField(
                                decoration: InputDecoration(
                                  //去除下划线
                                  labelText: 'account'.tr,
                                  hintText: 'input_account'.tr,
                                  filled: true,
                                  //是否填充
                                  // fillColor: Colors.grey,//填充颜色
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  //isCollapsed: true,//高度包裹
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 0, bottom: 0),
                                  icon: Icon(Icons.person),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      _textEditingController.clear();
                                    },
                                  ),
                                  // enabledBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: Color(0xffB6B6B6), width: 0.5)),
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: Color(0xffFD3F2A), width: 1)),
                                ),
                                // maxLength: 5,
                                controller: _textEditingController,
                                style: TextStyle(fontSize: 15),
                                onChanged: (value) {
                                  login.setUserNameCache = value;
                                },
                              ),
                            ),
                            margin: EdgeInsets.fromLTRB(15, 25, 15, 0)),
                        //obscureText: true,
                        Container(
                            child: Theme(
                              data: ThemeData(
                                  primaryColor: Colors.yellow, // 主色，决定导航栏颜色
                                  primarySwatch: Colors.brown // 主题颜色样本
                                  ),
                              child: TextField(
                                decoration: InputDecoration(
                                  //去除下划线
                                  labelText: 'pwd'.tr,
                                  hintText: 'input_pwd'.tr,
                                  filled: true,
                                  //是否填充
                                  // fillColor: Colors.grey,//填充颜色
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  //isCollapsed: true,//高度包裹
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 0, bottom: 0),
                                  icon: Icon(Icons.vpn_key_sharp),
                                  suffixIcon: IconButton(
                                    icon: Icon(!login.isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      login.setObscure =
                                          !login.isObscure;
                                    },
                                  ),
                                  // enabledBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: Color(0xffB6B6B6), width: 0.5)),
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: Color(0xffFD3F2A), width: 1)),
                                ),
                                // maxLength: 5,

                                style: TextStyle(fontSize: 15),
                                obscureText: login.isObscure,
                                onChanged: (value) {
                                  login.setPwdCache = value;
                                },
                              ),
                            ),
                            margin: EdgeInsets.fromLTRB(15, 25, 15, 0)),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                          child: TextButton(
                              onPressed: login.isLoginBtnEnable
                                  ? () {
                                      print(
                                          'isLoginBtnEnable:${login.isLoginBtnEnable}');
                                      FocusScope.of(context).unfocus();
                                      login.login();
                                    }
                                  : null,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    login.isLoginBtnEnable
                                        ? Colors.blue.shade300
                                        : Colors.grey.shade300),
                                // side: MaterialStateProperty.all(
                                //     BorderSide(width: 1, color: Colors.blueAccent)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18))),
                                minimumSize: MaterialStateProperty.all(
                                    Size(double.infinity, 40)),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.login,
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                          child: TextButton(
                              onPressed: () {
                                //注册
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.grey.shade300),
                                // side: MaterialStateProperty.all(
                                //     BorderSide(width: 1, color: Colors.blueAccent)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18))),
                                minimumSize: MaterialStateProperty.all(
                                    Size(double.infinity, 40)),
                              ),
                              child: Text(
                                'register'.tr,
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    );
                  },
                ))));
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
            child: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            top: 35,
            left: 10,
          ),
          Positioned.fill(
            //Positioned.fill方法将填充Stack的整个空间。
            top: 200,
            left: 0,
            child: loginWidget(context),
          ),
        ],
      ),
    );
  }
}
