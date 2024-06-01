import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../services/database.dart';

class AddNewHomestay extends StatefulWidget {
  const AddNewHomestay({super.key});

  @override
  State<AddNewHomestay> createState() => _AddNewHomestayState();
}

class _AddNewHomestayState extends State<AddNewHomestay> {
  bool isWifi = false;
  bool isAc = false;
  bool isHeater = false;
  bool isFood = false;
  bool isParking = false;

  // homestay details
  late final String name;
  late final String location;
  String imageOne = "no";
  String imageTwo = "no";
  String imageThree = "no";
  String imageFour = "no";

  //
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();

  // upload
  XFile? imageUpOne;
  UploadTask? uploadTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add New HomeStay"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              // homestay name------------------
              const Text(
                "HomeStay Name",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home),
                  labelText: "Name...",
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              // location
              const Text(
                "HomeStay Location",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_pin),
                  labelText: "Paste the location link from GoogleMap)",
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              //----------
              const Text(
                "Add Photos",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              // photo boxes
              imageOne == "no"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final pictureOne = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);

                            if (pictureOne != null) {
                              imageUpOne = pictureOne;
                              setState(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            height: MediaQuery.of(context).size.width / 2 - 20,
                            child: imageUpOne == null
                                ? const Center(
                                    child: Icon(
                                      CupertinoIcons.camera,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  )
                                : Image.file(
                                    File(imageUpOne!.path),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        // upload button

                        uploadTask != null
                            ? buildProgress()
                            : ElevatedButton(
                                onPressed: () async {
                                  // upload task
                                  final imageStorageRef =
                                      FirebaseStorage.instance.ref().child(
                                          "images/homestay/imageone_${FirebaseAuth.instance.currentUser?.uid}");
                                  uploadTask = imageStorageRef
                                      .putFile(File(imageUpOne!.path));
                                  setState(() {});
                                  final snapshot = await uploadTask!
                                      .whenComplete(() => setState(() {}));
                                  final downloadUrl =
                                      await snapshot.ref.getDownloadURL();
                                  setState(() {
                                    uploadTask = null;
                                    imageOne = downloadUrl.toString();
                                  });
                                  // ========= end of upload task
                                },
                                child: const Text("Upload"),
                              )
                      ],
                    )
                  : Center(
                      child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green)),
                          child: const Center(
                              child: Text("Image 1 uploaded successfully"))),
                    ),
              const SizedBox(
                height: 15,
              ),
              // 3rd and 4th picture
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    height: MediaQuery.of(context).size.width / 2 - 20,
                    child: const Center(
                      child: Icon(
                        CupertinoIcons.camera,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    height: MediaQuery.of(context).size.width / 2 - 20,
                    child: const Center(
                      child: Icon(
                        CupertinoIcons.camera,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              // ===========================
              const Text(
                "Available Facilities",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              // check boxes
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: isWifi,
                onChanged: (value) {
                  setState(() {
                    isWifi = value!;
                  });
                },
                title: const Text(
                  "Wifi",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: isAc,
                onChanged: (value) {
                  setState(() {
                    isAc = value!;
                  });
                },
                title: const Text(
                  "AC",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: isHeater,
                onChanged: (value) {
                  setState(() {
                    isHeater = value!;
                  });
                },
                title: const Text(
                  "Water Heater",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: isFood,
                onChanged: (value) {
                  setState(() {
                    isFood = value!;
                  });
                },
                title: const Text(
                  "Breakfast/Lunch",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: isParking,
                onChanged: (value) {
                  setState(() {
                    isParking = value!;
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

              // submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {
                    // upload to db
                    String id = FirebaseAuth.instance.currentUser!.uid;
                    Map<String, dynamic> homestayInfoMap = {
                      "ID": id,
                      "Name": _nameController.text,
                      "Location": _locationController.text,
                      "image_one": imageOne,
                      "fac1": isWifi.toString(),
                      "fac2": isAc.toString(),
                      "fac3": isHeater.toString(),
                      "fac4": isFood.toString(),
                      "fac5": isParking.toString(),
                      "status": "pending",
                    };
                    await DatabaseMethods()
                        .addNewHomeStay(homestayInfoMap, id)
                        .then((value) {
                      Fluttertoast.showToast(
                          msg: "Homestay submitted successfully for review",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    });
                    Navigator.pop(context);

                    // ==================end============================
                  },
                  child: const Text(
                    "Submit for review",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              // PS
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "PS: Your listing will be live within 2 working days once it is accepted"),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
          return SizedBox.shrink();
        }
      },
    );
  }
}
