import 'package:ecomm/common/widgets/appbar/custom_appbar.dart';
import 'package:ecomm/common/widgets/image/circular_image.dart';
import 'package:ecomm/common/widgets/shimmer/shimmer_effect.dart';
import 'package:ecomm/common/widgets/text/section_heading.dart';
import 'package:ecomm/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:ecomm/utils/constants/image_strings.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../controllers/user_controller.dart';
import 'widgets/profile_menu.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const CustomAppbar(
        title: Text("Profile"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Profile
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : TImages.profile;

                      return controller.imageUploading.value
                          ? ShimmerEffect(
                              width: 80,
                              height: 80,
                              radius: 80,
                            )
                          : CircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty,
                            );
                    }),
                    TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: const Text('Change Profile Picture'),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    const Divider(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    const SectionHeading(
                      title: 'Profile Information',
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    ProfileMenu(
                        title: 'Name',
                        onTap: () => Get.to(() => ChangeName()),
                        value: controller.user.value.fullName),
                    ProfileMenu(
                        title: 'Username',
                        onTap: () {},
                        value: controller.user.value.username),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    const Divider(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    const SectionHeading(
                      title: 'Personal Information',
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    ProfileMenu(
                        title: 'User ID',
                        icon: Iconsax.copy,
                        onTap: () {},
                        value: controller.user.value.id),
                    ProfileMenu(
                        title: 'E-mail',
                        onTap: () {},
                        value: controller.user.value.email),
                    ProfileMenu(
                        title: 'Phone number',
                        onTap: () {},
                        value: controller.user.value.phoneNumber),
                    ProfileMenu(
                      title: 'Gender',
                      onTap: () {},
                      value: 'Male',
                    ),
                    ProfileMenu(
                      title: 'Date of Birth',
                      onTap: () {},
                      value: '30th July 2002',
                    ),
                    const Divider(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () => controller.deleteAccountWarningPopup(),
                        child: const Text(
                          'Close Account',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
