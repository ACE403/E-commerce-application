import 'package:ecomm/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: TSizes.defaultSpace,
      top: TDeviceUtils.getAppBarHeight(),
      // top: 5,
      child: TextButton(
        onPressed: () => OnboardingController.instance.skipPage(),
        child: const Text(
          "Skip",
        ),
      ),
    );
  }
}
