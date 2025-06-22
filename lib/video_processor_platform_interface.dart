import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'video_processor_method_channel.dart';

abstract class VideoProcessorPlatform extends PlatformInterface {
  /// Constructs a VideoProcessorPlatform.
  VideoProcessorPlatform() : super(token: _token);

  static final Object _token = Object();

  static VideoProcessorPlatform _instance = MethodChannelVideoProcessor();

  /// The default instance of [VideoProcessorPlatform] to use.
  ///
  /// Defaults to [MethodChannelVideoProcessor].
  static VideoProcessorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VideoProcessorPlatform] when
  /// they register themselves.
  static set instance(VideoProcessorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
