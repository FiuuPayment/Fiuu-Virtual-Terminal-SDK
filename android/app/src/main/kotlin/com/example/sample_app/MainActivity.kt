package com.example.sample_app

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.EventChannel
import org.json.JSONException
import org.json.JSONObject

class MainActivity: FlutterActivity() {
    private val EVENT = "flutter.native/merchantdeeplink"
    private val TAG = "MerchantApp"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        EventChannel(flutterEngine!!.dartExecutor.binaryMessenger, EVENT).setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(args: Any?, events: EventChannel.EventSink) {
                        Log.d(TAG, "adding listener");
                        val intent: Intent = intent
                        if (intent.data!= null) {
                            events.success(intent.data.toString())
                        }
                    }

                    override fun onCancel(args: Any?) {

                    }
                }
        )
    }
}
