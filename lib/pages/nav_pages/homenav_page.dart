import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cte_admin/pages/add_new_homestay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/database.dart';
import '../../widgets/add_new_listing_box.dart';

class HomenavPage extends StatefulWidget {
  const HomenavPage({super.key});

  @override
  State<HomenavPage> createState() => _HomenavPageState();
}

class _HomenavPageState extends State<HomenavPage> {
  Stream? homestayStream;

  getOnTheLoad() async {
    homestayStream = await DatabaseMethods().getHomestayDetails();
    setState(() {});
  }

  bool isHomestayExist = false;
  checkIfHomestayExist() async {
    bool isExist = false;
    isExist = await DatabaseMethods()
        .checkIfDocumentExists(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      isHomestayExist = isExist;
    });
  }

  @override
  void initState() {
    checkIfHomestayExist();
    getOnTheLoad();
    super.initState();
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
              // header
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

              //-----------------
              const SizedBox(
                height: 12,
              ),

              // homestay
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Your Homestays",
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        bool exists = await DatabaseMethods()
                            .checkIfDocumentExists(
                                FirebaseAuth.instance.currentUser!.uid);

                        if (exists) {
                          Fluttertoast.showToast(
                              msg: "Already Added: Listing limit exceeded",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddNewHomestay(),
                            ),
                          ).then((value) => setState(() {
                                isHomestayExist = true;
                              }));
                        }
                      },
                      icon: Icon(Icons.add))
                ],
              ),

              //-----------------
              const SizedBox(
                height: 12,
              ),

              Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.width / 2 - 20,
                child: isHomestayExist
                    ? StreamBuilder(
                        stream: homestayStream,
                        builder: (context, AsyncSnapshot snapshot) {
                          return snapshot.hasData
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.docs!.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot ds =
                                        snapshot.data.docs[index];

                                    return Container(
                                      margin: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      height:
                                          MediaQuery.of(context).size.width /
                                                  2 -
                                              20,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(ds["Name"]),
                                          Text(ds["Location"]),
                                        ],
                                      ),
                                    );
                                  })
                              : Text(
                                  "HOMESTAY",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                );
                        },
                      )
                    : Center(
                        child: Text(
                          "Click on + to add your HOMESTAY",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
              ),

              const SizedBox(
                height: 25,
              ),

              // add new listings - boxes

              const SizedBox(
                height: 12,
              ),
              const Row(
                children: [
                  AddNewListingBox(
                    listingName: 'LODGE',
                    color: Colors.orangeAccent,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  AddNewListingBox(
                    listingName: 'SHOP',
                    color: Colors.greenAccent,
                  ),
                ],
              ),
              //
              const SizedBox(
                height: 50,
              ),
              // space for banner ad
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Center(
                  child: Text("AdMob Banner Ad"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
