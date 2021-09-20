import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kamusq/pages/splash_page.dart';
import 'package:kamusq/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      debugShowCheckedModeBanner: false,
      routes: {'/': (context) => SplashPage()},
    );
  }
}
