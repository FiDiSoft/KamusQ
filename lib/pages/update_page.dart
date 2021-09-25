import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kamusq/models/vocab_services.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({
    Key? key,
    required this.mapVocab,
    required this.docRef,
  }) : super(key: key);

  final Map<String, dynamic> mapVocab;
  final DocumentReference docRef;

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  var vocabController;
  var meaningController;

  @override
  void initState() {
    vocabController = TextEditingController(text: widget.mapVocab['vocab']);
    meaningController = TextEditingController(text: widget.mapVocab['meaning']);
    super.initState();
  }

  @override
  void dispose() {
    vocabController.dispose();
    meaningController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(children: [
            TextFormField(
              controller: vocabController,
            ),
            TextFormField(
              controller: meaningController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String getVocabText = vocabController.text.toUpperCase();
                String getMeaningText =
                    meaningController.text[0].toUpperCase() +
                        meaningController.text.substring(1);
                List<String> keywords = [];
                String searchKey = "";

                for (int i = 0; i < getVocabText.split('').length; i++) {
                  searchKey = searchKey + getVocabText[i];
                  keywords.add(searchKey);
                }

                VocabServices.updateVocab(
                  vocab: getVocabText,
                  meaning: getMeaningText,
                  docRef: widget.docRef,
                  keywords: keywords,
                );

                Navigator.pop(context);
              },
              child: Text('update vocab'),
            )
          ]),
        ),
      ),
    );
  }
}
