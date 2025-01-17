abstract class AppState {}

class AppInitial extends AppState {}

class GalleryPermissionStatus extends AppState {
  final bool galleryPermissionGranted;

  GalleryPermissionStatus(this.galleryPermissionGranted);
}
