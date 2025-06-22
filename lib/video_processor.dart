import 'dart:async';
import 'package:flutter/services.dart';
import 'video_processor_platform_interface.dart';

class VideoProcessor {
  static const MethodChannel _methodChannel =
      MethodChannel('video_processor/method');
  static const EventChannel _eventChannel =
      EventChannel('video_processor/event');

  Future<String?> getPlatformVersion() {
    return VideoProcessorPlatform.instance.getPlatformVersion();
  }

  static Future<String?> compressAndTrim({
    required String path,
    required double startTime,
    required double endTime,
    int androidBitrate = 1000000, // Default 1 Mbps
    int? resolutionHeight,
  }) async {
    if (startTime < 0.0 || endTime <= startTime) {
      throw ArgumentError('Waktu mulai dan selesai tidak valid.');
    }

    final String? resultPath =
        await _methodChannel.invokeMethod('processVideo', {
      'path': path,
      'startTime': startTime,
      'endTime': endTime,
      'androidBitrate': androidBitrate,
      'resolutionHeight': resolutionHeight,
    });
    return resultPath;
  }

  static Future<String?> trimVideo({
    required String path,
    required double startTime,
    required double endTime,
  }) async {
    if (startTime < 0.0 || endTime <= startTime) {
      throw ArgumentError('Waktu mulai dan selesai tidak valid.');
    }

    final String? resultPath = await _methodChannel.invokeMethod('trimVideo', {
      'path': path,
      'startTime': startTime,
      'endTime': endTime,
    });
    return resultPath;
  }

  static Stream<double> getProgressStream() {
    return _eventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => event as double);
  }
}
