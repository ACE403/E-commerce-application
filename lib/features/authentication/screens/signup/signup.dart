import 'package:ecomm/common/widgets/login_signup/form_divider.dart';
import 'package:ecomm/common/widgets/login_signup/social_buttons.dart';
import 'package:ecomm/utils/constants/colors.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:ecomm/utils/constants/text_strings.dart';
import 'package:ecomm/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:iconsax/iconsax.dart';

import 'widgets/sign_up_form.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Text(
                TTexts.SignupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              //Form
              SignUpForm(),
              //divider
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const FormDivider(dividertext: TTexts.orsigninwith),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              SocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
