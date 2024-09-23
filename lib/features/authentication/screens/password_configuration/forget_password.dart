import 'package:ecomm/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:ecomm/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:ecomm/utils/constants/text_strings.dart';
import 'package:ecomm/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //heading
            Text(TTexts.ForgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: TSizes.spaceBtwItems),
            Text(TTexts.ForgetPasswordSubtitle,
                style: Theme.of(context).textTheme.labelMedium),
            SizedBox(
              height: TSizes.spaceBtwSections * 2,
            ),
            //textfield
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: Validator.validateEmail,
                decoration: InputDecoration(
                  labelText: TTexts.Email,
                  prefixIcon: Icon(Iconsax.direct_right),
                ),
              ),
            ),

            //submit
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.sendPasswordResetEmail(),
                  child: Text(TTexts.Submit)),
            )
          ],
        ),
      ),
    );
  }
}
