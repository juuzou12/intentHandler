import 'package:flutter_test/flutter_test.dart';
import 'package:intenthandler/intenthandler.dart';
import 'package:intenthandler/intenthandler_platform_interface.dart';
import 'package:intenthandler/intenthandler_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIntenthandlerPlatform
    with MockPlatformInterfaceMixin
    implements IntenthandlerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> callSdkIntent(Map data) {
    return Future.value("Sample works!!");
  }

  @override
  Future<String?> broadCastIntent(Map data) {
    return Future.value("Sample works!!");
  }


}

void main() {

  test('$MethodChannelIntenthandler is the default instance', () {

  });

  test('getPlatformVersion', () async {
    Intenthandler intenthandlerPlugin = Intenthandler();
    MockIntenthandlerPlatform fakePlatform = MockIntenthandlerPlatform();
    IntenthandlerPlatform.instance = fakePlatform;

    expect(await intenthandlerPlugin.getPlatformVersion(), '42');
  });

  test("callSdkIntent", () async {
    Intenthandler intenthandlerPlugin = Intenthandler();
    MockIntenthandlerPlatform fakePlatform = MockIntenthandlerPlatform();
    IntenthandlerPlatform.instance = fakePlatform;

    expect(await intenthandlerPlugin.callSdkIntent("test", "test"), "Sample works!!");
  });

  test("broadCastIntent", () async {
    Intenthandler intenthandlerPlugin = Intenthandler();
    MockIntenthandlerPlatform fakePlatform = MockIntenthandlerPlatform();
    IntenthandlerPlatform.instance = fakePlatform;

    expect(await intenthandlerPlugin.broadCastReceiverIntent("test", "test"), "Sample works!!");
  });
}
