#import "ScreenKeepOnPlugin.h"

@implementation ScreenKeepOnPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"cindyu.com/screen_keep_on"
            binaryMessenger:[registrar messenger]];
  ScreenKeepOnPlugin* instance = [[ScreenKeepOnPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getBrightness" isEqualToString:call.method]) {
      result([NSNumber numberWithFloat:[UIScreen mainScreen].brightness]);
    }
    else if ([@"setBrightness" isEqualToString:call.method]) {
      NSNumber *brightness = call.arguments[@"brightness"];
      [[UIScreen mainScreen] setBrightness:brightness.floatValue];
      result(nil);
    }
    else if ([@"isOn" isEqualToString:call.method]) {
      bool isIdleTimerDisabled =  [[UIApplication sharedApplication] isIdleTimerDisabled];
      result([NSNumber numberWithBool:isIdleTimerDisabled]);
    }
    else if ([@"turnOn" isEqualToString:call.method]) {
      NSNumber *b = call.arguments[@"turnOn"];
      [[UIApplication sharedApplication] setIdleTimerDisabled:b.boolValue];
    } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
