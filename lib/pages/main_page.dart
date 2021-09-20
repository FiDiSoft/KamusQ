import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kamusq/models/auth_services.dart';
import 'package:kamusq/theme.dart';
import 'package:kamusq/widgets/listview.dart';

class MainPage extends StatelessWidget {
  final User user;

  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: blue,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white)),
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
            backgroundColor: yellow),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: blue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Kamus',
                    style:
                        whiteTextStyle.copyWith(fontSize: 30, fontWeight: bold),
                  ),
                  Text(
                    'Q',
                    style: yellowTextStyle.copyWith(
                        fontSize: 30, fontWeight: bold),
                  )
                ],
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              leading: Icon(Icons.account_circle),
              minLeadingWidth: 10,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Setting'),
              leading: Icon(Icons.settings),
              minLeadingWidth: 10,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              leading: Icon(Icons.exit_to_app),
              minLeadingWidth: 10,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                            title: Text("Log Out"),
                            content: Text("Do you want Log Out? "),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, "No");
                                  },
                                  child: Text("No")),
                              TextButton(
                                  onPressed: () async {
                                    await AuthServices.logOut();
                                    Navigator.pop(context, "Yes");
                                  },
                                  child: Text("Yes")),
                            ]));
              },
            ),
          ],
        )),
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
                    Column(children: [
                      Row(
                        children: [
                          Text(
                            'Hello, \nAjeng Hidayati',
                            style: whiteTextStyle.copyWith(
                                fontSize: 25, fontWeight: medium),
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: yellow,
                            child: CircleAvatar(
                                radius: 45,
                                backgroundImage:
                                    AssetImage("assets/profile.png")),
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(
                            fillColor: inputColor,
                            filled: true,
                            hintText: 'find your vocab',
                            prefixIcon:
                                Icon(Icons.search, color: blue, size: 32),
                            hintStyle: TextStyle(color: hintColor),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: blue))),
                      ),
                    ])
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 460,
              child: ListView.builder(
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){

                    },
                    child: Card(
                      color: blue,
                      margin: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Apple", style: whiteTextStyle.copyWith(fontSize: 20),),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        )));
  }
}
