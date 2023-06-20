package example.channels.platform.platform_channels_dojo_example;

import android.os.Build;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
      BinaryMessenger messenger = flutterEngine.getDartExecutor().getBinaryMessenger();
        MethodChannel methodChannel = new MethodChannel(messenger, "implementation.channel");
       methodChannel.setMethodCallHandler((MethodCall call, MethodChannel.Result result) -> {
          if( call.method.equals("version")){
        String osVErsion = getAndroidVersion();
        result.success(osVErsion);
          }
          else{
              result.notImplemented();
          }
       });
    }

    String getAndroidVersion(){
       Integer sdkVerion = Build.VERSION.SDK_INT ;
      String release = Build.VERSION.RELEASE;
      return "Android version: " +sdkVerion+ " (" +release +")" ;

    }
}
