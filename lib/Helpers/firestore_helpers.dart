import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelpers {
  FireStoreHelpers._();

  static final FireStoreHelpers fireStoreHelpers = FireStoreHelpers._();

  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<DocumentReference<Map<String, dynamic>>> insertdata(
      {required Map<String, dynamic> data}) async {
    DocumentReference<Map<String, dynamic>> docRef =
        await firebaseFirestore.collection("students").add(data);
    return docRef;
  }

  Stream<QuerySnapshot> featchalldata() {
    return firebaseFirestore.collection("students").snapshots();
  }

  Future<void> deletedata({required String id}) async {
    await firebaseFirestore.collection("students").doc(id).delete();
  }

  Future<void> updatedata(
      {required Map<String, dynamic> data, required String id}) async {
    await firebaseFirestore.collection("students").doc(id).update(data);
  }
}
