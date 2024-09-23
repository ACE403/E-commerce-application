import 'package:ecomm/features/authentication/screens/login/login.dart';
import 'package:ecomm/features/authentication/screens/onboarding/onboarding.dart';
import 'package:ecomm/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:ecomm/features/authentication/screens/signup/signup.dart';
import 'package:ecomm/features/authentication/screens/signup/verify_email.dart';
import 'package:ecomm/features/personalization/screens/address/address.dart';
import 'package:ecomm/features/personalization/screens/profile/profile.dart';
import 'package:ecomm/features/personalization/screens/settings/settings.dart';
import 'package:ecomm/features/shop/screens/cart/cart.dart';
import 'package:ecomm/features/shop/screens/checkout/checkout.dart';
import 'package:ecomm/features/shop/screens/home/home.dart';
import 'package:ecomm/features/shop/screens/order/order.dart';
import 'package:ecomm/features/shop/screens/product_reviews/product_review.dart';
import 'package:ecomm/features/shop/screens/store/store.dart';
import 'package:ecomm/features/shop/screens/wishlist/wishlist.dart';
import 'package:get/get.dart';

import 'routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomePage()),
    GetPage(name: TRoutes.store, page: () => const Store()),
    GetPage(name: TRoutes.favourites, page: () => const FavouriteScreen()),
    GetPage(name: TRoutes.settings, page: () => const Settings()),
    GetPage(name: TRoutes.productReviews, page: () => const ProductReview()),
    GetPage(name: TRoutes.order, page: () => const Order()),
    GetPage(name: TRoutes.checkout, page: () => const Checkout()),
    GetPage(name: TRoutes.cart, page: () => const Cart()),
    GetPage(name: TRoutes.userProfile, page: () => const Profile()),
    GetPage(name: TRoutes.userAddress, page: () => const Address()),
    GetPage(name: TRoutes.signup, page: () => const Signup()),
    GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmail()),
    GetPage(name: TRoutes.signin, page: () => const LoginPage()),
    GetPage(name: TRoutes.forgetPassword, page: () => const ForgetPassword()),
    GetPage(name: TRoutes.onBoarding, page: () => const OnboardingScreen()),
    // Add more GetPage entries as needed
  ];
}
