import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kamusq/models/photoUrl_services.dart';
import 'package:kamusq/models/validators.dart';
import 'package:kamusq/pages/main_page.dart';
import 'package:kamusq/theme.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  var usernameController;
  var emailController;
  var imageFile;
  var imagePath;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFile = File(pickedFile!.path);
      imagePath = pickedFile.path;
    });
  }

  @override
  void initState() {
    usernameController =
        TextEditingController(text: "${widget.user.displayName}");
    emailController = TextEditingController(text: "${widget.user.email}");
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
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
                        'Update Profile',
                        style: whiteTextStyle.copyWith(fontSize: 25),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      pickImage();
                    },
                    child: CircleAvatar(
                      maxRadius: 55,
                      backgroundColor: Colors.amber,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: (widget.user.photoURL != null)
                            ? (imageFile != null)
                                ? Image.file(
                                    imageFile,
                                    height: 100,
                                    width: 100,
                                  )
                                : Stack(
                                    children: [
                                      Image.network(
                                        widget.user.photoURL.toString(),
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      Opacity(
                                        opacity: 0.6,
                                        child: Image.asset(
                                          'assets/upload.png',
                                          height: 100,
                                          width: 100,
                                        ),
                                      ),
                                    ],
                                  )
                            : Image.asset(
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
                  validator: (username) => Validators.validateUsername(
                      username: username.toString()),
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
                  height: 40,
                ),
                Center(
                  child: Container(
                    width: 400,
                    height: 60,
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String getUsername = usernameController.text[0]
                                  .toString()
                                  .toUpperCase() +
                              usernameController.text.toString().substring(1);

                          await widget.user.updateDisplayName(getUsername);

                          if (imageFile != null) {
                            PhotoUrlServices.updateUrl(imagePath, imageFile);
                          }

                          final snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.all(20),
                            content: const Text(
                              'Profile data has been updated, re-open the app to see the changes!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            duration: Duration(seconds: 10),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => MainPage(user: widget.user)));
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: blue,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        'Update Profile',
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
