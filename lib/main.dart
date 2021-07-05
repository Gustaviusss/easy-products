import 'package:flutter/material.dart';
import 'package:products/screens/login_screen.dart';
import 'package:products/screens/products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Products',
      initialRoute: '/login',
      routes: {
        '/login':(context) => LoginScreen(),
        '/home': (context) => ProductsScreen(token: '')
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String token;
  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
