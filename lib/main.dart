import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'excelPage.dart';
import 'screens/logIn/loginPage.dart';
import 'screens/logIn/UnivOrRes.dart';
import 'screens/agent/homePage.dart';
import 'screens/agent/attenteList.dart';
import 'screens/adminScreens/AdminPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'controller/auth_controller.dart';
import 'controller/crud_controller.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  await Firebase.initializeApp().then((value) => Get.put(CrudController()));
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:AdminPage(),
      // login page is lead to admin and agent pages
      // to see student page replace loginPage() by UnivOrRes
    );
  }
}

