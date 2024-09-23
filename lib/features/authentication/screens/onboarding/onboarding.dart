import 'package:ecomm/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:ecomm/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:ecomm/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:ecomm/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';

import 'package:ecomm/utils/constants/image_strings.dart';

import 'package:ecomm/utils/constants/text_strings.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/onboarding_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
        body: Stack(
      children: [
        //horizontal scrollable pages
        PageView(
          controller: controller.pageController,
          onPageChanged: controller.updatePageIndicator,
          children: const [
            OnboardingPage(
              image: TImages.onboarding1,
              title: TTexts.onBoardingTitle1,
              subtitle: TTexts.onBoardingSubTitle1,
            ),
            OnboardingPage(
              image: TImages.onboarding2,
              title: TTexts.onBoardingTitle2,
              subtitle: TTexts.onBoardingSubTitle2,
            ),
            OnboardingPage(
              image: TImages.onboarding3,
              title: TTexts.onBoardingTitle3,
              subtitle: TTexts.onBoardingSubTitle3,
            )
          ],
        ),
        //skip button
        OnboardingSkip(),
        //dot navigation smooth indicator
        OnboardingNavigation(),
        //circular next button
        OnboardingButton()
      ],
    ));
  }
}
