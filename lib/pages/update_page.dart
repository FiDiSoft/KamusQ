import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kamusq/models/validators.dart';
import 'package:kamusq/models/vocab_services.dart';
import 'package:kamusq/theme.dart';

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
  var descController;
  var favorite;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    vocabController = TextEditingController(text: widget.mapVocab['vocab']);
    meaningController = TextEditingController(text: widget.mapVocab['meaning']);
    descController = TextEditingController(text: widget.mapVocab['desc']);
    favorite = widget.mapVocab['favorite'];
    super.initState();
  }

  @override
  void dispose() {
    vocabController.dispose();
    meaningController.dispose();
    descController.dispose();
    super.dispose();
  }

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
                            Icons.book,
                            size: 150,
                            color: Colors.white,
                          ),
                          Text(
                            'Update Vocab',
                            style: whiteTextStyle.copyWith(fontSize: 40),
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
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 25, right: 25),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Word',
                  style: blueTextStyle.copyWith(
                      fontWeight: semiBold, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: vocabController,
                  validator: (vocab) =>
                      Validators.validateVocab(vocab: vocab.toString()),
                  decoration: InputDecoration(
                      fillColor: inputColor,
                      filled: true,
                      focusColor: blue,
                      hintText: 'type your password...',
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
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Meaning',
                  style: blueTextStyle.copyWith(
                      fontWeight: semiBold, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: meaningController,
                  validator: (meaning) =>
                      Validators.validateMeaning(meaning: meaning.toString()),
                  decoration: InputDecoration(
                      fillColor: inputColor,
                      filled: true,
                      focusColor: blue,
                      hintText: 'type your password...',
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
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Description',
                  style: blueTextStyle.copyWith(
                      fontWeight: semiBold, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: descController,
                  maxLines: null,
                  decoration: InputDecoration(
                      fillColor: inputColor,
                      filled: true,
                      focusColor: blue,
                      hintText: 'type your password...',
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
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 400,
                    height: 60,
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          String getVocabText =
                              vocabController.text.toUpperCase();
                          String getMeaningText =
                              meaningController.text[0].toUpperCase() +
                                  meaningController.text.substring(1);
                          String getDescText = descController.text;

                          List<String> keywords = [];
                          String searchKey = "";

                          for (int i = 0;
                              i < getVocabText.split('').length;
                              i++) {
                            searchKey = searchKey + getVocabText[i];
                            keywords.add(searchKey);
                          }

                          VocabServices.updateVocab(
                            vocab: getVocabText,
                            meaning: getMeaningText,
                            desc: getDescText,
                            docRef: widget.docRef,
                            keywords: keywords,
                            favorite: favorite,
                          );

                          final snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.all(20),
                            content: const Text(
                              'Word has been updated!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            duration: Duration(seconds: 2),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          Navigator.pop(context);
                        } else {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: const Text(
                              'Please fill out the form!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            duration: Duration(seconds: 2),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: blue,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        'Update Vocab',
                        style: whiteTextStyle.copyWith(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
