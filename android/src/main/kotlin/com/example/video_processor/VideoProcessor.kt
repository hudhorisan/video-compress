package com.example.video_processor

import android.content.Context
import androidx.media3.common.MediaItem
import androidx.media3.common.MimeTypes
import androidx.media3.transformer.Composition
import androidx.media3.transformer.ExportResult
import androidx.media3.transformer.TransformationRequest
import androidx.media3.transformer.Transformer
import java.io.File

/**
 * Kelas ini berisi logika untuk memproses video menggunakan Media3 Transformer.
 * Memisahkan logika ini membuat kode plugin utama lebih bersih.
 */
class VideoProcessor {

    private var transformer: Transformer? = null

    fun processVideo(
        context: Context,
        sourcePath: String,
        destPath: String,
        startTimeMs: Long,
        endTimeMs: Long,
        bitrate: Long,
        targetHeight: Int?,
        progressCallback: (Int) -> Unit,
        completionCallback: (Result<String>) -> Unit
    ) {
        val mediaItem = MediaItem.Builder()
            .setUri(sourcePath)
            .setClippingConfiguration(
                MediaItem.ClippingConfiguration.Builder()
                    .setStartPositionMs(startTimeMs)
                    .setEndPositionMs(endTimeMs)
                    .build()
            )
            .build()
        
        val transformationRequestBuilder = TransformationRequest.Builder()
            .setVideoMimeType(MimeTypes.VIDEO_H264)
            
        if (targetHeight != null && targetHeight > 0) {
            transformationRequestBuilder.setResolution(targetHeight)
        }

        val transformer = Transformer.Builder(context)
            .setTransformationRequest(transformationRequestBuilder.build())
            .addListener(object : Transformer.Listener {
                override fun onTransformationCompleted(composition: Composition, exportResult: ExportResult) = completionCallback(Result.success(destPath))
                override fun onTransformationError(composition: Composition, exportResult: ExportResult, exception: Exception) = completionCallback(Result.failure(exception))
                override fun onProgress(progress: Int) = progressCallback(progress)
            })
            .build()

        File(destPath).delete()
        this.transformer = transformer
        transformer.start(mediaItem, destPath)
    }

    fun trimVideoOnly(
        context: Context,
        sourcePath: String,
        destPath: String,
        startTimeMs: Long,
        endTimeMs: Long,
        progressCallback: (Int) -> Unit,
        completionCallback: (Result<String>) -> Unit
    ) {
        val mediaItem = MediaItem.Builder()
            .setUri(sourcePath)
            .setClippingConfiguration(
                MediaItem.ClippingConfiguration.Builder()
                    .setStartPositionMs(startTimeMs)
                    .setEndPositionMs(endTimeMs)
                    .build()
            )
            .build()
        
        val transformationRequest = TransformationRequest.Builder().build()
            
        val transformer = Transformer.Builder(context)
            .setTransformationRequest(transformationRequest)
            .addListener(object : Transformer.Listener {
                override fun onTransformationCompleted(composition: Composition, exportResult: ExportResult) = completionCallback(Result.success(destPath))
                override fun onTransformationError(composition: Composition, exportResult: ExportResult, exception: Exception) = completionCallback(Result.failure(exception))
                override fun onProgress(progress: Int) = progressCallback(progress)
            })
            .build()

        File(destPath).delete()
        this.transformer = transformer
        transformer.start(mediaItem, destPath)
    }

    
    fun cancel() {
        transformer?.cancel()
    }
}