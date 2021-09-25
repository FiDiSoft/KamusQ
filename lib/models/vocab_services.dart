import 'package:cloud_firestore/cloud_firestore.dart';

class VocabServices {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static Map<String, dynamic> _mapVocab(
      {required String vocab,
      required String meaning,
      required List keywords}) {
    return {
      'timestamp': FieldValue.serverTimestamp(),
      'vocab': vocab,
      'meaning': meaning,
      'keywords': keywords,
    };
  }

  static Future<DocumentReference<Object?>> addVocab(
      {required String vocab,
      required String meaning,
      required String uid,
      required List keywords}) async {
    return await firebaseFirestore
        .collection('userId$uid')
        .add(_mapVocab(vocab: vocab, meaning: meaning, keywords: keywords));
  }

  static Future<Transaction> updateVocab(
      {required String vocab,
      required String meaning,
      required DocumentReference docRef,
      required List keywords}) async {
    return await firebaseFirestore.runTransaction(
      (transaction) async {
        return transaction.update(docRef,
            _mapVocab(vocab: vocab, meaning: meaning, keywords: keywords));
      },
    );
  }

  static Future<Transaction> deleteVocab(DocumentReference docRef) async {
    return await firebaseFirestore.runTransaction(
      (transaction) async => transaction.delete(docRef),
    );
  }
}
