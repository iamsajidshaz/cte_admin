import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/add_new_listing_box.dart';

class HomenavPage extends StatelessWidget {
  const HomenavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
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
              // add new listings - boxes
              const Row(
                children: [
                  AddNewListingBox(
                    listingName: 'HOMESTAY',
                    color: Colors.blueAccent,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  AddNewListingBox(
                    listingName: 'TAXI',
                    color: Colors.lightBlueAccent,
                  ),
                ],
              ),
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
