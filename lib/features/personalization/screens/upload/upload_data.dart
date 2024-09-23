import 'package:ecomm/features/personalization/controllers/upload_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/custom_appbar.dart';
import '../../../../data/repositories/category/category_repository.dart';
import '../../../../dummy_data.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../settings/settings_menu_tile.dart';

class UploadData extends StatelessWidget {
  const UploadData({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadDataController());

    return Scaffold(
      appBar: CustomAppbar(
        title: Text(
          "Upload data",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: TColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: TSizes.defaultSpace, vertical: TSizes.lg),
          child: Column(
            children: [
              SettingsMenuTile(
                icon: Iconsax.safe_home,
                title: "Upload banner",
                subtitle: "",
                onTap: () => controller.uploadBanners(),
              ),
              SettingsMenuTile(
                icon: Iconsax.safe_home,
                title: "Upload categories",
                subtitle: "",
                onTap: () => controller.uploadCategories(),
              ),
              SettingsMenuTile(
                icon: Iconsax.safe_home,
                title: "Upload products",
                subtitle: "",
                onTap: () => controller.uploadProducts(),
              ),
              SettingsMenuTile(
                icon: Iconsax.safe_home,
                title: "Upload brands",
                subtitle: "",
                onTap: () => controller.uploadBrands(),
              ),
              SettingsMenuTile(
                icon: Iconsax.safe_home,
                title: "Upload Brand Category Relation",
                subtitle: "",
                onTap: () => controller.uploadBrandCategory(),
              ),
              SettingsMenuTile(
                icon: Iconsax.safe_home,
                title: "Upload Product Category Relation",
                subtitle: "",
                onTap: () => controller.uploadProductCategory(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
