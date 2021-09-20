import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kamusq/pages/main_page.dart';
import 'package:kamusq/pages/welcome_page.dart';
import 'package:provider/provider.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);

    return (user != null) ? MainPage(user: user) : WelcomePage();
  }
}
