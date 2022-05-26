import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SortPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text('test'),
        onPressed: () {
          showToast();
        },
      ),
    );
  }

  Future<void> showToast() async {
    const platform = MethodChannel('native.call');
    await platform.invokeMethod('showToast','hello android');
  }
}