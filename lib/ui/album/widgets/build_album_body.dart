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
            itemCount: state.albums?.length ?? 0,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            itemBuilder: (context, index) {
              var album = state.albums?[index];

              if (album == null) {
                return Container();
              }

              var albumName = album.albumName.toString();
              var images = album.images.toString();

              if (images.isEmpty) {
                return Container();
              }

              return Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    index == 0
                        ? Image.file(
                            // File(album.images?[0] ?? ""),
                            File("content://media/external/images/media/1000123237"),
                            fit: BoxFit.cover,
                          )
                        : index == 1
                            ? Image.asset(
                                AppImage().recentAlbumThumbnail,
                                scale: 0.5,
                              )
                            : index == 2
                                ? Image.asset(
                                    AppImage().gameAlbumThumbnail,
                                    scale: 0.5,
                                  )
                                : index == 3
                                    ? Image.asset(
                                        AppImage().buildingAlbumThumbnail,
                                        scale: 0.5,
                                      )
                                    : Image.asset(
                                        AppImage().peopleAlbumThumbnail,
                                        scale: 0.5,
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
                            index == 0
                                ? albumName
                                : index == 1
                                    ? "${album.images?.length}"
                                    : index == 2
                                        ? AppText().gameAlbumSubHeading
                                        : index == 3
                                            ? AppText().buildingAlbumSubHeading
                                            : index == 4
                                                ? AppText().peopleAlbumSubHeading
                                                : AppText().allAlbumSubHeading,
                            style: TextStyle(
                              color: AppColor().veryGrayBlack,
                              fontSize: AppStyle().smallDp,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            index == 0
                                ? albumName
                                : index == 1
                                    ? AppText().recentAlbumHeading
                                    : index == 2
                                        ? AppText().gameAlbumHeading
                                        : index == 3
                                            ? AppText().buildingAlbumHeading
                                            : index == 4
                                                ? AppText().peopleAlbumHeading
                                                : AppText().allAlbumHeading,
                            style: TextStyle(
                              color: AppColor().white,
                              fontSize: AppStyle().lessLargeDp,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
