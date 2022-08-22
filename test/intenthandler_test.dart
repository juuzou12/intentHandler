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
  Future<String?> doPrint() {
    return Future.value("Sample works!!");
  }


}

void main() {
  final IntenthandlerPlatform initialPlatform = IntenthandlerPlatform.instance;

  test('$MethodChannelIntenthandler is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIntenthandler>());
  });

  test('getPlatformVersion', () async {
    Intenthandler intenthandlerPlugin = Intenthandler();
    MockIntenthandlerPlatform fakePlatform = MockIntenthandlerPlatform();
    IntenthandlerPlatform.instance = fakePlatform;

    expect(await intenthandlerPlugin.getPlatformVersion(), '42');
  });

  test("doPrint", () async {
    Intenthandler intenthandlerPlugin = Intenthandler();
    MockIntenthandlerPlatform fakePlatform = MockIntenthandlerPlatform();
    IntenthandlerPlatform.instance = fakePlatform;

    expect(await intenthandlerPlugin.doPrint(), "Sample works!!");
  });
}
