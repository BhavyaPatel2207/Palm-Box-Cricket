import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_box_cricket/colors/color_file.dart';
import 'package:my_box_cricket/screens/PalmBoxCricket.dart';
import 'package:my_box_cricket/screens/new_user_data.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  final String userPhoneNumber;
  const OtpScreen({Key? key, required this.userPhoneNumber}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _otpController = TextEditingController();
  String _verificationCode = "";

  bool isLoading = true;

  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _verifyCode();
  }

  _verifyCode() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString("phoneNum", widget.userPhoneNumber);
    await _auth.verifyPhoneNumber(
        phoneNumber: widget.userPhoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              print(value.user!.uid);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID!;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  Future checkDocument(String docID) async {
    final snapShot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(docID) // varuId in your case
        .get();

    if (snapShot == null || !snapShot.exists) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              newUserData(userPhone: widget.userPhoneNumber)));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => PalmBoxCricket()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Verify your mobile number ${widget.userPhoneNumber}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),textAlign: TextAlign.center,),
        SizedBox(
          height: 20,
        ),
        Pinput(
          controller: _otpController,
          showCursor: false,
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          onCompleted: (val) async {
            try {
              await FirebaseAuth.instance
                  .signInWithCredential(PhoneAuthProvider.credential(
                      verificationId: _verificationCode, smsCode: val))
                  .then((value) async {
                if (value.user != null) {
                  // print("Welcome to home ${value.user!.uid}");
                  checkDocument(value.user!.uid);
                }
              });
            } catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          },
          length: 6,
          defaultPinTheme: PinTheme(
              textStyle: TextStyle(color: Colors.white),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
              width: 60,
              height: 55),
          focusedPinTheme: PinTheme(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.circular(15))),
          submittedPinTheme: PinTheme(
              width: 60,
              height: 55,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15))),
        ),
      ],
    ));
  }
}
