import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kamusq/pages/welcome_page.dart';
import 'package:kamusq/theme.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/kamus.json', width: 250, height: 250),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Kamus', style: blueTextStyle.copyWith(fontSize: 30, fontWeight: bold),),
                  Text('Q', style: yellowTextStyle.copyWith(fontSize: 30, fontWeight: bold),)
                ],
              ),
              SizedBox(height: 5,),
              Text('save your vocabulary', style: greyTextStyle.copyWith(fontSize: 20),)
            ],
          ),
        )
      ),
    );
  }
}