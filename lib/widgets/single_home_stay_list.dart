import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cte_admin/pages/add_new_homestay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/edit_or_view_homestay.dart';
import '../services/database.dart';

class SingleHomeStayList extends StatefulWidget {
  final String listNumber;
  const SingleHomeStayList({
    super.key,
    required this.listNumber,
  });

  @override
  State<SingleHomeStayList> createState() => _SingleHomeStayListState();
}

class _SingleHomeStayListState extends State<SingleHomeStayList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: DatabaseMethods().getSingleeHomestayDetail(
          "${widget.listNumber}_${FirebaseAuth.instance.currentUser!.uid}"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || !snapshot.data!.exists) {
          // if no homestay
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNewHomestay(
                    listNumber: widget.listNumber,
                  ),
                ),
              ).then((value) => setState(() {}));
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent,
              ),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "+ Add HomeStay ${widget.listNumber}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        } else {
          // if homestay exist
          DocumentSnapshot ds = snapshot.data!;
          Map<String, dynamic> data = ds.data() as Map<String, dynamic>;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditOrViewHomestay(
                    listNumber: widget.listNumber,
                    name: data["Name"],
                    location: data["Location"],
                    imageOneUrl: data["image_one"],
                    imageTwoUrl: data["image_two"],
                    imageThreeUrl: data["image_three"],
                    imageFourUrl: data["image_four"],
                    isWifi: data["fac1"],
                    isAc: data["fac2"],
                    isHeater: data["fac3"],
                    isFood: data["fac4"],
                    isParking: data["fac5"],
                  ),
                ),
              ).then((value) => setState(() {}));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Colors.grey,
                    image: DecorationImage(
                      image: NetworkImage(
                        data["image_one"],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.home,
                              size: 12,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              data["Name"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.place,
                              size: 12,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              data["Location"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
