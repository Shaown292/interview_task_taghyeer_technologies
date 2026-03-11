import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  Future login() async {

    setState(() {
      loading = true;
    });

    try {

      final response = await Dio().post(
        "https://dummyjson.com/auth/login",
        data: {
          "username": usernameController.text,
          "password": passwordController.text
        },
      );

      if(response.statusCode == 200){

        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool("loggedIn", true);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => const HomePage()));
      }

    } catch(e){

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login failed")));

    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(

          children: [

            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: loading ? null : login,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}