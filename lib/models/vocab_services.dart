import 'package:cloud_firestore/cloud_firestore.dart';

class VocabServices {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static Map<String, dynamic> _mapVocab(
      {required String vocab, required String meaning}) {
    return {
      'timestamp': FieldValue.serverTimestamp(),
      'vocab': vocab,
      'meaning': meaning,
    };
  }

  static Future<DocumentReference<Object?>> addVocab(
      String vocab, String meaning, String uid) async {
    return await firebaseFirestore
        .collection('userId$uid')
        .add(_mapVocab(vocab: vocab, meaning: meaning));
  }

  static Future<Transaction> updateVocab(
      String vocab, String meaning, DocumentReference docRef) async {
    return await firebaseFirestore.runTransaction(
      (transaction) async {
        return transaction.update(
            docRef, _mapVocab(vocab: vocab, meaning: meaning));
      },
    );
  }

  static Future<Transaction> deleteVocab(DocumentReference docRef) async {
    return await firebaseFirestore.runTransaction(
      (transaction) async => transaction.delete(docRef),
    );
  }
}
