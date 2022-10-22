import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_box_cricket/screens/PalmBoxCricket.dart';
import 'package:my_box_cricket/screens/homePage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class bookNow extends StatefulWidget {
  const bookNow({Key? key}) : super(key: key);

  @override
  State<bookNow> createState() => _bookNowState();
}

class _bookNowState extends State<bookNow> {
  List slots = [
    "00:00 - 01:00",
    "01:00 - 02:00",
    "02:00 - 03:00",
    "03:00 - 04:00",
    "04:00 - 05:00",
    "05:00 - 06:00",
    "06:00 - 07:00",
    "07:00 - 08:00",
    "08:00 - 09:00",
    "09:00 - 10:00",
    "10:00 - 11:00",
    "11:00 - 12:00",
    "12:00 - 13:00",
    "13:00 - 14:00",
    "14:00 - 15:00",
    "15:00 - 16:00",
    "16:00 - 17:00",
    "17:00 - 18:00",
    "18:00 - 19:00",
    "19:00 - 20:00",
    "20:00 - 21:00",
    "21:00 - 22:00",
    "22:00 - 23:00",
    "23:00 - 00:00",
  ];

  List price = [
    "₹ 1,500",
    "₹ 1,500",
    "₹ 1,500",
    "₹ 1,200",
    "₹ 1,200",
    "₹ 1,200",
    "₹ 1,200",
    "₹ 1,200",
    "₹ 1,000",
    "₹ 1,000",
    "₹ 1,000",
    "₹ 1,000",
    "₹ 1,000",
    "₹ 1,000",
    "₹ 1,000",
    "₹ 1,200",
    "₹ 1,200",
    "₹ 1,200",
    "₹ 1,200",
    "₹ 1,200",
    "₹ 1,500",
    "₹ 1,500",
    "₹ 1,500",
    "₹ 1,500",
  ];

  var _form = GlobalKey<FormState>();

  TextEditingController _name = new TextEditingController();
  TextEditingController _secondaryPhoneNumber = new TextEditingController();
  String _primaryPhoneNumber = "+919327625700";
  var _slotSelected;
  var _priceSlot;

  var _datePicker = new DateTime.now();

  var userDate;

  var successfull = 0;

  // paymentDialog() {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Confirm Booking"),
  //           content: Text(
  //               "Do you wanna confirm your booking and head towards payment ?"),
  //           actions: [
  //             MaterialButton(
  //               child: Text("Cancel"),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             MaterialButton(child: Text("Pay Now"), onPressed: () {})
  //           ],
  //         );
  //       });
  // }

  late Razorpay _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  var BookName;
  var Phone;
  var BookDate;
  var TimeSlot;
  var PriceSlot;

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print('Success Response: $response');
    setState(() {
      successfull = 1;
    });
    // FirebaseFirestore.instance
    //     .collection("Users")
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .collection("Bookings")
    //     .add({
    //   "customer_name": BookName,
    //   "primary_phone_number": _primaryPhoneNumber,
    //   "secondary_phone_number": Phone,
    //   "date": BookDate,
    //   "time_slot": TimeSlot,
    //   "price_slot": PriceSlot
    // }).then((val) {
    //   // bookFinalTicketUser(bookName: name,phone:_primaryPhoneNumber, BookedDate: _newdate, TimeSlot: _slotSelected,Price: _priceSlot);
    //   FirebaseFirestore.instance.collection('slot_booked').add({
    //     "customer_name": BookName,
    //     "primary_phone_number": _primaryPhoneNumber,
    //     "secondary_phone_number": Phone,
    //     "date": BookDate,
    //     "time_slot": TimeSlot,
    //     "price_slot": PriceSlot
    //   });
    // });

