import 'package:frontend/configs/config.dart';
import 'package:frontend/providers/auth/auth_provider.dart';
import 'package:frontend/widget/widget_button.dart';
import 'package:frontend/widget/widget_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';

  const LoginScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const LoginScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailC = TextEditingController(text: '');
  TextEditingController passwordC = TextEditingController(text: '');

  ValueNotifier<bool> obsText = ValueNotifier(true);

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  final _formKey = GlobalKey<FormState>();

  showhide() {
    obsText.value = !obsText.value;
  }

  onLogin(String email, String password) async {
    isLoading.value = true;
    await context
        .read(authProvider.notifier)
        .login(email, password)
        .then((value) {
      messageDialog(context, value['message']);
      Navigator.pushNamedAndRemoveUntil(
          context, '/main-screen', (route) => false);

      isLoading.value = false;
    }).catchError((onError) {
      messageDialog(context, onError['message']);
      isLoading.value = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    passwordC.dispose();
    obsText.dispose();
    isLoading.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var formEmail = PrimaryTextField(
      hintText: "Email",
      txtInputType: TextInputType.emailAddress,
      icon: Icons.email,
      controller: emailC,
      validator: (value) => value!.isEmpty ? 'E-mail cannot be blank' : null,
    );

    var formPass = ValueListenableBuilder<bool>(
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

    var submit = ValueListenableBuilder<bool>(
      valueListenable: isLoading,
      builder: (_, value, __) {
        if (value) {
          return const CircularProgressIndicator();
        }
        return PrimaryButton(
          hint: "LOGIN",
          onTap: () {
            final form = _formKey.currentState;
            if (form!.validate()) {
              onLogin(emailC.text, passwordC.text);
            }
          },
        );
      },
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: gradientTheme,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter),
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(100)),
                ),
                child: const Center(
                  child: Text("Quiz App",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        formEmail,
                        formPass,
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
                        submit,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: RichText(
                                text: const TextSpan(children: [
                                  TextSpan(
                                    text: "Don't have an account ?  ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ]),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/register-screen');
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
