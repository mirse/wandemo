package com.wdz.wandemo

import android.os.Bundle
import android.util.Log
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    val CHANNEL = "native.call"
    //samples.flutter.dev/battery

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.i("TAG","onCreate");

        val channel = MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger,CHANNEL);
        channel.setMethodCallHandler { call, result ->
            if (call.method == "showToast"){
                Toast.makeText(context,call.arguments as String,Toast.LENGTH_SHORT).show();
            }
        }
    }

}
