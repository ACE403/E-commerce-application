import 'package:ecomm/common/widgets/text/section_heading.dart';
import 'package:ecomm/features/personalization/controllers/address_controller.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    print(addressController.city.text);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () {
            addressController.selectNewAddressPopup(context);
          },
        ),
        Obx(() {
          // Check if a valid address is selected
          if (addressController.selectedAddress.value.id.isNotEmpty) {
            final selectedAddress = addressController.selectedAddress.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedAddress.name, // Use the text property here
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    Text(
                        selectedAddress
                            .phoneNumber, // Use the text property here
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_history,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    Expanded(
                      child: Text(
                        // Display selected address details properly
                        '${selectedAddress.street}, ${selectedAddress.city}, ${selectedAddress.state}, ${selectedAddress.country}, ${selectedAddress.postalCode}',
                        style: Theme.of(context).textTheme.bodyMedium,
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Text(
              'Select Address',
              style: Theme.of(context).textTheme.bodyMedium,
            );
          }
        }),
      ],
    );
  }
}
