import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kamusq/models/auth_services.dart';
import 'package:kamusq/models/validators.dart';
import 'package:kamusq/pages/register_page.dart';
import 'package:kamusq/theme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login',
                style:
                    blueTextStyle.copyWith(fontSize: 30, fontWeight: semiBold),
              ),
              Text(
                'increase your vocabulary',
                style: greyTextStyle.copyWith(fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Image.asset(
                  'assets/person.png',
                  width: 183,
                  height: 166,
                ),
              ),
              SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: blueTextStyle.copyWith(
                          fontSize: 20, fontWeight: semiBold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (email) =>
                          Validators.validateEmail(email: email.toString()),
                      decoration: InputDecoration(
                          fillColor: inputColor,
                          filled: true,
                          focusColor: blue,
                          hintText: 'type your email...',
                          hintStyle: TextStyle(color: hintColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: grey),
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: blue),
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Password',
                      style: blueTextStyle.copyWith(
                          fontSize: 20, fontWeight: semiBold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: (password) => Validators.validatePassword(
                          password: password.toString()),
                      decoration: InputDecoration(
                          fillColor: inputColor,
                          filled: true,
                          focusColor: blue,
                          hintText: 'type your password...',
                          hintStyle: TextStyle(color: hintColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: grey),
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: blue),
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Container(
                  width: 400,
                  height: 60,
                  child: TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await AuthServices.login(
                            email: emailController.text,
                            password: passwordController.text);
                      }

                      if (FirebaseAuth.instance.currentUser != null) {
                        Navigator.pop(context);
                      }
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: blue,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(
                      'Login',
                      style: whiteTextStyle.copyWith(fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Create New Account',
                      style: greyTextStyle.copyWith(fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
