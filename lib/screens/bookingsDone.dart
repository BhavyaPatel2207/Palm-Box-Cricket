import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_box_cricket/colors/color_file.dart';

class bookingsDone extends StatefulWidget {
  const bookingsDone({Key? key}) : super(key: key);

  @override
  State<bookingsDone> createState() => _bookingsDoneState();
}

class _bookingsDoneState extends State<bookingsDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("Bookings")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                );
              } else {
                if (snapshot.data!.size <= 0) {
                  return Center(
                    child: Text("No data found at present"),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  children: snapshot.data!.docs.map((document) {
                    return MaterialButton(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      minWidth: MediaQuery.of(context).size.width / 1.5,
                      onPressed: () {
                        DocumentReference doc = FirebaseFirestore.instance
                            .collection("slot_booked")
                            .doc();
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          CouponCard(
                            height: 160,
                            backgroundColor: Colors.orange,
                            curveAxis: Axis.vertical,
                            firstChild: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'SLOT',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "" +
                                                document["time_slot"]
                                                    .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                      color: Colors.white54, height: 0),
                                  const Expanded(
                                    child: Center(
                                      child: Text(
                                        'PALM BOX\nCRICKET',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            secondChild: Container(
                              width: double.maxFinite,
                              padding: const EdgeInsets.all(18),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '' + document["customer_name"].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '' + document["date"].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text("Price : " + document["price_slot"])
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }
            }));
  }
}