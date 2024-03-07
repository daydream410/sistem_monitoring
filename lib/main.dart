import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sistem_monitoring/controllers/controller.dart';
import 'package:sistem_monitoring/pages/login_screen.dart';
import 'package:sistem_monitoring/routes/page_route.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD8TaX1Xi3Bz3TIGrnhdWOrA1nceRcEkLw",
      databaseURL:
          "https://minreg-d83b6-default-rtdb.asia-southeast1.firebasedatabase.app",
      appId: "1:582300207089:android:bace57a2656df118726650",
      messagingSenderId: "582300207089",
      projectId: "minreg-d83b6",
      storageBucket: "minreg-d83b6.appspot.com",
    ),
  );
  Get.put(Controller());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
      initialRoute: '/',
      getPages: PagesRouting.pages,
    );
  }
}
