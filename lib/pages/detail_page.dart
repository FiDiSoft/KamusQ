import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kamusq/theme.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.mapVocab, required this.vocabRef})
      : super(key: key);

  final DocumentReference vocabRef;
  final Map<String, dynamic> mapVocab;

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
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          size: 35,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${mapVocab['vocab']}',
                            style: whiteTextStyle.copyWith(fontSize: 40),
                          ),
                          Text(
                            '${mapVocab['meaning']}',
                            style: yellowTextStyle.copyWith(fontSize: 30),
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
        child: Container(
          width: _mediaQuery.width,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 53.0),
              Text(
                'Description',
                style: blackTextStyle.copyWith(fontSize: 20),
              ),
              Text(
                'Lorem ipsum dolor sit amet, quodsi incorrupte et mei, iudicabit appellantur at sea. Id modus iusto corpora has. Dolores necessitatibus vim te, nam in modo alienum. An simul iriure convenire qui, et numquam reprehendunt has. Eos ad adhuc nemore, qui etiam novum facete no.',
                style: blueTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
