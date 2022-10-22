import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_box_cricket/colors/color_file.dart';
import 'package:my_box_cricket/screens/login_screen.dart';

class profilePageAccount extends StatefulWidget {
  @override
  State<profilePageAccount> createState() => _profilePageAccountState();
}

class _profilePageAccountState extends State<profilePageAccount> {
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchDetails();
  }

  // Future<void> fetchDetails() async {
  //   try {
  //     FirebaseFirestore.instance
  //         .collection("Users")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get()
  //         .then((DocumentSnapshot) {
  //       setState(() {
  //         ImageLink = DocumentSnapshot.data()!["ImageLink"];
  //         Username = DocumentSnapshot.data()!["Name"];
  //         PhoneNumber = DocumentSnapshot.data()!["Phone_Number"];
  //         Gender = DocumentSnapshot.data()!["Gender"];
  //         Address = DocumentSnapshot.data()!["Address"];
  //       });
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  CollectionReference userReference =
      FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: userReference.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            Map<String, dynamic> userData =
                snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 127, 200, 151),
                  ),
                  child: Center(
                    child: Container(
                      width: 150,
                      height: 150,
                      // child: Image.network(userData["ImageLink"]),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black),
                          
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(userData["ImageLink"]))),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(userData["Name"]),
                  leading: Icon(
                    Icons.person,
                    color: Color(0xff51c878),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Color(0xff51c878),
                    ),
                    onPressed: () {
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    "Phone Number",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(userData["Phone_Number"]),
                  leading: Icon(
                    Icons.phone,
                    color: Color(0xff51c878),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Gender",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(userData["Gender"]),
                  leading: Icon(
                    Icons.male,
                    color: Color(0xff51c878),
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        color: Color(0xff51c878),
                      )),
                ),
                ListTile(
                  title: Text(
                    "Address",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(userData["Address"]),
                  leading: Icon(
                    Icons.map,
                    color: Color(0xff51c878),
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        color: Color(0xff51c878),
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: 40,
                      child: Center(
                          child: Text(
                        "Change Language",
                        style: TextStyle(color: Colors.white),
                      )),
                      decoration: BoxDecoration(
                        color: Color(0xff51c878),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: 40,
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Logout",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ))
              ],
            );
          }
          return Center(
            child: Center(
                child: CircularProgressIndicator(
              color: primaryColor,
            )),
          );
        }
      },
    ));
  }
}
