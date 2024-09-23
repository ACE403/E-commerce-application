// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:io';

import 'package:ecomm/data/repositories/user/user_repository.dart';
import 'package:ecomm/features/authentication/screens/signup/verify_email.dart';
import 'package:ecomm/navigation_menu.dart';
import 'package:ecomm/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../../../features/authentication/screens/login/login.dart';
import '../../../features/authentication/screens/onboarding/onboarding.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variable

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

//Getter

  User? get authUser => _auth.currentUser!;
  // Called from main.dart
  @override
  void onReady() {
    // FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        await LocalStorage.init(user.uid);
        Get.offAll(() => NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmail(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      deviceStorage.writeIfNull('isfirsttime', true);
      deviceStorage.read('isfirsttime') != true
          ? Get.offAll(() => LoginPage())
          : Get.offAll(() => OnboardingScreen());
    }
  }

  //Email authentication -signin
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An error occurred during registration';
    } on FirebaseException catch (e) {
      throw e.message ?? 'A Firebase error occurred';
    } on FormatException {
      throw 'Invalid format detected';
    } on PlatformException catch (e) {
      throw e.message ?? 'A platform error occurred';
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  //Email authentication - Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An error occurred during registration';
    } on FirebaseException catch (e) {
      throw e.message ?? 'A Firebase error occurred';
    } on FormatException {
      throw 'Invalid format detected';
    } on PlatformException catch (e) {
      throw e.message ?? 'A platform error occurred';
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  //verify email
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An error occurred during registration';
    } on FirebaseException catch (e) {
      throw e.message ?? 'A Firebase error occurred';
    } on FormatException {
      throw 'Invalid format detected';
    } on PlatformException catch (e) {
      throw e.message ?? 'A platform error occurred';
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  //Email verification
  //Reauthenticate
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An error occurred during registration';
    } on FirebaseException catch (e) {
      throw e.message ?? 'A Firebase error occurred';
    } on FormatException {
      throw 'Invalid format detected';
    } on PlatformException catch (e) {
      throw e.message ?? 'A platform error occurred';
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  //Email authentication - forget password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An error occurred during registration';
    } on FirebaseException catch (e) {
      throw e.message ?? 'A Firebase error occurred';
    } on FormatException {
      throw 'Invalid format detected';
    } on PlatformException catch (e) {
      throw e.message ?? 'A platform error occurred';
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  //Google Auth
  Future<UserCredential?> signInGoogle() async {
    try {
      //trigger authentication
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
//Obtain auth details
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;
//Create a new credential
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
//Once signin, return user credential
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An error occurred during registration';
    } on FirebaseException catch (e) {
      throw e.message ?? 'A Firebase error occurred';
    } on FormatException {
      throw 'Invalid format detected';
    } on PlatformException catch (e) {
      throw e.message ?? 'A platform error occurred';
    } catch (e) {
      if (kDebugMode) print('Something went wrong : $e');
      return null;
    }
  }
  //Facebook Auth

  //Logout user
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginPage());
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An error occurred during registration';
    } on FirebaseException catch (e) {
      throw e.message ?? 'A Firebase error occurred';
    } on FormatException {
      throw 'Invalid format detected';
    } on PlatformException catch (e) {
      throw e.message ?? 'A platform error occurred';
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  //Delete User
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An error occurred during registration';
    } on FirebaseException catch (e) {
      throw e.message ?? 'A Firebase error occurred';
    } on FormatException {
      throw 'Invalid format detected';
    } on PlatformException catch (e) {
      throw e.message ?? 'A platform error occurred';
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }
}
