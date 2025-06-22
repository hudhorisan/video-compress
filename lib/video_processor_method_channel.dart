import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'video_processor_platform_interface.dart';

/// An implementation of [VideoProcessorPlatform] that uses method channels.
class MethodChannelVideoProcessor extends VideoProcessorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('video_processor');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
