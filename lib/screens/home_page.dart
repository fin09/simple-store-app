import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const String id = 'home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.cartPlus),
            onPressed: () {
              Navigator.pushNamed(context, '/add_product');
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          children: [
            Text('item1', style: TextStyle(fontSize: 20, color: Colors.grey)),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  r'350$',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Spacer(),
                Icon(FontAwesomeIcons.heart, color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
