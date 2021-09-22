import 'package:flutter/material.dart';
import 'package:kamusq/models/vocab_services.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

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
                VocabServices.addVocab(
                    vocabController.text.toUpperCase(),
                    meaningController.text[0].toUpperCase() +
                        meaningController.text.substring(1));

                vocabController.text = '';
                meaningController.text = '';

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
