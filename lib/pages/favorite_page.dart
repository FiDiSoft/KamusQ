import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kamusq/models/vocab_services.dart';
import 'package:kamusq/pages/detail_page.dart';
import 'package:kamusq/pages/update_page.dart';
import 'package:kamusq/theme.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    Size _mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
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
                            Icons.bookmark,
                            size: 150,
                            color: Colors.white,
                          ),
                          Text(
                            'Favorite Vocab',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: VocabServices.firebaseFirestore
            .collection('userId${widget.user.uid}')
            .where('favorite', isEqualTo: true)
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
              bool myFavorite = _mapVocab['favorite'];

              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(
                          vocabRef: _vocabsDocument.reference,
                          mapVocab: _mapVocab,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Slidable(
                      actionPane: SlidableScrollActionPane(),
                      actionExtentRatio: 0.20,
                      secondaryActions: [
                        IconSlideAction(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => UpdatePage(
                                          docRef: _vocabsDocument.reference,
                                          mapVocab: _mapVocab,
                                        )));
                          },
                          icon: Icons.edit,
                          color: Colors.green,
                        ),
                        IconSlideAction(
                          onTap: () {
                            VocabServices.deleteVocab(
                                _vocabsDocument.reference);
                          },
                          icon: Icons.delete,
                          color: Colors.red,
                        ),
                      ],
                      child: Card(
                        color: blue,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                            ],
                          ),
                        ),
                      ),
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
