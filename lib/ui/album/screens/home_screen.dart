import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery/ui/album/widgets/build_album_body.dart';
import 'package:image_gallery/ui/album/widgets/build_permission_body.dart';
import 'package:image_gallery/viewmodels/app/app_cubit.dart';
import 'package:image_gallery/viewmodels/app/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          return state is GalleryPermissionStatus
              ? state.galleryPermissionGranted
                  ? buildPermissionBody()
                  : buildAlbumBody()
              : buildAlbumBody();
        },
        listener: (context, state) => {},
      ),
    );
  }
}
