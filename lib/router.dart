import 'package:flutter/material.dart';
import 'package:whatsapp/features/auth/screens/login_screen.dart';
import 'package:whatsapp/features/auth/screens/otp_screen.dart';
import 'package:whatsapp/features/auth/screens/user_information_screen.dart';
import 'package:whatsapp/screens/mobile_screen_layout.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: ((context) => const LoginScreen()));

    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
          builder: ((context) => OTPScreen(
                verificationId: verificationId,
              )));
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
          builder: ((context) => const UserInformationScreen()));

    case MobileScreenLayout.routeName:
      return MaterialPageRoute(
          builder: ((context) => const MobileScreenLayout()));

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('error'),
          ),
        ),
      );
  }
}
