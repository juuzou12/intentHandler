import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'intenthandler_method_channel.dart';

abstract class IntenthandlerPlatform extends PlatformInterface {
  /// Constructs a IntenthandlerPlatform.
  IntenthandlerPlatform() : super(token: _token);

  static final Object _token = Object();

  static IntenthandlerPlatform _instance = MethodChannelIntenthandler();

  /// The default instance of [IntenthandlerPlatform] to use.
  ///
  /// Defaults to [MethodChannelIntenthandler].
  static IntenthandlerPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IntenthandlerPlatform] when
  /// they register themselves.
  static set instance(IntenthandlerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> doPrint() {
    throw UnimplementedError('doPrint() has not been implemented.');
  }
}
