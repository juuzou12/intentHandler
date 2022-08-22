#import "IntenthandlerPlugin.h"
#if __has_include(<intenthandler/intenthandler-Swift.h>)
#import <intenthandler/intenthandler-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "intenthandler-Swift.h"
#endif

@implementation IntenthandlerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIntenthandlerPlugin registerWithRegistrar:registrar];
}
@end
