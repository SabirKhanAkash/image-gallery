import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery/core/services/log_service.dart';
import 'package:image_gallery/data/models/data_model/data.dart';
import 'package:image_gallery/viewmodels/app/app_state.dart';
import 'package:logger/logger.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  Future<void> permitGalleryAccess(bool galleryPermissionGranted) async {
    emit(GalleryPermissionStatus(galleryPermissionGranted));
  }

  Future<void> fetchGalleryImages() async {
    const platform = MethodChannel('com.akash.image_gallery/images');
    List<String> images = [];
    try {
      final List<dynamic> result = await platform.invokeMethod('getAllImages');
      images = result.cast<String>();
    } on PlatformException catch (e) {
      Log.create(Level.info, "Failed to load images: ${e.message}");
    }
    Log.create(Level.info, "images: $images");
    emit(FetchGalleryImageStatus(images));
  }

  Future<void> fetchGalleryAlbums() async {
    const platform = MethodChannel('com.akash.image_gallery/images');
    List<Data?> albums = [];
    var result = null;
    try {
      result = await platform.invokeMethod('getAlbums');
      for (int i = 0; i < result.length; i++) {
        for (int j = 0; j < result[i]['images'].length; j++) {
          Log.create(
              Level.info,
              "${i + 1} => ${result[i]['albumName']} (${result[i]['images'].length}) -> ${j + 1}."
              "${result[i]['images'][j]}");
        }
      }
      // albums = result;
    } on PlatformException catch (e) {
      Log.create(Level.info, "Failed to load albums: ${e.message}");
    }

    // Log.create(Level.info, "albums: ${(result)}");
    emit(FetchGalleryAlbumsStatus(result));
  }
}
