import 'package:ecomm/data/repositories/user/user_repository.dart';
import 'package:ecomm/features/personalization/controllers/user_controller.dart';
import 'package:ecomm/features/personalization/screens/profile/profile.dart';
import 'package:ecomm/utils/constants/image_strings.dart';
import 'package:ecomm/utils/popups/full_screen_loader.dart';
import 'package:ecomm/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/network_manager.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  GlobalKey<FormState> updateNameFormKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final userRepository = Get.put(UserRepository());
  final lastName = TextEditingController();
  final userController = UserController.instance;

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateName() async {
    try {
      FullScreenLoader.openloadingDialog(
          "We are waiting for your information", TImages.loading);

      //Check Interenet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!updateNameFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }
//update in firestore
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };
      await userRepository.updateSingleField(name);
      //update Rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      FullScreenLoader.stopLoading();

      Loaders.successSnackBar(
          title: 'Congratulations', message: 'Your name has been updated');
      Get.off(() => Profile());
    } catch (e) {
      FullScreenLoader.stopLoading();

      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
