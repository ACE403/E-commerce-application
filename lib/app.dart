import 'package:ecomm/bindings/general_bindings.dart';
import 'package:ecomm/utils/constants/colors.dart';
import 'package:ecomm/utils/helpers/helper_functions.dart';
import 'package:ecomm/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'utils/theme/theme.dart';
import 'package:ecomm/features/authentication/screens/onboarding/onboarding.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TappTheme.lightTheme,
      darkTheme: TappTheme.darktheme,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      home: Scaffold(
        backgroundColor: dark ? TColors.black : TColors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: dark ? TColors.white : TColors.black,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
