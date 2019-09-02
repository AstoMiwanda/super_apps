package com.example.super_apps;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import android.provider.Settings;
import android.util.Log;

import java.util.List;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "samples.flutter.io/location";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, Result result) {

                if (call.method.equals("getLocation")) {
                  boolean b = getMockLocation();
                  result.success(b);
                } else if (call.method.equals("isMockSettingsON")) {
                    boolean b = isMockSettingsON( MainActivity.this);
                    result.success(b);
                } else {
                  result.notImplemented();
                }
              }
            });

  }

  public static boolean isMockSettingsON(Context context) {
    // returns true if mock location enabled, false if not enabled.
    if (VERSION.SDK_INT >= VERSION_CODES.CUPCAKE) {
      if (Settings.Secure.getString(context.getContentResolver(),
              Settings.Secure.ALLOW_MOCK_LOCATION).equals("0"))
        return false;
      else
        return true;
    }
    return false;
  }


  public static boolean areThereMockPermissionApps(Context context) {
    int count = 0;

    PackageManager pm = context.getPackageManager();
    List<ApplicationInfo> packages =
            pm.getInstalledApplications(PackageManager.GET_META_DATA);

    for (ApplicationInfo applicationInfo : packages) {
      try {
        PackageInfo packageInfo = pm.getPackageInfo(applicationInfo.packageName,
                PackageManager.GET_PERMISSIONS);

        // Get Permissions
        String[] requestedPermissions = packageInfo.requestedPermissions;

        if (requestedPermissions != null) {
          for (int i = 0; i < requestedPermissions.length; i++) {
            if (requestedPermissions[i]
                    .equals("android.permission.ACCESS_MOCK_LOCATION")
                    && !applicationInfo.packageName.equals(context.getPackageName())) {
              count++;
            }
          }
        }
      } catch (PackageManager.NameNotFoundException e) {
        Log.e("Got exception ", e.getMessage());
      }
    }

    if (count > 0)
      return true;
    return false;
  }


  private boolean getMockLocation() {
    boolean b;
    b = areThereMockPermissionApps(MainActivity.this);
    return b;
  }
}