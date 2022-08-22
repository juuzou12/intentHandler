import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'intenthandler_platform_interface.dart';

/// An implementation of [IntenthandlerPlatform] that uses method channels.
class MethodChannelIntenthandler extends IntenthandlerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('intenthandler');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> doPrint() async {
    final doPrintResponse = await methodChannel.invokeMethod<String>('doPrint');
    return doPrintResponse;
  }
}
