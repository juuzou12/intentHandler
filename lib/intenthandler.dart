
import 'intenthandler_platform_interface.dart';

class Intenthandler {
  Future<String?> getPlatformVersion() {
    return IntenthandlerPlatform.instance.getPlatformVersion();
  }
  Future<String?> doPrint() {
    return IntenthandlerPlatform.instance.doPrint();
  }
}
