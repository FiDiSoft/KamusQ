import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kamusq/models/validators.dart';
import 'package:kamusq/theme.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var usernameController;
  var emailController;
  var passwordController;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    usernameController =
        TextEditingController(text: "${widget.user.displayName}");
    emailController = TextEditingController(text: "${widget.user.email}");
    passwordController = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(290),
        child: Container(
          height: 290,
          width: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
            color: blue,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_sharp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        'Settings',
                        style: whiteTextStyle.copyWith(fontSize: 25),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () async {},
                    child: CircleAvatar(
                      maxRadius: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.asset(
                          'assets/upload.png',
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 25, right: 25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username',
                  style: blueTextStyle.copyWith(
                      fontWeight: semiBold, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      fillColor: inputColor,
                      filled: true,
                      hintText: 'type your username...',
                      hintStyle: TextStyle(color: hintColor),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: blue))),
                ),
                SizedBox(
                  height: 30,
                ),
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
                  readOnly: true,
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
                  height: 30,
                ),
                Text(
                  'Password',
                  style: blueTextStyle.copyWith(
                      fontWeight: semiBold, fontSize: 20),
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
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Container(
                    width: 400,
                    height: 60,
                    child: TextButton(
                      onPressed: () async {
                        // String getUsername = usernameController.text[0]
                        //         .toString()
                        //         .toUpperCase() +
                        //     usernameController.text.toString().substring(1);

                        // await widget.user.updatePhotoURL(upload);
                        // await widget.user.updateDisplayName(getUsername);

                        // Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: blue,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        'Update',
                        style: whiteTextStyle.copyWith(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
