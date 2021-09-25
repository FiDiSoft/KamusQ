import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kamusq/models/auth_services.dart';
import 'package:kamusq/models/vocab_services.dart';
import 'package:kamusq/pages/add_page.dart';
import 'package:kamusq/pages/profile_page.dart';
import 'package:kamusq/pages/update_page.dart';
import 'package:kamusq/theme.dart';

class MainPage extends StatefulWidget {
  final User user;

  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String searchKey = '';

  @override
  Widget build(BuildContext context) {
    Size _mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(320),
        child: Container(
          height: 320.0,
          width: _mediaQuery.width,
          decoration: new BoxDecoration(
            color: blue,
            boxShadow: [new BoxShadow(blurRadius: 10.0)],
            borderRadius: new BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () =>
                            _scaffoldKey.currentState!.openDrawer(),
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Hello, \n${(widget.user.displayName != null && widget.user.displayName != '') ? widget.user.displayName : "Learners"}',
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
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              searchKey = value.toUpperCase();
                            });
                          },
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
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddPage(
                    uid: widget.user.uid,
                  ),
                ),
              ),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProfilePage(user: widget.user)));
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
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (searchKey != '')
            ? VocabServices.firebaseFirestore
                .collection('userId${widget.user.uid}')
                .where('keywords', arrayContains: searchKey)
                .snapshots()
            : VocabServices.firebaseFirestore
                .collection('userId${widget.user.uid}')
                .orderBy('timestamp', descending: true)
                .snapshots(),
        builder: (context, vocabSnapshot) {
          if (vocabSnapshot.hasError) {
            return Text('Something went wrong');
          }

          if (vocabSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemBuilder: (context, i) {
              DocumentSnapshot _vocabsDocument = vocabSnapshot.data!.docs[i];
              Map<String, dynamic> _mapVocab =
                  _vocabsDocument.data() as Map<String, dynamic>;

              return InkWell(
                onTap: () {},
                child: Card(
                  color: blue,
                  margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          "${_mapVocab['vocab']}",
                          style: whiteTextStyle.copyWith(fontSize: 20),
                        ),
                        Text(
                          "${_mapVocab['meaning']}",
                          style: whiteTextStyle.copyWith(
                              fontSize: 15, color: Colors.grey),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UpdatePage(
                                    mapVocab: _mapVocab,
                                    docRef: _vocabsDocument.reference),
                              ),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            VocabServices.deleteVocab(
                                _vocabsDocument.reference);
                          },
                          icon: Icon(Icons.delete),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: vocabSnapshot.data!.docs.length,
          );
        },
      ),
    );
  }
}
