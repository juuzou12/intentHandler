package com.example.intenthandler

import android.app.Activity
import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry

/** IntenthandlerPlugin */
class IntenthandlerPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.ActivityResultListener {
    // The MethodChannel that will the communication between Flutter and native Android
    //
    // This local reference serves to register the plugin with the Flutter Engine and unregister it
    // when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    val APOS_SDK_CODE = 8989
    val APOS_sdktool_printValue = 8990
    var act: Activity? = null
    private lateinit var result: MethodChannel.Result

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "intenthandler")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        print("We are hitting the onMethodCall (IntenthandlerPlugin).......")
        this.result = result
        println("-------Method: ${call.method}--------")
        if (call.method == "getPlatformVersion") {
            print("getPlatformVersion happens in this sections.........")
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "callSdkIntent") {
            val intent = Intent()

            //trigger the print function after assigning value
            intent.action = "apos.sdktool"
            intent.type = "text/plain"
            intent.putExtra("action", call.argument<String>("action"))
            intent.putExtra("payload", call.argument<String>("payload"))
            call.arguments
            act?.startActivityForResult(intent, APOS_SDK_CODE)
            print("onPrint happens in this sections.........$act")
        } else {
            result.notImplemented()
        }
        val intent = Intent()
        intent.action = "com.example.intenthandler"
        intent.putExtra("test", call.argument<String>("payload"))
        act?.sendBroadcast(intent)
        println(intent)
    }

    fun broadcastIntent(payload: String) {
        val intent = Intent()
        intent.action = "com.example.intenthandler"
        intent.putExtra("test", payload)
        act?.sendBroadcast(intent)
        println(intent)
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
        return false
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        act = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        channel.setMethodCallHandler(null)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        act = binding.activity
    }

    override fun onDetachedFromActivity() {
        act = null
    }
}