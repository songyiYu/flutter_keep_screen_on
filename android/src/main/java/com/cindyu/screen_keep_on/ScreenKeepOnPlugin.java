package com.cindyu.screen_keep_on;

import android.provider.Settings;
import android.view.Window;
import android.view.WindowManager;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** ScreenKeepOnPlugin */
public class ScreenKeepOnPlugin implements MethodCallHandler {

  private Registrar registrar;
  private Window currentWindow;

  /** Plugin registration. */
  private ScreenKeepOnPlugin(Registrar registrar){
    this.registrar = registrar;
    currentWindow = registrar.activity().getWindow();
  }

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "cindyu.com/screen_keep_on");
    channel.setMethodCallHandler(new ScreenKeepOnPlugin(registrar));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {

    switch(call.method){
      case "getBrightness":
        result.success(getBrightness());
        break;

      case "setBrightness":
        double brightness = call.argument("brightness");
        WindowManager.LayoutParams layoutParams = currentWindow.getAttributes();
        layoutParams.screenBrightness = (float)brightness;
        currentWindow.setAttributes(layoutParams);
        break;

      case "isOn":
        int flags = currentWindow.getAttributes().flags;
        result.success((flags & WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON) != 0) ;
        break;

      case "turnOn":
        Boolean turnOn = call.argument("turnOn");
        if (turnOn)
          currentWindow.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        else
          currentWindow.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        break;

      default:
        result.notImplemented();
        break;
    }
  }

  private float getBrightness(){
    float result = currentWindow.getAttributes().screenBrightness;
    if (result < 0) {
      try {
        result = Settings.System.getInt(registrar.context().getContentResolver(), Settings.System.SCREEN_BRIGHTNESS) / (float)255;
      } catch (Settings.SettingNotFoundException e) {
        result = 1.0f;
        e.printStackTrace();
      }
    }
    return result;
  }
}
