import 'package:colin_hanbury_frontend/presentation/chat_page.dart';
import 'package:colin_hanbury_frontend/presentation/home_page.dart';
import 'package:colin_hanbury_frontend/presentation/login_page.dart';
import 'package:colin_hanbury_frontend/presentation/registration_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = 'home';
  static const String chat = 'chat';
  static const String login = 'login';
  static const String registration = 'registration';
}

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Routes.home:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case Routes.chat:
      return MaterialPageRoute(builder: (context) => const ChatPage());
    case Routes.login:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case Routes.registration:
      return MaterialPageRoute(builder: (context) => const RegistrationPage());
    default:
      return MaterialPageRoute(builder: (context) => const HomePage());
  }
}
