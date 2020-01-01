//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <firebase_messaging/FirebaseMessagingPlugin.h>
#import <flutter_local_notifications/FlutterLocalNotificationsPlugin.h>
#import <google_maps_flutter/GoogleMapsPlugin.h>
#import <imei_plugin/ImeiPlugin.h>
#import <location/LocationPlugin.h>
#import <shared_preferences/SharedPreferencesPlugin.h>
#import <speech_bubble/SpeechBubblePlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTFirebaseMessagingPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseMessagingPlugin"]];
  [FlutterLocalNotificationsPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterLocalNotificationsPlugin"]];
  [FLTGoogleMapsPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTGoogleMapsPlugin"]];
  [ImeiPlugin registerWithRegistrar:[registry registrarForPlugin:@"ImeiPlugin"]];
  [LocationPlugin registerWithRegistrar:[registry registrarForPlugin:@"LocationPlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
  [SpeechBubblePlugin registerWithRegistrar:[registry registrarForPlugin:@"SpeechBubblePlugin"]];
}

@end
