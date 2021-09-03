import 'package:flutter/material.dart';
import 'package:kamusq/pages/register_page.dart';
import 'package:kamusq/theme.dart';
import 'package:email_validator/email_validator.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isEmailValid = true;
  TextEditingController emailController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 30, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Login', style: blueTextStyle.copyWith(fontSize: 30, fontWeight: semiBold),),
              Text('increase your vocabulary', style: greyTextStyle.copyWith(fontSize: 20),),
              SizedBox(height: 30,),
              Center(
                child: Image.asset('assets/person.png', width: 183, height: 166,),
              ),
              SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email', style: blueTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: emailController,
                    onChanged: (value){
                      print(value);
                      bool isValid = EmailValidator.validate(value);
                      print(isValid);
                      if(isValid){
                        setState(() {
                          isEmailValid = true;
                        });
                      } else {
                        setState(() {
                          isEmailValid = false;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: inputColor,
                      filled: true,
                      focusColor: blue,
                      hintText: 'type your email...',
                      hintStyle: TextStyle(color: hintColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: grey),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isEmailValid ? blue : Colors.red
                        ),
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('Password', style: blueTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),),
                  SizedBox(height: 5,),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: inputColor,
                      filled: true,
                      focusColor: blue,
                      hintText: 'type your password...',
                      hintStyle: TextStyle(color: hintColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: grey),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blue),
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Center(
                child: Container(
                  width: 400,
                  height: 60,
                  child: TextButton(
                    onPressed: (){
                      
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: blue,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                    child: Text('Login', style: whiteTextStyle.copyWith(fontSize: 20),),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Center(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Create New Account',
                      style: greyTextStyle.copyWith(
                        fontSize: 16
                      ),
                    ),
                  ),
                ),
              )
            
            ],
          ),
        )
      ),
    );
  }
}