import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../services/database.dart';

class AddNewHomestay extends StatefulWidget {
  const AddNewHomestay({
    super.key,
    required this.listNumber,
  });
  final String listNumber;

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
  XFile? imageUpTwo;
  XFile? imageUpThree;
  XFile? imageUpFour;
  UploadTask? uploadTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        title: Text("Add HomeStay ${widget.listNumber}"),
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
              // photo boxes================================

              // image 1
              imageOne == "no"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "IMAGE ONE",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                            width: MediaQuery.of(context).size.width - 20,
                            height: 250,
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
                        const SizedBox(
                          height: 10,
                        ),
                        // upload button

                        uploadTask != null
                            ? buildProgress()
                            : ElevatedButton(
                                onPressed: () async {
                                  // upload task
                                  final imageStorageRef =
                                      FirebaseStorage.instance.ref().child(
                                          "images/homestay/${widget.listNumber}_imageone_${FirebaseAuth.instance.currentUser?.uid}");
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
                  : const ImageUploadedSuccessBox(
                      num: "1",
                    ),
              const SizedBox(
                height: 15,
              ),

              // image 2
              imageTwo == "no"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "IMAGE TWO",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final pictureTwo = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);

                            if (pictureTwo != null) {
                              imageUpTwo = pictureTwo;
                              setState(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: MediaQuery.of(context).size.width - 20,
                            height: 250,
                            child: imageUpTwo == null
                                ? const Center(
                                    child: Icon(
                                      CupertinoIcons.camera,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  )
                                : Image.file(
                                    File(imageUpTwo!.path),
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
                                          "images/homestay/${widget.listNumber}_imagetwo_${FirebaseAuth.instance.currentUser?.uid}");
                                  uploadTask = imageStorageRef
                                      .putFile(File(imageUpTwo!.path));
                                  setState(() {});
                                  final snapshot = await uploadTask!
                                      .whenComplete(() => setState(() {}));
                                  final downloadUrl =
                                      await snapshot.ref.getDownloadURL();
                                  setState(() {
                                    uploadTask = null;
                                    imageTwo = downloadUrl.toString();
                                  });
                                  // ========= end of upload task
                                },
                                child: const Text("Upload"),
                              )
                      ],
                    )
                  : const ImageUploadedSuccessBox(
                      num: "2",
                    ),
              const SizedBox(
                height: 15,
              ),

              // image 3

              imageThree == "no"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "IMAGE THREE",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final pictureThree = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);

                            if (pictureThree != null) {
                              imageUpThree = pictureThree;
                              setState(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: MediaQuery.of(context).size.width - 20,
                            height: 250,
                            child: imageUpThree == null
                                ? const Center(
                                    child: Icon(
                                      CupertinoIcons.camera,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  )
                                : Image.file(
                                    File(imageUpThree!.path),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // upload button

                        uploadTask != null
                            ? buildProgress()
                            : ElevatedButton(
                                onPressed: () async {
                                  // upload task
                                  final imageStorageRef =
                                      FirebaseStorage.instance.ref().child(
                                          "images/homestay/${widget.listNumber}_imagethree_${FirebaseAuth.instance.currentUser?.uid}");
                                  uploadTask = imageStorageRef
                                      .putFile(File(imageUpThree!.path));
                                  setState(() {});
                                  final snapshot = await uploadTask!
                                      .whenComplete(() => setState(() {}));
                                  final downloadUrl =
                                      await snapshot.ref.getDownloadURL();
                                  setState(() {
                                    uploadTask = null;
                                    imageThree = downloadUrl.toString();
                                  });
                                  // ========= end of upload task
                                },
                                child: const Text("Upload"),
                              )
                      ],
                    )
                  : const ImageUploadedSuccessBox(
                      num: "3",
                    ),
              const SizedBox(
                height: 15,
              ),

              // image 4
              imageFour == "no"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "IMAGE FOUR",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final pictureFour = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);

                            if (pictureFour != null) {
                              imageUpFour = pictureFour;
                              setState(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: MediaQuery.of(context).size.width - 20,
                            height: 250,
                            child: imageUpFour == null
                                ? const Center(
                                    child: Icon(
                                      CupertinoIcons.camera,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  )
                                : Image.file(
                                    File(imageUpFour!.path),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // upload button

                        uploadTask != null
                            ? buildProgress()
                            : ElevatedButton(
                                onPressed: () async {
                                  // upload task
                                  final imageStorageRef =
                                      FirebaseStorage.instance.ref().child(
                                          "images/homestay/${widget.listNumber}_imagefour_${FirebaseAuth.instance.currentUser?.uid}");
                                  uploadTask = imageStorageRef
                                      .putFile(File(imageUpFour!.path));
                                  setState(() {});
                                  final snapshot = await uploadTask!
                                      .whenComplete(() => setState(() {}));
                                  final downloadUrl =
                                      await snapshot.ref.getDownloadURL();
                                  setState(() {
                                    uploadTask = null;
                                    imageFour = downloadUrl.toString();
                                  });
                                  // ========= end of upload task
                                },
                                child: const Text("Upload"),
                              )
                      ],
                    )
                  : const ImageUploadedSuccessBox(
                      num: "4",
                    ),
              const SizedBox(
                height: 15,
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
                    if (imageOne != "no" &&
                        imageTwo != "no" &&
                        imageThree != "no" &&
                        imageFour != "no") {
                      // upload to db
                      String id =
                          "${widget.listNumber}_${FirebaseAuth.instance.currentUser!.uid}";
                      Map<String, dynamic> homestayInfoMap = {
                        "ID": id,
                        "Name": _nameController.text,
                        "Location": _locationController.text,
                        "image_one": imageOne,
                        "image_two": imageTwo,
                        "image_three": imageThree,
                        "image_four": imageFour,
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
                    } else {
                      Fluttertoast.showToast(
                        msg: "PLEASE UPLOAD ALL 4 IMAGES FIRST",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }

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
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class ImageUploadedSuccessBox extends StatelessWidget {
  final String num;
  const ImageUploadedSuccessBox({
    super.key,
    required this.num,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green)),
          child: Center(child: Text("Image $num uploaded successfully"))),
    );
  }
}
