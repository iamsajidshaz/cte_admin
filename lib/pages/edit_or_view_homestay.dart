import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../services/database.dart';

class EditOrViewHomestay extends StatefulWidget {
  final String listNumber;
  final String name;
  final String location;
  final String imageOneUrl;
  final String imageTwoUrl;
  final String imageThreeUrl;
  final String imageFourUrl;
  final String isWifi;
  final String isAc;
  final String isHeater;
  final String isFood;
  final String isParking;

  const EditOrViewHomestay(
      {super.key,
      required this.listNumber,
      required this.name,
      required this.location,
      required this.imageOneUrl,
      required this.imageTwoUrl,
      required this.imageThreeUrl,
      required this.imageFourUrl,
      required this.isWifi,
      required this.isAc,
      required this.isHeater,
      required this.isFood,
      required this.isParking});

  @override
  State<EditOrViewHomestay> createState() => _EditOrViewHomestayState();
}

class _EditOrViewHomestayState extends State<EditOrViewHomestay> {
  late TextEditingController _nameController;
  late TextEditingController _locationController;

  bool issWifi = false;
  bool issAc = false;
  bool issHeater = false;
  bool issFood = false;
  bool issParking = false;

  late String imageOne;
  late String imageTwo;
  late String imageThree;
  late String imageFour;

  // upload
  XFile? imageUpOne;
  XFile? imageUpTwo;
  XFile? imageUpThree;
  XFile? imageUpFour;
  UploadTask? uploadTask;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _locationController = TextEditingController(text: widget.location);
    if (widget.isWifi == "true") {
      issWifi = true;
    }
    if (widget.isAc == "true") {
      issAc = true;
    }
    if (widget.isHeater == "true") {
      issHeater = true;
    }
    if (widget.isFood == "true") {
      issFood = true;
    }
    if (widget.isParking == "true") {
      issParking = true;
    }
    imageOne = widget.imageOneUrl;
    imageTwo = widget.imageTwoUrl;
    imageThree = widget.imageThreeUrl;
    imageFour = widget.imageFourUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit your HomeStay"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // name
              const SizedBox(
                height: 25,
              ),

              const Text(
                "Name",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // location
              const Text(
                "Location",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _locationController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home),
                ),
              ),

              //  photos
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Gallery (Click the image to upload new one)",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 1

                  GestureDetector(
                    onTap: () async {
                      final pictureOne = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (pictureOne != null) {
                        imageUpOne = pictureOne;
                        setState(() {});
                      }

                      // upload image
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      child: imageUpOne == null
                          ? Image.network(
                              imageOne,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(imageUpOne!.path),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  //2
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                      image: DecorationImage(
                        image: NetworkImage(
                          imageTwo,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.photo,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              // 3 and 4
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 3
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                      image: DecorationImage(
                        image: NetworkImage(
                          imageThree,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.photo,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // 4
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                      image: DecorationImage(
                        image: NetworkImage(
                          imageFour,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.photo,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              //

              // facilities
              const SizedBox(
                height: 20,
              ),
              // location
              const Text(
                "Facilities",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),

              // check boxes
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: issWifi,
                onChanged: (value) {
                  setState(() {
                    issWifi = value!;
                  });
                },
                title: const Text(
                  "Wifi",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: issAc,
                onChanged: (value) {
                  setState(() {
                    issAc = value!;
                  });
                },
                title: const Text(
                  "AC",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: issHeater,
                onChanged: (value) {
                  setState(() {
                    issHeater = value!;
                  });
                },
                title: const Text(
                  "Water Heater",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: issFood,
                onChanged: (value) {
                  setState(() {
                    issFood = value!;
                  });
                },
                title: const Text(
                  "Breakfast/Lunch",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: issParking,
                onChanged: (value) {
                  setState(() {
                    issParking = value!;
                  });
                },
                title: const Text(
                  "Free Parking",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              // -------------------

              const SizedBox(
                height: 25,
              ),

              // update button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {
                    // upload to db
                    String id =
                        "${widget.listNumber}_${FirebaseAuth.instance.currentUser!.uid}";
                    Map<String, dynamic> homestayUpdateInfoMap = {
                      "ID": id,
                      "Name": _nameController.text,
                      "Location": _locationController.text,
                      "image_one": imageOne,
                      "image_two": imageTwo,
                      "image_three": imageThree,
                      "image_four": imageFour,
                      "fac1": issWifi.toString(),
                      "fac2": issAc.toString(),
                      "fac3": issHeater.toString(),
                      "fac4": issFood.toString(),
                      "fac5": issParking.toString(),
                    };
                    await DatabaseMethods()
                        .addNewHomeStay(homestayUpdateInfoMap, id)
                        .then((value) {
                      Fluttertoast.showToast(
                          msg: "Homestay updated successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "UPDATE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // upload ---------------

  buildProgress() {
    return StreamBuilder(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  color: Colors.green,
                  backgroundColor: Colors.grey,
                ),
              ),
              Text("${(progress * 100).roundToDouble()}%")
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  // -----------------
}
