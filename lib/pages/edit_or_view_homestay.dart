import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../services/database.dart';
import '../widgets/image_upload_success_box.dart';

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

  String imageOne = "no";
  String imageTwo = "no";
  String imageThree = "no";
  String imageFour = "no";

  late String oldImageOne;
  late String oldImageTwo;
  late String oldImageThree;
  late String oldImageFour;

  List<String> oldImagesList = [];

  // upload
  XFile? imageUpOne;
  XFile? imageUpTwo;
  XFile? imageUpThree;
  XFile? imageUpFour;
  UploadTask? uploadTask;

  @override
  void initState() {
    super.initState();
    //
    _nameController = TextEditingController(text: widget.name);
    _locationController = TextEditingController(text: widget.location);
    //
    oldImageOne = widget.imageOneUrl;
    oldImageTwo = widget.imageTwoUrl;
    oldImageThree = widget.imageThreeUrl;
    oldImageFour = widget.imageFourUrl;
    oldImagesList.add(oldImageOne);
    oldImagesList.add(oldImageTwo);
    oldImagesList.add(oldImageThree);
    oldImagesList.add(oldImageFour);

    //
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
                "HomeStay Gallery",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // current gallery

              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: oldImagesList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                        image: DecorationImage(
                          image: NetworkImage(
                            oldImagesList[index],
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
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
// for upload
              // image 1
              imageOne == "no"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Upload new IMAGE ONE",
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
                                    oldImagesList[0] = imageOne;
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
                          "Upload new IMAGE TWO",
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
                                    oldImagesList[1] = imageTwo;
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
                          "Upload new IMAGE THREE",
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
                                    oldImagesList[2] = imageThree;
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
                          "Upload new IMAGE FOUR",
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
                                    oldImagesList[3] = imageFour;
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

              // ---------------------------------------------

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
                    String ione, itwo, ithree, ifour;
                    if (imageOne == "no") {
                      ione = oldImageOne;
                    } else {
                      ione = imageOne;
                    }
                    if (imageTwo == "no") {
                      itwo = oldImageTwo;
                    } else {
                      itwo = imageTwo;
                    }
                    if (imageThree == "no") {
                      ithree = oldImageThree;
                    } else {
                      ithree = imageThree;
                    }
                    if (imageFour == "no") {
                      ifour = oldImageFour;
                    } else {
                      ifour = imageFour;
                    }
                    Map<String, dynamic> homestayUpdateInfoMap = {
                      "ID": id,
                      "Name": _nameController.text,
                      "Location": _locationController.text,
                      "image_one": ione,
                      "image_two": itwo,
                      "image_three": ithree,
                      "image_four": ifour,
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
