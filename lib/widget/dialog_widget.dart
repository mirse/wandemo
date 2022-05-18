import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

typedef OnSure();
typedef OnCancel();

class MyDialog extends StatelessWidget {
  String? title;
  late String content;
  String? cancelText;
  late String sureText;
  OnSure onSure;
  OnCancel? onCancel;

  MyDialog(this.content, this.sureText, this.onSure,
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
              Get.back();
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
