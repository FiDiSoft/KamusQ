import 'package:flutter/material.dart';
import 'package:kamusq/pages/login_page.dart';
import 'package:kamusq/theme.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:30),
              child: Column(
                
                children: [
                  Text('Welome to', style: blueTextStyle.copyWith(fontSize: 30),),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Kamus', style: blueTextStyle.copyWith(fontSize: 30, fontWeight: bold),),
                    Text('Q', style: yellowTextStyle.copyWith(fontSize: 30, fontWeight: bold),)
                  ],
                ),
                Image.asset('assets/welcome.png', width: 500, height: 450,),
                Container(
                  height: 59,
                  width: 222,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: TextButton(
                    onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    }, 
                    child: Text('Login', style: whiteTextStyle.copyWith(fontSize: 20),)),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 59,
                  width: 222,
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: TextButton(
                    onPressed: (){
                        
                    }, 
                    child: Text('Register', style: blackTextStyle.copyWith(fontSize: 20),)),
                )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}