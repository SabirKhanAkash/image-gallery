import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_gallery/ui/shared/components/custom_elevated_button_one.dart';
import 'package:image_gallery/utils/config/app_color.dart';
import 'package:image_gallery/utils/config/app_image.dart';
import 'package:image_gallery/utils/config/app_style.dart';
import 'package:image_gallery/utils/config/app_text.dart';
import 'package:image_gallery/utils/helpers/permission_helper.dart';
import 'package:permission_handler/permission_handler.dart';

Widget buildPermissionBody() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppImage().permissionIcon),
          const SizedBox(height: 30),
          Text(
            AppText().permissionHeading,
            style: TextStyle(
              color: AppColor().black,
              fontSize: AppStyle().lessLargeDp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            AppText().permissionNote,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor().black,
              fontSize: AppStyle().regularDp,
            ),
          ),
          const SizedBox(height: 20),
          CustomElevatedButtonOne(
            buttonLabel: AppText().permissionButton,
            backgroundColor: AppColor().lightGreen,
            foregroundColor: AppColor().solidBlack,
            buttonClickAction: () => PermissionHelper.handlePermission(Permission.photos),
          )
        ],
      ),
    ),
  );
}
