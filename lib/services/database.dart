import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  // get single homestay details
  Future<DocumentSnapshot> getSingleeHomestayDetail(String uid) async {
    return await FirebaseFirestore.instance
        .collection('Homestays')
        .doc(uid)
        .get();
  }

  Future<void> deleteUserAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        await _reauthenticateAndDelete();
      } else {
        // Handle other Firebase exceptions
      }
    } catch (e) {
      // Handle general exception
    }
  }

  Future<void> _reauthenticateAndDelete() async {
    try {
      final providerData =
          FirebaseAuth.instance.currentUser?.providerData.first;

      if (AppleAuthProvider().providerId == providerData!.providerId) {
        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithProvider(AppleAuthProvider());
      } else if (GoogleAuthProvider().providerId == providerData.providerId) {
        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithProvider(GoogleAuthProvider());
      }

      await FirebaseAuth.instance.currentUser?.delete();
    } catch (e) {
      // Handle exceptions
    }
  }
}
