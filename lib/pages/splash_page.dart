import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kamusq/auth.dart';
import 'package:kamusq/models/auth_services.dart';
import 'package:kamusq/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return StreamProvider.value(
              value: AuthServices.userStream,
              initialData: null,
              child: Auth(),
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/kamus.json', width: 250, height: 250),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Kamus',
                  style: blueTextStyle.copyWith(fontSize: 30, fontWeight: bold),
                ),
                Text(
                  'Q',
                  style:
                      yellowTextStyle.copyWith(fontSize: 30, fontWeight: bold),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'save your vocabulary',
              style: greyTextStyle.copyWith(fontSize: 20),
            )
          ],
        ),
      )),
    );
  }
}
