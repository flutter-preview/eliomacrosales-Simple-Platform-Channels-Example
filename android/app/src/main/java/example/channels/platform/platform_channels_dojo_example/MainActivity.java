package example.channels.platform.platform_channels_dojo_example;

import android.annotation.SuppressLint;
import android.location.Location;
import android.os.Build;
import android.os.Bundle;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.NonNull;

import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationCallback;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationResult;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.location.Priority;

import java.util.HashMap;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity implements EventChannel.StreamHandler {
    private FusedLocationProviderClient fusedLocationClient;
    private LocationRequest locationRequest;
    private EventChannel.EventSink events;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        this.fusedLocationClient = LocationServices.getFusedLocationProviderClient(this);
        super.onCreate(savedInstanceState);

    }

    private LocationCallback locationCallback = new LocationCallback() {
        @Override
        public void onLocationResult(@NonNull LocationResult locationResult) {
            if (locationResult != null) {
                Location location = locationResult.getLastLocation();
                Log.i("GPS location lat ", "" + location.getLongitude());
                Log.i("GPS location lan ", "" + location.getLatitude());
                if(events!=null){
                    HashMap<String,Double> data = new HashMap<>();
                    data.put("lat", location.getLatitude());
                    data.put("lon", location.getLongitude());
                    events.success(data);
                }
            }
        }
    };

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        BinaryMessenger messenger = flutterEngine.getDartExecutor().getBinaryMessenger();
        MethodChannel methodChannel = new MethodChannel(messenger, "implementation.channel");
        EventChannel eventChannel = new EventChannel(messenger, "geolocation.listener");
        eventChannel.setStreamHandler(this);
        methodChannel.setMethodCallHandler((MethodCall call, MethodChannel.Result result) -> {

            switch (call.method) {
                case "version":
                    getAndroidVersion(result);
                    break;
                case "startLocation":
                    startLocation();

                    break;

                case "stopLocation":
                    stoptLocation();
                    break;


                default:
                    result.notImplemented();

            }
        });
    }

    void getAndroidVersion(MethodChannel.Result result) {
        Integer sdkVerion = Build.VERSION.SDK_INT;
        String release = Build.VERSION.RELEASE;
        result.success("Android version: " + sdkVerion + " (" + release + ")");
    }

    @SuppressLint("MissingPermission")
    void startLocation() {
        locationRequest = new LocationRequest.Builder(Priority.PRIORITY_HIGH_ACCURACY, 100)
                .setWaitForAccurateLocation(false)
                .setMinUpdateIntervalMillis(2000)
                .setMaxUpdateDelayMillis(100)
                .build();

        fusedLocationClient.requestLocationUpdates(locationRequest,
                locationCallback,
                Looper.getMainLooper()

        );
    }

    void stoptLocation() {
        fusedLocationClient.removeLocationUpdates(locationCallback);
    }

    @Override
    protected void onDestroy() {
        stoptLocation();
        super.onDestroy();
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        this.events = events;
    }

    @Override
    public void onCancel(Object arguments) {

    }
}
