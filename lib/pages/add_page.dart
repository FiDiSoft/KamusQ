import 'package:flutter/material.dart';
import 'package:kamusq/models/vocab_services.dart';
import 'package:kamusq/theme.dart';

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
  TextEditingController descController = TextEditingController(text: '');

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
                            'Add Vocab',
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Word',
              style: blueTextStyle.copyWith(fontWeight: semiBold, fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: vocabController,
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
              style: blueTextStyle.copyWith(fontWeight: semiBold, fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: meaningController,
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
              style: blueTextStyle.copyWith(fontWeight: semiBold, fontSize: 20),
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
                    String getVocabText = vocabController.text.toUpperCase();
                    String getMeaningText =
                        meaningController.text[0].toUpperCase() +
                            meaningController.text.substring(1);
                    String getDescText = descController.text[0].toUpperCase() +
                        descController.text.substring(1);

                    List<String> keywords = [];
                    String searchKey = "";

                    for (int i = 0; i < getVocabText.split('').length; i++) {
                      searchKey = searchKey + getVocabText[i];
                      keywords.add(searchKey);
                    }

                    VocabServices.addVocab(
                      vocab: getVocabText,
                      meaning: getMeaningText,
                      desc: getDescText,
                      uid: widget.uid,
                      keywords: keywords,
                    );

                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: blue,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text(
                    'Add Vocab',
                    style: whiteTextStyle.copyWith(fontSize: 20),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
