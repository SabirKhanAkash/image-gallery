import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery/ui/album/widgets/build_album_body.dart';
import 'package:image_gallery/ui/album/widgets/build_permission_body.dart';
import 'package:image_gallery/utils/helpers/permission_helper.dart';
import 'package:image_gallery/viewmodels/app/app_cubit.dart';
import 'package:image_gallery/viewmodels/app/app_state.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await PermissionHelper.handlePermission(Permission.manageExternalStorage);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          final cubit = context.read<AppCubit>();
          return (state is FetchGalleryAlbumsStatus)
              ? state.albums.isNotEmpty
                  ? buildAlbumBody(cubit, context, state)
                  : buildPermissionBody(cubit, context, state)
              : buildPermissionBody(cubit, context, state);
        },
        listener: (context, state) {
          // if (state is FetchGalleryAlbumsStatus) {
          //   if (state.albums.isNotEmpty) {
          //     Log.create(Level.info, "Album count: ${state.albums.length}");
          //
          //     for (var album in state.albums) {
          //       Map<String, dynamic> albumMap = Map<String, dynamic>.from(album);
          //
          //       var albumName = albumMap['albumName'];
          //       var images = albumMap['images'] as List<dynamic>;
          //
          //       Log.create(Level.info, "Album name: $albumName");
          //
          //       for (var image in images) {
          //         Log.create(Level.info, "Image URL: $image");
          //       }
          //     }
          //   } else {
          //     Log.create(Level.info, "No albums found");
          //   }
          // }
          // else if (state is GalleryPermissionStatus) {
          //   Log.create(Level.info,
          //       state.galleryPermissionGranted ? "Permission granted" : "Permission not granted");
          // }
        },
      ),
    );
  }
}
