import 'package:ecomm/common/widgets/appbar/custom_appbar.dart';
import 'package:ecomm/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecomm/common/widgets/text/section_heading.dart';
import 'package:ecomm/features/personalization/screens/settings/settings_menu_tile.dart';
import 'package:ecomm/features/personalization/screens/upload/upload_data.dart';
import 'package:ecomm/features/shop/screens/order/order.dart';
import 'package:ecomm/utils/constants/colors.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../address/address.dart';
import '../profile/profile.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          //Header
          PrimaryHeaderContainer(
              child: Column(
            children: [
              CustomAppbar(
                title: Text(
                  "Account",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: TColors.white),
                ),
              ),

              //USer profile card
              UserProfileTile(onPressed: () => Get.to(() => const Profile())),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
            ],
          )),

          //body

          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace, vertical: TSizes.sm),
            child: Column(
              children: [
                //account settings
                SectionHeading(
                  title: "Account Settings",
                  showActionButton: false,
                ),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                SettingsMenuTile(
                  icon: Iconsax.safe_home,
                  title: "My Addresses",
                  subtitle: "Set shopping delivery address",
                  onTap: () => Get.to(() => Address()),
                ),
                SettingsMenuTile(
                  icon: Iconsax.shopping_cart,
                  title: "My Cart",
                  subtitle: "Add, remove products and move to checkout",
                  onTap: () {},
                ),
                SettingsMenuTile(
                  icon: Iconsax.bag_tick,
                  title: "My Orders",
                  subtitle: "In-progress and Completed Orders",
                  onTap: () => Get.to(() => Order()),
                ),
                SettingsMenuTile(
                  icon: Iconsax.bank,
                  title: "Bank Account",
                  subtitle: "Withdraw balance to registered bank account",
                  onTap: () {},
                ),
                SettingsMenuTile(
                  icon: Iconsax.discount_shape,
                  title: "My Coupons",
                  subtitle: "List of all discounted coupons",
                  onTap: () {},
                ),
                SettingsMenuTile(
                  icon: Iconsax.notification,
                  title: "Notifications",
                  subtitle: "Set any kind of notification message",
                  onTap: () {},
                ),
                SettingsMenuTile(
                  icon: Iconsax.security,
                  title: "Account Privacy",
                  subtitle: "Manage data usage and connected accounts",
                  onTap: () {},
                ),

                //App settings
                SizedBox(height: TSizes.spaceBtwSections),
                SectionHeading(
                  title: "App Settings",
                  showActionButton: false,
                ),
                SizedBox(height: TSizes.spaceBtwItems),
                SettingsMenuTile(
                  icon: Iconsax.document_upload,
                  title: "Load Data",
                  subtitle: "Upload Data to your cloud Firebase",
                  onTap: () => Get.to(() => UploadData()),
                ),
                SettingsMenuTile(
                  icon: Iconsax.location,
                  title: "Geolocation",
                  subtitle: "Set reccomendation based on location",
                  trailing: Switch(value: true, onChanged: (value) {}),
                ),

                SettingsMenuTile(
                  icon: Iconsax.security_user,
                  title: "Safe Mode",
                  subtitle: "Search result is same for all ages",
                  trailing: Switch(value: true, onChanged: (value) {}),
                ),
                SettingsMenuTile(
                  icon: Iconsax.image,
                  title: "HD image quality",
                  subtitle: "Set image quality to be seen",
                  trailing: Switch(value: true, onChanged: (value) {}),
                ),
                SizedBox(height: TSizes.spaceBtwSections),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () =>
                            AuthenticationRepository.instance.logout(),
                        child: Text('Logout')),
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwItems),
              ],
            ),
          )
        ],
      )),
    );
  }
}
