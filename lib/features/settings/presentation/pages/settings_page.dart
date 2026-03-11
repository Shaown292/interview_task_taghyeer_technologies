import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/presentation/pages/log_in_page.dart';

class SettingsPage extends StatelessWidget {

  const SettingsPage({super.key});

  Future logout(BuildContext context) async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Container(

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.08),
                    blurRadius: 10,
                  )
                ],
              ),

              child: Column(

                children: const [

                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.deepPurple,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(
                    "User Account",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    "Manage your account settings",
                    style: TextStyle(color: Colors.grey),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(

              width: double.infinity,
              height: 50,

              child: ElevatedButton.icon(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                onPressed: () {
                  logout(context);
                },

                icon: const Icon(Icons.logout),

                label: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}