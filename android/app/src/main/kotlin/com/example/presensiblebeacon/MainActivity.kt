package com.example.presensiblebeacon
import io.flutter.embedding.android.FlutterActivity
// import com.umair.beacons_plugin.BeaconsPlugin

class MainActivity : FlutterActivity(){

    override fun onPause() {
        super.onPause()
        // BeaconsPlugin.startBackgroundService(this)
    }

    override fun onResume() {
        super.onResume()
        // BeaconsPlugin.stopBackgroundService(this)
    }
}
