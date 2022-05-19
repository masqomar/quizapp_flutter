import 'package:frontend/configs/app_theme.dart';
import 'package:frontend/widget/widget_button.dart';
import 'package:frontend/widget/widget_textfield.dart';
import 'package:flutter/material.dart';

class EditUserScreen extends StatefulWidget {
  static const String routeName = '/edit-user-screen';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const EditUserScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const EditUserScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  TextEditingController userNameC = TextEditingController(text: "");
  TextEditingController firstNameC = TextEditingController(text: "");
  TextEditingController lastNameC = TextEditingController(text: "");
  TextEditingController emailC = TextEditingController(text: "");
  TextEditingController phoneC = TextEditingController(text: "");
  TextEditingController addressC = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    var userName = PrimaryTextField(
        hintText: "Username",
        txtInputType: TextInputType.text,
        icon: Icons.person,
        controller: userNameC);

    var firstName = PrimaryTextField(
        hintText: "Firstname",
        txtInputType: TextInputType.emailAddress,
        icon: Icons.person,
        controller: firstNameC);

    var lastName = PrimaryTextField(
        hintText: "Lastname",
        txtInputType: TextInputType.emailAddress,
        icon: Icons.person,
        controller: lastNameC);

    var email = PrimaryTextField(
        hintText: "Email",
        txtInputType: TextInputType.emailAddress,
        icon: Icons.email,
        controller: emailC);

    var phone = PrimaryTextField(
        hintText: "Phone",
        txtInputType: TextInputType.phone,
        icon: Icons.phone,
        controller: phoneC);

    var address = PrimaryTextField(
        hintText: "Address",
        txtInputType: TextInputType.text,
        icon: Icons.map,
        controller: addressC);

    var foto = PrimaryTextField(
      hintText: "Foto",
      txtInputType: TextInputType.text,
      icon: Icons.camera,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );

    var submit = PrimaryButton(
      hint: "UPDATE",
      onTap: () {},
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColors,
        centerTitle: true,
        title: const Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/default.png",
                fit: BoxFit.contain,
              ),
            ),
            userName,
            firstName,
            lastName,
            email,
            phone,
            address,
            foto,
            submit,
          ],
        ),
      ),
    );
  }
}
