
import 'video_processor_platform_interface.dart';

class VideoProcessor {
  Future<String?> getPlatformVersion() {
    return VideoProcessorPlatform.instance.getPlatformVersion();
  }
}
