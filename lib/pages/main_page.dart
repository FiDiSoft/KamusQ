import 'package:flappy_search_bar_ns/flappy_search_bar_ns.dart';
import 'package:flutter/material.dart';
import 'package:kamusq/theme.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: blue,
        elevation: 0,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: blue
                ),
                child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Kamus', style: whiteTextStyle.copyWith(fontSize: 30, fontWeight: bold),),
                  Text('Q', style: yellowTextStyle.copyWith(fontSize: 30, fontWeight: bold),)
                ],
              ),
              ),
              ListTile(
              title: const Text('Profile'),
              leading:  Icon(Icons.account_circle),
              minLeadingWidth: 10,
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Setting'),
              leading: Icon(Icons.settings),
              minLeadingWidth: 10,
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Exit'),
              leading: Icon(Icons.exit_to_app),
              minLeadingWidth: 10,
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ],
          )
        ),
        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 230.0,
          width: double.infinity,
          decoration: new BoxDecoration(
            color: blue,
            boxShadow: [new BoxShadow(blurRadius: 10.0)],
            borderRadius: new BorderRadius.vertical(
                bottom: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Stack(
            children: [
              Row(
                children: [
                  Text('Hello, \nAjeng Hidayati', style: whiteTextStyle.copyWith(fontSize: 25, fontWeight: medium),),
                  Spacer(),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: yellow,
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage('assets/women.jpeg'),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        ),
        
      ],
    )));
  }
}
