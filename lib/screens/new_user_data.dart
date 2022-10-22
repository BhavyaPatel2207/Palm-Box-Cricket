import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_box_cricket/colors/color_file.dart';
import 'package:my_box_cricket/screens/PalmBoxCricket.dart';
import 'package:shared_preferences/shared_preferences.dart';

class newUserData extends StatefulWidget {
  final String userPhone;
  const newUserData({Key? key, required this.userPhone}) : super(key: key);

  @override
  State<newUserData> createState() => _newUserDataState();
}

class _newUserDataState extends State<newUserData> {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  var _form = GlobalKey<FormState>();
  var _gender = "Male";
  var _imageLink;
  bool isLoading = false;

  TextEditingController _name = new TextEditingController();
  TextEditingController _address = new TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  load() {
    return Center(
      child: CircularProgressIndicator(color: primaryColor),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _address.dispose();
    _name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: primaryColor),
            )
          : SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      GestureDetector(
                        onTap: () {
                          pickImage();
                        },
                        child: Container(
                          width: 125,
                          height: 125,
                          decoration: BoxDecoration(
                              color: Colors.grey[200], shape: BoxShape.circle),
                          child: image != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(
                                            File(image!.path),
                                          ))))
                              : Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 35,
                                    color: Colors.grey[400],
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _name,
                          decoration: InputDecoration(
                            labelText: "Name",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.name,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "This field can't be empty";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          initialValue: widget.userPhone,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            border: OutlineInputBorder(),
                          ),
                          enabled: false,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton(
                            isExpanded: true,
                            value: _gender,
                            items: [
                              DropdownMenuItem(
                                child: Text("Male"),
                                value: "Male",
                              ),
                              DropdownMenuItem(
                                child: Text("Female"),
                                value: "Female",
                              ),
                              DropdownMenuItem(
                                child: Text("Others"),
                                value: "Others",
                              ),
                              DropdownMenuItem(
                                child: Text("Rather not to say"),
                                value: "Rather not to say",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _gender = value.toString();
                              });
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _address,
                          decoration: InputDecoration(
                            labelText: "Address",
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 5,
                          keyboardType: TextInputType.streetAddress,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "This field can't be empty";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                          onTap: () async {
                            if (_form.currentState!.validate()) {
                              var name = _name.text.toString();
                              var phoneNumber = widget.userPhone;
                              var gender = _gender.toString();
                              var address = _address.text.toString();
                              FirebaseStorage.instance
                                  .ref("ProfilePics")
                                  .child("${name}_${user!.uid}.jpg")
                                  .putFile(File(image!.path))
                                  .whenComplete(() {})
                                  .then((filedata) async {
                                await filedata.ref
                                    .getDownloadURL()
                                    .then((fileUrl) async {
                                  await _firebaseFirestore
                                      .collection("Users")
                                      .doc(user!.uid)
                                      .set({
                                    "Name": name,
                                    "Phone_Number": phoneNumber,
                                    "Gender": gender,
                                    "Address": address,
                                    "ImageLink": fileUrl
                                  }).then((value) {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PalmBoxCricket()));
                                  });
                                  // print("Data Uploaded");
                                });
                              });
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: 40,
                            child: Center(
                                child: Text(
                              "Done",
                              style: TextStyle(color: Colors.white),
                            )),
                            decoration: BoxDecoration(
                              color: Color(0xff51c878),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
