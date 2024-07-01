import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_login/controller_bindings.dart';
import 'package:getx_login/src/pages/home.dart';
import 'package:getx_login/src/pages/login.dart';
import 'package:getx_login/src/pages/sign_up.dart';
import 'package:getx_login/src/pages/welcome_login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBindings(),
      debugShowCheckedModeBanner: false,
      title: "Login getx",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      initialRoute: "/",
      getPages: [
        GetPage(
          name: "/",
          page: () => const WelcomeLogin(),
        ),
        GetPage(
          name: "/login",
          page: () => const Login(),
        ),
        GetPage(
          name: "/signup",
          page: () => SignUp(),
        ),
        GetPage(
          name: "/home",
          page: () => const Home(),
        ),
      ],
    );
  }
}
