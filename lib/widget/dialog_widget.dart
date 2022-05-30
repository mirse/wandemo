import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../generated/l10n.dart';

typedef OnSure();
typedef OnCancel();

class MyDialog extends StatelessWidget {
  String? title;
  late String content;
  String? cancelText;
  late String sureText;
  OnSure onSure;
  OnCancel? onCancel;
  var ctx;

  MyDialog(this.ctx,this.content, this.sureText, this.onSure,
      {this.title, this.cancelText, this.onCancel});

  List<Widget> get _bottomWidget {
    List<Widget> widgets = [];
    if (cancelText != null && onCancel != null) {
      widgets.add(Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Container(
          height: 45,
          child: TextButton(
            child: Text(
              cancelText!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              onCancel;
            },
          ),
        ),
      ));
      widgets.add(SizedBox(
        width: 1,
        child: Center(
          child: Container(
            width: 1,
            //margin: EdgeInsetsDirectional.only(start: indent, end: endIndent),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  width: 0,
                ),
              ),
            ),
          ),
        ),
      ));
    }
    widgets.add(
      Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Container(
          height: 45,
          child: TextButton(
            child: Text(sureText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black)),
            onPressed: onSure,
          ),
        ),
      ),
    );
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(top: 20.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 16),
        ],
      ),
      buttonPadding: EdgeInsets.all(0.0),
      //dialog action间距
      actions: <Widget>[
        SizedBox(
          height: 1,
          child: Center(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 45,
          child: Row(
            children: _bottomWidget,
          ),
        )
      ],
    );
  }
}

class LoadingDialog extends StatelessWidget {


  LoadingDialog();

  //展示加载框
  static void show(ctx) {
    showDialog(context: ctx, builder: (ctx){
      return LoadingDialog();
    });

  }

  //关闭加载框
  static void dismiss() {
    Get.back();
  }

  //关闭加载框
  static void dismissDialog(ctx) {
    Navigator.pop(ctx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 120,
          height: 100,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
             borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                ),
                width: 40,
                height: 40,
              ),
              SizedBox(height: 10),
              Text(S.of(context).loading)
            ],
          ),
        ),
      ),
    );
  }
}
