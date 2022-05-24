import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/global_provider.dart';
import 'configs/config.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      const ProviderScope(
        child: MyApp(),
      );
    });
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App CPNS',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: '/',
    );
  }
}

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SplashScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  runSplash() async {
    var duration = const Duration(seconds: 1);
    Timer(duration, goto);
  }

  void goto() {
    context.read(authRepository).readSessionUser().then((value) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        value != null ? '/index-exam-screen' : '/login-screen',
        (_) => false,
      );
    });
  }

  @override
  void initState() {
    runSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Quiz App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
