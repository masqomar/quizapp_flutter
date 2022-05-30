import 'package:frontend/configs/config.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/providers/auth/auth_provider.dart';
import 'package:frontend/widget/widget_button.dart';
import 'package:frontend/widget/widget_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register-screen';

  const RegisterScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const RegisterScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userNameC = TextEditingController(text: '');
  TextEditingController firstNameC = TextEditingController(text: '');
  TextEditingController lastNameC = TextEditingController(text: '');
  TextEditingController emailC = TextEditingController(text: '');
  TextEditingController passwordC = TextEditingController(text: '');
  TextEditingController repasswordC = TextEditingController(text: '');
  TextEditingController phoneC = TextEditingController(text: '');

  ValueNotifier<bool> obsText = ValueNotifier(true);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  final _formKey = GlobalKey<FormState>();

  onRegister(UserModel user, String password) async {
    await context
        .read(authProvider.notifier)
        .register(user, password)
        .then((value) {
      messageDialog(context, value['message']);
      Navigator.pushNamedAndRemoveUntil(
          context, '/index-exam-screen', (route) => false);
    }).catchError((onError) {
      messageDialog(context, onError['message']);
    });
    isLoading.value = false;
  }

  showhide() {
    obsText.value = !obsText.value;
  }

  @override
  void dispose() {
    super.dispose();
    userNameC.dispose();
    firstNameC.dispose();
    lastNameC.dispose();
    emailC.dispose();
    passwordC.dispose();
    repasswordC.dispose();
    phoneC.dispose();
    obsText.dispose();
    isLoading.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userName = PrimaryTextField(
      hintText: "Username",
      txtInputType: TextInputType.text,
      icon: Icons.supervised_user_circle,
      controller: userNameC,
      validator: (value) => value!.isEmpty ? 'Username cannot be blank' : null,
    );

    var firstName = PrimaryTextField(
      hintText: "Firstname",
      txtInputType: TextInputType.text,
      icon: Icons.perm_contact_calendar,
      controller: firstNameC,
      validator: (value) => value!.isEmpty ? 'Firstname cannot be blank' : null,
    );

    var lastName = PrimaryTextField(
      hintText: "Lastname",
      txtInputType: TextInputType.text,
      icon: Icons.perm_contact_calendar,
      controller: lastNameC,
      validator: (value) => value!.isEmpty ? 'Lastname cannot be blank' : null,
    );

    var phone = PrimaryTextField(
      hintText: "Phone",
      txtInputType: TextInputType.phone,
      icon: Icons.phone,
      controller: phoneC,
      validator: (value) => value!.isEmpty ? 'Phone cannot be blank' : null,
    );

    var email = PrimaryTextField(
      hintText: "E-mail",
      txtInputType: TextInputType.emailAddress,
      icon: Icons.mail,
      controller: emailC,
      validator: (value) => value!.isEmpty ? 'E-mail cannot be blank' : null,
    );

    var pass = ValueListenableBuilder<bool>(
      valueListenable: obsText,
      builder: (_, value, __) {
        return PrimaryTextField(
          hintText: "Password",
          txtInputType: TextInputType.text,
          icon: Icons.vpn_key,
          controller: passwordC,
          obsText: value,
          validator: (value) =>
              value!.isEmpty ? 'Password cannot be blank' : null,
        );
      },
    );

    var repass = ValueListenableBuilder<bool>(
      valueListenable: obsText,
      builder: (_, value, __) {
        return PrimaryTextField(
            hintText: "Password",
            txtInputType: TextInputType.text,
            icon: Icons.vpn_key,
            controller: repasswordC,
            obsText: value,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Retype Password cannot be blank';
              }

              if (repasswordC.text != passwordC.text) {
                return 'Password does not match';
              }
              return null;
            });
      },
    );

    var submit = ValueListenableBuilder<bool>(
      valueListenable: isLoading,
      builder: (_, value, __) {
        if (value) {
          return const CircularProgressIndicator();
        }
        return PrimaryButton(
          hint: "REGISTER",
          onTap: () {
            isLoading.value = true;
            final form = _formKey.currentState;
            if (form!.validate()) {
              UserModel user = UserModel(
                userName: userNameC.text,
                firstName: firstNameC.text,
                lastName: lastNameC.text,
                phone: phoneC.text,
                email: emailC.text,
              );

              onRegister(user, passwordC.text);
            }
          },
        );
      },
    );

    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: gradientTheme,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter),
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(100)),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/logo.svg',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      userName,
                      firstName,
                      lastName,
                      phone,
                      email,
                      pass,
                      repass,
                      InkWell(
                        onTap: () {
                          showhide();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          alignment: Alignment.centerRight,
                          child: ValueListenableBuilder<bool>(
                            valueListenable: obsText,
                            builder: (_, value, __) {
                              return Text(
                                value ? "Show Password" : "Hide Password",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800),
                                textAlign: TextAlign.end,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      submit,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: RichText(
                              text: const TextSpan(children: [
                                TextSpan(
                                    text: "have an account ?",
                                    style: TextStyle(color: Colors.black)),
                              ]),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
