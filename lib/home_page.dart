import 'package:flutter/material.dart';

import 'features/post/presentation/pages/post_page.dart';
import 'features/product/presentation/pages/product_page.dart';
import 'features/settings/presentation/pages/settings_page.dart';


class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int index = 0;

  final pages = const [
    ProductsPage(),
    PostsPage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: pages[index],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: index,

        onTap: (i){
          setState(() {
            index = i;
          });
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Products",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: "Posts",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}