import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget MyListView(BuildContext context){ 
  var dataVocab = [
    'Apple', "Developer", "Work", "Kicthen"
  ];

  return ListView.builder(
    itemCount: dataVocab.length,
    itemBuilder: (context, index){
      return ListTile(
        title: Text(dataVocab[index]),
      );
    },
  );
}