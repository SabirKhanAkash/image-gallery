import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery/viewmodels/app/app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  void permitGalleryAccess(bool galleryPermissionGranted) {
    emit(GalleryPermissionStatus(galleryPermissionGranted));
  }
}
