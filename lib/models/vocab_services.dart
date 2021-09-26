import 'package:cloud_firestore/cloud_firestore.dart';

class VocabServices {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static Map<String, dynamic> _mapVocab(
      {required String vocab,
      required String meaning,
      required String desc,
      required bool favorite,
      required List keywords}) {
    return {
      'timestamp': FieldValue.serverTimestamp(),
      'vocab': vocab,
      'meaning': meaning,
      'desc': desc,
      'favorite': favorite,
      'keywords': keywords,
    };
  }

  static Future<DocumentReference<Object?>> addVocab(
      {required String vocab,
      required String meaning,
      required String desc,
      bool favorite = false,
      required String uid,
      required List keywords}) async {
    return await firebaseFirestore.collection('userId$uid').add(
          _mapVocab(
            vocab: vocab,
            meaning: meaning,
            keywords: keywords,
            desc: desc,
            favorite: favorite,
          ),
        );
  }

  static Future<Transaction> updateVocab(
      {required String vocab,
      required String meaning,
      required String desc,
      required DocumentReference docRef,
      required bool favorite,
      required List keywords}) async {
    return await firebaseFirestore.runTransaction(
      (transaction) async {
        return transaction.update(
          docRef,
          _mapVocab(
            vocab: vocab,
            meaning: meaning,
            keywords: keywords,
            desc: desc,
            favorite: favorite,
          ),
        );
      },
    );
  }

  static Future<Transaction> deleteVocab(DocumentReference docRef) async {
    return await firebaseFirestore.runTransaction(
      (transaction) async => transaction.delete(docRef),
    );
  }
}
