import 'package:frontend/configs/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/screens/screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/main-screen';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const MainScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ValueNotifier<int> selectedIndex = ValueNotifier(0);

  void _onItemTapped(int index) {
    selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: mBackgroundColor,
          bottomNavigationBar: Container(
            height: 69,
            decoration: BoxDecoration(
              color: mFillColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                )
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: ValueListenableBuilder<int>(
                    valueListenable: selectedIndex,
                    builder: (_, value, __) => value == 0
                        ? SvgPicture.asset(
                            "assets/icons/home.svg",
                            color: themeColors,
                          )
                        : SvgPicture.asset("assets/icons/home.svg"),
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: ValueListenableBuilder<int>(
                    valueListenable: selectedIndex,
                    builder: (_, value, __) => value == 1
                        ? SvgPicture.asset(
                            "assets/icons/watch.svg",
                            color: themeColors,
                          )
                        : SvgPicture.asset("assets/icons/watch.svg"),
                  ),
                  label: "Exam",
                ),
                BottomNavigationBarItem(
                  icon: ValueListenableBuilder<int>(
                    valueListenable: selectedIndex,
                    builder: (_, value, __) => value == 2
                        ? SvgPicture.asset(
                            "assets/icons/order.svg",
                            color: themeColors,
                          )
                        : SvgPicture.asset("assets/icons/order.svg"),
                  ),
                  label: "Article",
                ),
                BottomNavigationBarItem(
                  icon: ValueListenableBuilder<int>(
                    valueListenable: selectedIndex,
                    builder: (_, value, __) => value == 3
                        ? SvgPicture.asset(
                            "assets/icons/account.svg",
                            color: themeColors,
                          )
                        : SvgPicture.asset("assets/icons/account.svg"),
                  ),
                  label: "Profile",
                ),
              ],
              currentIndex: selectedIndex.value,
              selectedItemColor: themeColors,
              unselectedItemColor: themeColors,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.bold),
              onTap: _onItemTapped,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 14,
              showUnselectedLabels: true,
              elevation: 0,
            ),
          ),
          body: ValueListenableBuilder<int>(
            valueListenable: selectedIndex,
            builder: (_, value, __) {
              if (value == 0) {
                return const DashboardScreen();
              }

              if (value == 1) {
                return const IndexExamScreen();
              }

              if (value == 2) {
                return const IndexArticleScreen();
              }

              if (value == 3) {
                return const IndexUserScreen();
              }

              return const ErrorScreen();
            },
          ),
        ),
      ),
    );
  }
}
