import 'package:flutter/material.dart';

import 'login.page.dart';
import 'register.page.dart';
import 'list.page.dart';
import 'profile.page.dart';
import 'newprofile.page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/list": (context) => ListPage(),
        "/profile": (context) => ProfilePage(),
        "/newprofile": (context) => NewProfilePage(),
      },
      initialRoute: '/login',
    );
  }
}
