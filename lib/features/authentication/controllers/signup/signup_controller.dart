import 'package:ecomm/data/repositories/user/user_repository.dart';
import 'package:ecomm/utils/helpers/network_manager.dart';
import 'package:ecomm/features/personalization/models/user_model.dart';
import 'package:ecomm/features/authentication/screens/signup/verify_email.dart';
import 'package:ecomm/utils/constants/image_strings.dart';
import 'package:ecomm/utils/popups/full_screen_loader.dart';
import 'package:ecomm/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  //Variables
  final hidePassword = true.obs;
  final privacypolicy = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  //Signup
  void signup() async {
    try {
      //Start  Loading
      FullScreenLoader.openloadingDialog(
          'We are processing your information...', TImages.loading);
      //Check Interenet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      //Form Validation
      if (!signupFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }
      //Privacy policy check
      if (!privacypolicy.value) {
        FullScreenLoader.stopLoading();

        Loaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account, you must have to read and accept privacy policy');
        return;
      }
      //Register user
      final UserCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());
      //Save Authenticated user data
      final newUser = UserModel(
          id: UserCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: userName.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      FullScreenLoader.stopLoading();
      //Show success message
      Loaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! verify email to continue');

      Get.to(() => VerifyEmail(
            email: email.text.trim(),
          ));
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'oh snap!', message: e.toString());
    }
  }
}
