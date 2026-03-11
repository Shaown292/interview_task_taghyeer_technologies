import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/presentation/pages/log_in_page.dart';
import 'home_page.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final loggedIn = prefs.getBool("loggedIn") ?? false;

  runApp(MyApp(loggedIn));
}

class MyApp extends StatelessWidget {

  final bool loggedIn;

  const MyApp(this.loggedIn,{super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loggedIn ? const HomePage() : const LoginPage(),
    );
  }
}