    // bookFinalTicketUser(
    //     bookName: BookName,
    //     phone: Phone,
    //     BookedDate: BookDate,
    //     TimeSlot: TimeSlot,
    //     Price: PriceSlot);
    // successfull = 1;
    // Toast.show("Booked");
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    print('Error Response: $response');
    // successfull = 0;
    // Toast.show("Payment Error. Please check");
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) async {
    print('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }

  Future<void> createOrder() async {
    var options = {
      'key': 'rzp_test_CcGswyED7Ch42I',
      'amount': '100',
      'currency': 'INR',
      'name': 'Palm Box Cricket',
      'description': 'Booking for ',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '9327625700',
        'email': 'test@razorpay.com',
        'method': {'card': 0, 'netbanking': 0, 'wallet': 1, 'upi': 1}
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  CollectionReference userReferences =
      FirebaseFirestore.instance.collection("slot_booked");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book your slot"),
        backgroundColor: Color(0xff51c878),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
            key: _form,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Name", border: OutlineInputBorder()),
                    keyboardType: TextInputType.name,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "This field is required";
                      }
                    },
                    controller: _name,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Phone", border: OutlineInputBorder()),
                    enabled: false,
                    initialValue:
                        "${FirebaseAuth.instance.currentUser!.phoneNumber}",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Secondary Phone",
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    controller: _secondaryPhoneNumber,
                    maxLength: 10,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "This field is required";
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      DatePicker(
                        DateTime.now(),
                        initialSelectedDate: DateTime.now(),
                        selectionColor: Color(0xff51c878),
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          setState(() {
                            _datePicker = date;
                            userDate = _datePicker.toString().split("-")[2] +
                                "-" +
                                _datePicker.toString().split("-")[1] +
                                "-" +
                                _datePicker.toString().split("-")[0];
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width / 1.10,
                  height: 325,
                  decoration: BoxDecoration(
                      color: Color(0xff51c878),
                      borderRadius: BorderRadius.circular(15)),
                  // child: Padding(
                  //   padding: EdgeInsets.all(8),
                  //   child: StreamBuilder(
                  //     stream: userReferences.snapshots(),
                  //     builder: (BuildContext context,
                  //         AsyncSnapshot<dynamic> snapshot) {
                  //       Map<String, dynamic> userData =
                  //           snapshot.data!.data() as Map<String, dynamic>;
                  //           return ListView.builder(
                  //             itemCount: slots.length,
                  //             itemBuilder: (context, index) {
                  //               if (userDate != userData["date"]) {

                  //               }
                  //             },
                  //           );
                  //       return Container();
                  //     },
                  //   ),

                  child: ListView.builder(
                      itemCount: slots.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(),
                            child: ListTile(
                              textColor: Colors.white,
                              title: Row(
                                children: [
                                  Text(slots[index]),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(price[index])
                                ],
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    _slotSelected = slots[index].toString();
                                    _priceSlot = price[index].toString();
                                    var date =
                                        _datePicker.toString().split(" ")[0];
                                    var name = _name.text.toString();
                                    var phoneNumber = "+91" +
                                        _secondaryPhoneNumber.text.toString();

                                    var _newdate = date.split("-")[2] +
                                        "-" +
                                        date.split("-")[1] +
                                        "-" +
                                        date.split("-")[0];
                                    if (_form.currentState!.validate()) {
                                      // print(FirebaseAuth
                                      //     .instance.currentUser!.uid);
                                      setState(() {
                                        BookName = name;
                                        Phone = phoneNumber;
                                        BookDate = _newdate;
                                        PriceSlot = _priceSlot;
                                        TimeSlot = _slotSelected;
                                      });

                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Confirm Booking"),
                                              content: Text(
                                                  "Do you wanna confirm your booking and head towards payment ?"),
                                              actions: [
                                                MaterialButton(
                                                  child: Text("Cancel"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                MaterialButton(
                                                    child: Text("Pay Now"),
                                                    onPressed: () async {
                                                      createOrder();
                                                      // print(successfull);
                                                      // print(
                                                      //     "Starting uploading");
                                                      print("Starting Payment");
                                                      print(successfull);
                                                      if (successfull == 0) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("Users")
                                                            .doc(FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid)
                                                            .collection(
                                                                "Bookings")
                                                            .add({
                                                          "customer_name": name,
                                                          "primary_phone_number":
                                                              _primaryPhoneNumber,
                                                          "secondary_phone_number":
                                                              phoneNumber,
                                                          "date": _newdate,
                                                          "time_slot":
                                                              _slotSelected,
                                                          "price_slot":
                                                              _priceSlot
                                                        }).then((val) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'slot_booked')
                                                              .add({
                                                            "customer_name":
                                                                name,
                                                            "primary_phone_number":
                                                                _primaryPhoneNumber,
                                                            "secondary_phone_number":
                                                                phoneNumber,
                                                            "date": _newdate,
                                                            "time_slot":
                                                                _slotSelected,
                                                            "price_slot":
                                                                _priceSlot
                                                          });
                                                        });
                                                      }
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          PalmBoxCricket()));
                                                    })
                                              ],
                                            );
                                          });

                                      // paymentDialog();
                                      // createOrder();
                                      // FirebaseFirestore.instance
                                      //     .collection("Users")
                                      //     .doc(FirebaseAuth
                                      //         .instance.currentUser!.uid)
                                      //     .collection("Bookings")
                                      //     .add({
                                      //   "customer_name": name,
                                      //   "primary_phone_number":
                                      //       _primaryPhoneNumber,
                                      //   "secondary_phone_number": phoneNumber,
                                      //   "date": _newdate,
                                      //   "time_slot": _slotSelected,
                                      //   "price_slot": _priceSlot
                                      // }).then((val) {
                                      //   FirebaseFirestore.instance
                                      //       .collection('slot_booked')
                                      //       .add({
                                      //     "customer_name": name,
                                      //     "primary_phone_number":
                                      //         _primaryPhoneNumber,
                                      //     "secondary_phone_number": phoneNumber,
                                      //     "date": _newdate,
                                      //     "time_slot": _slotSelected,
                                      //     "price_slot": _priceSlot
                                      //   });
                                      // });
                                    }
                                  },
                                  icon: Icon(Icons.add)),
                            ),
                          ),
                        );
                      }),
                  // ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            )),
      ),
    );
  }

  // Future<void> bookFinalTicketUser(
  //     {required String bookName,
  //     required String phone,
  //     required String BookedDate,
  //     required TimeSlot,
  //     required Price}) async {
  //   await FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection("Bookings")
  //       .add({
  //     "customer_name": bookName,
  //     "primary_phone_number": _primaryPhoneNumber,
  //     "secondary_phone_number": phone,
  //     "date": BookedDate,
  //     "time_slot": _slotSelected,
  //     "price_slot": _priceSlot
  //   }).then((val) {
  //     // bookFinalTicketUser(bookName: name,phone:_primaryPhoneNumber, BookedDate: _newdate, TimeSlot: _slotSelected,Price: _priceSlot);
  //     FirebaseFirestore.instance.collection('slot_booked').add({
  //       "customer_name": bookName,
  //       "primary_phone_number": _primaryPhoneNumber,
  //       "secondary_phone_number": phone,
  //       "date": BookedDate,
  //       "time_slot": _slotSelected,
  //       "price_slot": _priceSlot
  //     });
  //   });
  // }
}
