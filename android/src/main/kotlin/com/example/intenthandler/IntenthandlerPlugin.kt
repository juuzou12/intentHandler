package com.example.intenthandler

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.provider.ContactsContract
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

/** IntenthandlerPlugin */
class IntenthandlerPlugin: FlutterPlugin, MethodCallHandler, PluginRegistry.ActivityResultListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  val APOS_SDK_CODE = 8989
  var act: Activity? = null
  private lateinit var result: Result

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "intenthandler")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    this.result = result
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }else if (call.method == "doPrint"){
      ContactsContract.Contacts.CONTENT_URI

      val intent = Intent()
      intent.action = "apos.sdktool"
      intent.type = "text/plain"
      act?.startActivityForResult(intent, APOS_SDK_CODE)
    } else {
      result.notImplemented()
    }
  }





  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    if (requestCode == APOS_SDK_CODE) {
      if (resultCode == Activity.RESULT_OK) {
        result.success(data!!.getStringExtra("resp"))
        return true
      }
    }
    return false;
  }
}
