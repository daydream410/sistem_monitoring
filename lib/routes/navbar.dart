import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sistem_monitoring/pages/dasboard_screen.dart';
import 'package:sistem_monitoring/pages/log_screen.dart';
import 'package:sistem_monitoring/pages/profile_screen.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectedIndex = 1;
  final screen = [const ProfilePage(), const DashboardPage(), const LogPage()];
  final GlobalKey _key = GlobalKey();
  GlobalKey getKey() => _key;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: getKey(),
        index: selectedIndex,
        items: const [
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.list_alt,
            size: 30,
            color: Colors.white,
          ),
        ],
        color: Colors.blue,
        buttonBackgroundColor: Colors.blue,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOutBack,
        animationDuration: const Duration(milliseconds: 400),
        height: 70,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: screen[selectedIndex],
    );
  }
}
