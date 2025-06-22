import 'package:flutter_test/flutter_test.dart';
import 'package:video_processor/video_processor.dart';
import 'package:video_processor/video_processor_platform_interface.dart';
import 'package:video_processor/video_processor_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockVideoProcessorPlatform
    with MockPlatformInterfaceMixin
    implements VideoProcessorPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final VideoProcessorPlatform initialPlatform = VideoProcessorPlatform.instance;

  test('$MethodChannelVideoProcessor is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelVideoProcessor>());
  });

  test('getPlatformVersion', () async {
    VideoProcessor videoProcessorPlugin = VideoProcessor();
    MockVideoProcessorPlatform fakePlatform = MockVideoProcessorPlatform();
    VideoProcessorPlatform.instance = fakePlatform;

    expect(await videoProcessorPlugin.getPlatformVersion(), '42');
  });
}
