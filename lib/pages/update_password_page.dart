import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kamusq/models/validators.dart';
import 'package:kamusq/theme.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  TextEditingController newPasswordController = TextEditingController(text: '');
  TextEditingController confirmNewPasswordController =
      TextEditingController(text: '');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(300),
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
            color: blue,
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.vpn_key,
                            size: 150,
                            color: Colors.white,
                          ),
                          Text(
                            'Update Password',
                            style: whiteTextStyle.copyWith(fontSize: 30),
                          ),
                        ]),
                  )
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
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Password',
                  style: blueTextStyle.copyWith(
                      fontWeight: semiBold, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: newPasswordController,
                  obscureText: true,
                  validator: (password) => Validators.validateNewPassword(
                      password: password.toString()),
                  decoration: InputDecoration(
                      fillColor: inputColor,
                      filled: true,
                      focusColor: blue,
                      hintText: 'type new password carefully...',
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
                  'Confirm New Password',
                  style: blueTextStyle.copyWith(
                      fontWeight: semiBold, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: confirmNewPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      fillColor: inputColor,
                      filled: true,
                      focusColor: blue,
                      hintText: 're-type new password',
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
                        if (formKey.currentState!.validate()) {
                          String getPassword = newPasswordController.text;
                          String getConfirmPassword =
                              confirmNewPasswordController.text;

                          if (getPassword != '') {
                            if (getPassword == getConfirmPassword) {
                              await widget.user.updatePassword(getPassword);

                              final snackBar = SnackBar(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.all(20),
                                content: const Text(
                                  'Password has been updated!',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                duration: Duration(seconds: 2),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              Navigator.pop(context);
                            } else {
                              final snackBar1 = SnackBar(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.all(20),
                                content: const Text(
                                  'Passwords are not the same!',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                duration: Duration(seconds: 2),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar1);
                            }
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: blue,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        'Update Password',
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
