// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:bpp/features/home/presentation/home_page.dart';
import 'package:bpp/features/home/presentation/on_boarding_page.dart';
import 'package:bpp/features/home/presentation/splash_page.dart';
import 'package:bpp/features/home/presentation/help_support_page.dart';
import 'package:bpp/features/home/presentation/privacy_policy_page.dart';
import 'package:bpp/features/home/presentation/terms_of_service_page.dart';
import 'package:bpp/features/authentication/presentation/pages/login_page.dart';

import 'package:bpp/features/home/presentation/setting_page.dart';
import 'package:bpp/features/home/presentation/dashboard_page.dart';

/*
import 'package:flutter_ecom_api/features/authentication/presentation/pages/signup_page.dart';
import 'package:flutter_ecom_api/features/cart/presentation/pages/cart_page.dart';
import 'package:flutter_ecom_api/features/order/presentation/pages/order_page.dart';
import 'package:flutter_ecom_api/features/product/presentation/pages/product_page.dart';
*/
class AppRoutes {
  static const SPLASHPAGE = "/";
  static const HOMEPAGE = "/home";
  static const LOGINPAGE = "/login";
  static const SIGNUPPAGE = "/register";
  static const DASHBOARDPAGE = "/dashboard";
  static const CARTPAGE = "/cart";
  static const ORDERPAGE = "/orders";
  static const PRODUCTPAGE = "/products";
  static const SETTINGPAGE = "/settings";
  static const HELPPAGE = "/help";
  static const PRIVACYPAGE = "/privacy";
  static const TERMSPAGE = "/terms";
  static const ONBOARDINGPAGE = "/on-boarding";

  static Map<String, Widget Function(BuildContext)> pageRoutes() => {
    SPLASHPAGE: (_) => SplashPage(),
    LOGINPAGE: (_) => LoginPage(),
    // SIGNUPPAGE: (_) => SignupPage(),
    DASHBOARDPAGE: (_) => Dashboard(),
    HOMEPAGE: (_) => HomePage(),
    // CARTPAGE: (_) => CartPage(),
    // ORDERPAGE: (_) => OrderPage(),
    // PRODUCTPAGE: (_) => ProductPage(),
    SETTINGPAGE: (_) => SettingPage(),
    HELPPAGE: (_) => HelpSupportPage(),
    PRIVACYPAGE: (_) => PrivacyPolicyPage(),
    TERMSPAGE: (_) => TermsOfServicePage(),
    ONBOARDINGPAGE: (_) => OnBoardingPage(),
  };
}
