import 'package:ecomm/common/widgets/appbar/custom_appbar.dart';
import 'package:ecomm/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecomm/features/personalization/controllers/address_controller.dart';
import 'package:ecomm/features/personalization/screens/address/add_new_address.dart';
import 'package:ecomm/utils/constants/colors.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:ecomm/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'widgets/single_address.dart';

class Address extends StatelessWidget {
  const Address({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddress()),
        child: const Icon(
          Iconsax.add,
          color: TColors.white,
        ),
        backgroundColor: TColors.primary,
      ),
      appBar: CustomAppbar(
        showBackArrow: true,
        title: Text(
          "Address",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Obx(
              () => FutureBuilder(
                  key: Key(controller.refreshData.value.toString()),
                  future: controller.getallUserAddresses(),
                  builder: (context, snapshot) {
                    final response = CloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot);
                    if (response != null) return response;
                    final addresses = snapshot.data!;
                    print(' address: $addresses');
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: addresses.length,
                        itemBuilder: (_, index) => SingleAddress(
                              address: addresses[index],
                              onTap: () =>
                                  controller.selectAddress(addresses[index]),
                            ));
                  }),
            )),
      ),
    );
  }
}
