import 'package:get/get.dart';
import 'package:sistem_monitoring/pages/dasboard_screen.dart';
import 'package:sistem_monitoring/pages/detail_log_screen.dart';
import 'package:sistem_monitoring/pages/log_screen.dart';
import 'package:sistem_monitoring/pages/login_screen.dart';
import 'package:sistem_monitoring/pages/profile_screen.dart';
import 'package:sistem_monitoring/routes/navbar.dart';
import 'package:sistem_monitoring/routes/route_name.dart';

class PagesRouting {
  static final pages = [
    GetPage(
      name: RouteName.loginPage,
      page: () => LoginPage(),
    ),
    GetPage(
      name: RouteName.navbarPage,
      page: () => const Navbar(),
    ),
    GetPage(
      name: RouteName.dasboardPage,
      page: () => const DashboardPage(),
    ),
    GetPage(
      name: RouteName.profilePage,
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: RouteName.logPage,
      page: () => const LogPage(),
    ),
    GetPage(
      name: RouteName.detailLogPage,
      page: () => const DetailLog(),
    ),
  ];
}
