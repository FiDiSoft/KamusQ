import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kamusq/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var usernameController;
  var emailController;

  @override
  void initState() {
    usernameController = TextEditingController(
        text: (widget.user.displayName != null)
            ? widget.user.displayName.toString()
            : '');
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
                        'Profile User',
                        style: whiteTextStyle.copyWith(fontSize: 25),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CircleAvatar(
                    maxRadius: 55,
                    backgroundColor: Colors.amber,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: (widget.user.photoURL != null)
                          ? Image.network(
                              widget.user.photoURL.toString(),
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/upload.png',
                              height: 100,
                              width: 100,
                            ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    (widget.user.displayName != null)
                        ? widget.user.displayName.toString()
                        : '',
                    style: whiteTextStyle.copyWith(
                        fontSize: 25, fontWeight: FontWeight.bold),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style:
                    blueTextStyle.copyWith(fontWeight: semiBold, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: usernameController,
                readOnly: true,
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
                style:
                    blueTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: emailController,
                readOnly: true,
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
            ],
          ),
        ),
      ),
    );
  }
}
