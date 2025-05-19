import 'package:flutter/material.dart';
import 'package:bookstore/pages/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:bookstore/pages/settings_pages/settings_account.dart';
import 'package:bookstore/pages/settings_pages/settings_notifications.dart';
import 'package:bookstore/pages/settings_pages/settings_language.dart';
import 'package:bookstore/pages/settings_pages/settings_help.dart';
import 'package:bookstore/pages/settings_pages/settings_privacy.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(
      path: '/settings/account',
      builder: (context, state) => const SettingsAccount(),
    ),
    GoRoute(
      path: '/settings/notifications',
      builder: (context, state) => const SettingsNotifications(),
    ),
    GoRoute(
      path: '/settings/language',
      builder: (context, state) => const SettingsLanguage(),
    ),
    GoRoute(
      path: '/settings/help',
      builder: (context, state) => const SettingsHelp(),
    ),
    GoRoute(
      path: '/settings/privacy',
      builder: (context, state) => const SettingsPrivacy(),
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'CustomFont'),
      routerConfig: _router,
    );
  }
}
