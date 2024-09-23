import 'dart:async';

import 'package:ecomm/common/widgets/success_screen/success_screen.dart';
import 'package:ecomm/utils/constants/image_strings.dart';
import 'package:ecomm/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

//send email and set timer

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }
  //Send Email verification link

  // Timer to automatically redirect on Email verifcation
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      Loaders.successSnackBar(
          title: 'Email sent!',
          message: "please check your inbox and verify email");
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();

      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();

        Get.off(() => SuccessScreen(
            image: TImages.success,
            title: "Email Sent",
            subtitle: "Please check your inbox and verify your mail",
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect()));
      }
    });
  }

  //Manually Check  if Email Verification
  checkEmailVerificationStatus() {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
          image: TImages.success,
          title: "Email Sent",
          subtitle: "Please check your inbox and verify your mail",
          onPressed: () => AuthenticationRepository.instance.screenRedirect()));
    }
  }
}
