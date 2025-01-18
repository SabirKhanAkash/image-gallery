package com.akash.image_gallery

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.util.Log
import android.content.ContentResolver
import android.database.Cursor
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.akash.image_gallery/images"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getAllImages" -> {
                    val imagePaths = getAllImages()
                    Log.d("debug", "Image URIs: $imagePaths")
                    result.success(imagePaths)
                }

                "getAlbums" -> {
                    val albums = getAlbums()
                    Log.d("debug", "Albums: $albums")
                    result.success(albums)
                }

                else -> {
                    Log.d("debug", "Method not implemented")
                    result.notImplemented()
                }
            }
        }
    }

    private fun getAllImages(): List<String> {
        val images = mutableListOf<String>()
        val contentResolver: ContentResolver = contentResolver
        val projection = arrayOf(MediaStore.Images.Media._ID)
        val cursor: Cursor? = contentResolver.query(
            MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
            projection,
            null,
            null,
            "${MediaStore.Images.Media.DATE_ADDED} DESC"
        )

        cursor?.use {
            val columnIndexId = it.getColumnIndexOrThrow(MediaStore.Images.Media._ID)
            while (it.moveToNext()) {
                val id = it.getLong(columnIndexId)
                val contentUri = Uri.withAppendedPath(
                    MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
                    id.toString()
                )
                images.add(contentUri.toString())
            }
        }
        return images
    }

    private fun getAlbums(): List<Map<String, Any>> {
        val albums = mutableListOf<Map<String, Any>>()
        val contentResolver: ContentResolver = contentResolver
        val projection = arrayOf(
            MediaStore.Images.Media.BUCKET_DISPLAY_NAME,
            MediaStore.Images.Media._ID
        )
        val cursor: Cursor? = contentResolver.query(
            MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
            projection,
            null,
            null,
            "${MediaStore.Images.Media.DATE_ADDED} DESC"
        )

        cursor?.use {
            val bucketColumn = it.getColumnIndexOrThrow(MediaStore.Images.Media.BUCKET_DISPLAY_NAME)
            val idColumn = it.getColumnIndexOrThrow(MediaStore.Images.Media._ID)
            val albumMap = mutableMapOf<String, MutableList<String>>()

            while (it.moveToNext()) {
                val bucketName = it.getString(bucketColumn) ?: "Unknown"
                val id = it.getLong(idColumn)
                val contentUri = Uri.withAppendedPath(
                    MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
                    id.toString()
                )

                albumMap.computeIfAbsent(bucketName) { mutableListOf() }.add(contentUri.toString())
            }

            for ((bucketName, imageUris) in albumMap) {
                albums.add(
                    mapOf(
                        "albumName" to bucketName,
                        "images" to imageUris
                    )
                )
            }
        }
        return albums
    }
}
