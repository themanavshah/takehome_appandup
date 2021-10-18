import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserActions {
  Future<bool> addToFav({required String bookid}) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('Users').doc(uid);

      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(documentReference);
        if (!snapshot.exists) {
          documentReference.set({
            'favorites': [bookid],
          });
          return true;
        }
        var bookstemp = (snapshot.data() as Map<String, dynamic>);
        List prevbooks = bookstemp["favorites"];
        List currBooks = [...prevbooks, bookid];
        transaction.update(documentReference, {'favorites': currBooks});
        return true;
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> removeFromFav({required String bookid}) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('Users').doc(uid);

      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(documentReference);
        if (!snapshot.exists) {
          documentReference.set({
            'favorites': [bookid],
          });
          return true;
        }
        var bookstemp = (snapshot.data() as Map<String, dynamic>);
        List books = bookstemp["favorites"];
        //books.removeWhere((element) => element["id"] == book["id"]);
        books.remove(bookid);
        transaction.update(documentReference, {'favorites': books});
        return true;
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
