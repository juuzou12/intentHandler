import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intenthandler/intenthandler_method_channel.dart';

void main() {
  MethodChannelIntenthandler platform = MethodChannelIntenthandler();
  const MethodChannel channel = MethodChannel('intenthandler');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMethodCallHandler((call)async =>{
      '42',
    });
  });

  tearDown(() {
    channel.setMethodCallHandler((call)async => null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
