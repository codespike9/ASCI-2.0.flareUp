import 'package:flutter/material.dart';
import 'package:flutter_flareup/Investors/screen/in_buisness_details.dart';

import 'package:flutter_flareup/Investors/screen/login_screen.dart';
import 'package:flutter_flareup/Investors/screen/signup_screen.dart';
import 'package:flutter_flareup/Investors/screen/tabscreen.dart';
import 'package:flutter_flareup/Investors/models/in_buisness_model.dart';
import 'package:flutter_flareup/start-Up/screens/buisness_form.dart';
import 'package:flutter_flareup/start-Up/screens/buisness_screen.dart';
import 'package:flutter_flareup/start-Up/screens/buisness_sign_in.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );

    case SignUpScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUpScreen(),
      );

    case InvestorTabScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const InvestorTabScreen(),
      );

    case BusinessDetailsScreen.routeName:
      final businessData = routeSettings.arguments as BusinessModel;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => BusinessDetailsScreen(businessData));

    case BuisnessSigninScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BuisnessSigninScreen(),
      );

    case BuisnessScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BuisnessScreen(),
      );

    case BuisnessFormScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BuisnessFormScreen(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
