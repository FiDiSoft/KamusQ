import 'package:flutter/material.dart';
import 'package:kamusq/models/vocab_services.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    Key? key,
    required this.uid,
  }) : super(key: key);

  final String uid;

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController vocabController = TextEditingController(text: '');
  TextEditingController meaningController = TextEditingController(text: '');

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

                VocabServices.addVocab(
                  vocab: getVocabText,
                  meaning: getMeaningText,
                  uid: widget.uid,
                  keywords: keywords,
                );

                Navigator.pop(context);
              },
              child: Text('add vocab'),
            )
          ]),
        ),
      ),
    );
  }
}
