
import 'intenthandler_platform_interface.dart';

class Intenthandler {
  Future<String?> getPlatformVersion() {
    return IntenthandlerPlatform.instance.getPlatformVersion();
  }
  Future<String?> callSdkIntent(String action, var payload) {
    // ignore: avoid_print
    print("instance of intentHandlerPlatform for doPrint()------");
    return IntenthandlerPlatform.instance.callSdkIntent({
      "action":action,
      "payload":payload
    });
  }
  Future<String?> broadCastReceiverIntent(String action, String payload) {
    // ignore: avoid_print
    print("instance of intentHandlerPlatform for broadCastReceiverIntent------");
    return IntenthandlerPlatform.instance.broadCastIntent({
      "action":action,
      "payload":payload
    });
  }

}
