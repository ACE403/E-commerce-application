import 'package:ecomm/common/widgets/appbar/custom_appbar.dart';
import 'package:ecomm/features/personalization/controllers/update_name_controller.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:ecomm/utils/constants/text_strings.dart';
import 'package:ecomm/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
        appBar: CustomAppbar(
          showBackArrow: true,
          title: Text(
            'Change Name',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Text(
                'Use real name for easy verification',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Form(
                  key: controller.updateNameFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.firstName,
                        validator: (value) =>
                            Validator.validateEmptyText('First name', value),
                        expands: false,
                        decoration: InputDecoration(
                            labelText: TTexts.firstname,
                            prefixIcon: Icon(Iconsax.user)),
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      TextFormField(
                        controller: controller.lastName,
                        validator: (value) =>
                            Validator.validateEmptyText('Last name', value),
                        expands: false,
                        decoration: InputDecoration(
                            labelText: TTexts.lastname,
                            prefixIcon: Icon(Iconsax.user)),
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () => controller.updateName(),
                            child: Text('Save')),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
