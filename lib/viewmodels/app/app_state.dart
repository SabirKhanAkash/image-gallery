import 'package:image_gallery/data/models/data_model/data.dart';

abstract class AppState {}

class AppInitial extends AppState {}

class GalleryPermissionStatus extends AppState {
  final bool galleryPermissionGranted;

  GalleryPermissionStatus(this.galleryPermissionGranted);
}

class FetchGalleryImageStatus extends AppState {
  final List<String> imagePath;

  FetchGalleryImageStatus(this.imagePath);
}

class FetchGalleryAlbumsStatus extends AppState {
  final List<dynamic?> albums;

  FetchGalleryAlbumsStatus(this.albums);
}
