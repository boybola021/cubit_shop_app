


import 'package:cubit_shop_app/models/product_model.dart';
import 'package:flutter/material.dart';

import '../screens/controller.dart';
import '../screens/home_page.dart';

final cartController = CartController();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const Home(),
    );
  }
}
