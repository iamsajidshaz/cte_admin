import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // check if exist
  Future<bool> checkIfDocumentExists(String docId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Homestays')
          .doc(docId)
          .get();
      return doc.exists;
    } catch (e) {
      print("Error checking document existence: $e");
      return false;
    }
  }

  //upload homestay to db
  Future addNewHomeStay(Map<String, dynamic> homestayInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Homestays")
        .doc(id)
        .set(homestayInfoMap);
  }

  // get homestay
  Future<Stream<QuerySnapshot>> getHomestayDetails() async {
    return FirebaseFirestore.instance.collection("Homestays").snapshots();
  }
}
