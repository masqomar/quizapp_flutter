import 'package:frontend/configs/app_helper.dart';
import 'package:frontend/configs/app_theme.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/providers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndexUserScreen extends StatefulWidget {
  static const String routeName = '/index-user-screen';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const IndexUserScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const IndexUserScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _IndexUserScreenState createState() => _IndexUserScreenState();
}

class _IndexUserScreenState extends State<IndexUserScreen> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  doLogout() async {
    isLoading.value = true;
    await context.read(authProvider.notifier).logout().then((value) {
      messageDialog(context, value['message']);

      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      isLoading.value = false;
    }).catchError((onError) {
      messageDialog(context, onError['message']);
    });

    isLoading.value = false;
  }

  @override
  void dispose() {
    super.dispose();
    isLoading.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text("Profil Pengguna"),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: isLoading,
        builder: (_, value, __) {
          if (value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Consumer(
            builder: (context, watch, child) {
              return FutureBuilder<UserModel>(
                future: watch(authProvider.notifier).getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        "terjadi kesalahan",
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  if (snapshot.hasData) {
                    final dataUser = snapshot.data;
                    return SingleChildScrollView(
                      child: Stack(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              SizedBox(
                                height: 250,
                                width: double.infinity,
                                child: Image.asset(
                                  "assets/images/default.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: 16,
                                bottom: 40,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: IconButton(
                                    splashColor: Colors.blueGrey,
                                    hoverColor: Colors.blueGrey,
                                    icon: Icon(
                                      Icons.create,
                                      color: themeColors,
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, "/edit-user-screen");
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(
                                16.0, 200.0, 16.0, 16.0),
                            child: Column(
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(16.0),
                                      margin: const EdgeInsets.only(top: 16.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 96.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () {},
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "${dataUser!.userName}",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const ListTile(
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  subtitle: Text("about"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/images/default.png"),
                                        ),
                                      ),
                                      margin: const EdgeInsets.only(left: 16.0),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      const ListTile(
                                        title: Text("Informasi Pengguna"),
                                      ),
                                      const Divider(),
                                      ListTile(
                                        onTap: () {},
                                        title: const Text("Pointku"),
                                        subtitle: const Text("point"),
                                        leading: Icon(
                                          Icons.star,
                                          color: themeColors,
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text("Email"),
                                        subtitle: Text("${dataUser.email}"),
                                        leading: Icon(
                                          Icons.email,
                                          color: themeColors,
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text("Phone"),
                                        subtitle: Text("${dataUser.phone}"),
                                        leading: Icon(
                                          Icons.phone,
                                          color: themeColors,
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text("Role"),
                                        subtitle: Text("${dataUser.role}"),
                                        leading: Icon(
                                          Icons.person,
                                          color: themeColors,
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text("LogOut"),
                                        leading: Icon(
                                          Icons.exit_to_app,
                                          color: themeColors,
                                        ),
                                        onTap: () {
                                          doLogout();
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          )
                        ],
                      ),
                    );
                  }

                  return Container();
                },
              );
            },
          );
        },
      ),
    );
  }
}
