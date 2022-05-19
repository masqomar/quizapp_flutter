import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = '/notification-screen';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const NotificationScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Screen"),
      ),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
                radius: 20,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/140x100')),
            title: Text("Notification $index"),
            subtitle: const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque aliquet purus nisi, sed tempor urna sodales a. Pellentesque eu nunc eget nisi accumsan rhoncus. "),
          );
        },
      ),
    );
  }
}
