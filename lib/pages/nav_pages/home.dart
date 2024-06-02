import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cte_admin/pages/add_new_homestay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/database.dart';
import '../../widgets/add_new_listing_box.dart';
import '../../widgets/single_home_stay_list.dart';

class HomenavPage extends StatefulWidget {
  const HomenavPage({super.key});

  @override
  State<HomenavPage> createState() => _HomenavPageState();
}

class _HomenavPageState extends State<HomenavPage> {
  Stream? homestayStream;
  bool isHomestayExist = false;

  @override
  void initState() {
    super.initState();
    checkIfHomestayExist();
    loadHomestayDetails();
  }

  Future<void> loadHomestayDetails() async {
    homestayStream = await DatabaseMethods().getHomestayDetails();
    setState(() {});
  }

  Future<void> checkIfHomestayExist() async {
    try {
      bool exists = await DatabaseMethods()
          .checkIfDocumentExists(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        isHomestayExist = exists;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error checking homestay existence: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                "Manage",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                ),
              ),
              const Text(
                "Your Listings",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                ),
              ),
              const SizedBox(height: 12),
              Divider(
                color: Colors.grey[200],
                thickness: 1,
              ),
              const SizedBox(height: 25),

              // homestay listings
              const Row(
                children: [
                  Icon(Icons.home),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "HomeStays",
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // single homestay 1
              const SingleHomeStayList(
                listNumber: 'one',
              ),

              const SizedBox(
                height: 15,
              ),
              // single homestay 2
              const SingleHomeStayList(
                listNumber: 'two',
              ),
              const SizedBox(
                height: 25,
              ),
              // single homestay 3
              const SingleHomeStayList(
                listNumber: 'three',
              ),
              const SizedBox(
                height: 25,
              ),

              // Add New Listings
              // const Row(
              //   children: [
              //     AddNewListingBox(
              //       listingName: 'LODGE',
              //       color: Colors.orangeAccent,
              //     ),
              //     SizedBox(width: 10),
              //     AddNewListingBox(
              //       listingName: 'SHOP',
              //       color: Colors.greenAccent,
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 50),

              // Ad Banner
              // Container(
              //   height: 100,
              //   width: MediaQuery.of(context).size.width - 20,
              //   decoration: BoxDecoration(
              //     color: Colors.grey,
              //     borderRadius: BorderRadius.circular(10),
              //     border: Border.all(color: Colors.black),
              //   ),
              //   child: Center(child: Text("AdMob Banner Ad")),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
