import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kamusq/pages/update_password_page.dart';
import 'package:kamusq/pages/update_profile_page.dart';
import 'package:kamusq/theme.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    List listItem = [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: 50,
            color: blue,
          ),
          Text(
            'Update Profile',
            style: blueTextStyle.copyWith(fontWeight: semiBold),
          )
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.vpn_key,
            size: 50,
            color: blue,
          ),
          Text(
            'Update Password',
            style: blueTextStyle.copyWith(fontWeight: semiBold),
          )
        ],
      ),
    ];

    List routes = [
      UpdateProfilePage(user: user),
      UpdatePasswordPage(user: user),
    ];

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
                            Icons.settings,
                            size: 150,
                            color: Colors.white,
                          ),
                          Text(
                            'Account Setting',
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
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: GridView.builder(
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => routes[i]));
              },
              borderRadius: BorderRadius.circular(20.0),
              child: Card(
                margin: const EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Center(child: listItem[i]),
              ),
            );
          },
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: listItem.length,
        ),
      ),
    );
  }
}
