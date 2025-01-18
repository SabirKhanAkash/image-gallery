import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_gallery/utils/config/app_color.dart';
import 'package:image_gallery/utils/config/app_image.dart';
import 'package:image_gallery/utils/config/app_style.dart';
import 'package:image_gallery/utils/config/app_text.dart';
import 'package:image_gallery/viewmodels/app/app_cubit.dart';
import 'package:image_gallery/viewmodels/app/app_state.dart';

Widget buildAlbumBody(AppCubit cubit, BuildContext context, FetchGalleryAlbumsStatus state) {
  return SafeArea(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              textAlign: TextAlign.start,
              AppText().albumHeading,
              style: TextStyle(
                fontSize: AppStyle().veryLargeDp,
                color: AppColor().grayBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemCount: state.albums.length,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            itemBuilder: (context, index) {
              var album = state.albums[index];

              if (album == null) {
                return Container();
              }

              var albumName = album['albumName'];
              var images = album['images'];

              if (images.isEmpty) {
                return Container();
              }

              String contentUri = images[0];

              return FutureBuilder<File?>(
                future: resolveContentUriToFile(contentUri),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || snapshot.data == null) {
                    return _buildImageError(albumName, images.length);
                  }

                  File imageFile = snapshot.data!;
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColor().lightGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Image.file(
                          imageFile,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.image_not_supported,
                              color: Colors.white,
                              size: 45,
                            );
                          },
                        ),
                        SvgPicture.asset(
                          AppImage().grayTransparentCover,
                          height: 350,
                          width: 350,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          verticalDirection: VerticalDirection.up,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, bottom: 10),
                              child: Text(
                                "${images.length} Photos",
                                style: TextStyle(
                                  color: AppColor().veryGrayBlack,
                                  fontSize: AppStyle().smallDp,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                albumName,
                                style: TextStyle(
                                  color: AppColor().white,
                                  fontSize: AppStyle().lessLargeDp,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}

Future<File?> resolveContentUriToFile(String contentUri) async {
  try {
    File file = File(contentUri);
    if (await file.exists()) {
      return file;
    }
  } catch (e) {
    debugPrint("Error resolving URI to file: $e");
  }
  return null;
}

Widget _buildImageError(String albumName, int imageCount) {
  return Container(
    decoration: BoxDecoration(
      color: AppColor().lightGreen,
      borderRadius: BorderRadius.circular(10),
    ),
    alignment: Alignment.center,
    child: Stack(
      children: [
        const Center(
          child: Icon(
            Icons.image_not_supported,
            color: Colors.white,
            size: 45,
          ),
        ),
        SvgPicture.asset(
          AppImage().grayTransparentCover,
          height: 350,
          width: 350,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.up,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "$imageCount Photos",
                style: TextStyle(
                  color: AppColor().veryGrayBlack,
                  fontSize: AppStyle().smallDp,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                albumName,
                style: TextStyle(
                  color: AppColor().white,
                  fontSize: AppStyle().lessLargeDp,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
