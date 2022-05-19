import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  static const String routeName = '/error-screen';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ErrorScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const ErrorScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error Screen"),
      ),
    );
  }
}
