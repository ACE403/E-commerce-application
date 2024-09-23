import 'package:ecomm/utils/constants/sizes.dart';
import 'package:ecomm/utils/constants/text_strings.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../common/styles/spacing_style.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: SpacingStyle.paddingWithAppbarHeight,
        child: Column(
          children: [
            //logo title subtitle
            LoginHeader(),
            LoginForm(),

            //divider
            FormDivider(
              dividertext: TTexts.orsigninwith,
            ),

            //footer
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            SocialButtons()
          ],
        ),
      )),
    );
  }
}
