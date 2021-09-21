import 'package:cloud_firestore/cloud_firestore.dart';

class VocabsServices {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static CollectionReference vocabsCollection =
      firebaseFirestore.collection('vocabs');

  static Future<DocumentReference<Object?>> addVocab(
      String vocab, String meaning) async {
    return await vocabsCollection.add(
      {
        'vocab': vocab,
        'meaning': meaning,
      },
    );
  }
}
