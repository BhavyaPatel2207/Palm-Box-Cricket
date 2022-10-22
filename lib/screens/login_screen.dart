import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_box_cricket/colors/color_file.dart';
import 'package:my_box_cricket/screens/otp_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneNumber = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Container(),
              flex: 1,
            ),
            Image.asset(
              "assets/images/logo_remove_bg.png",
              width: double.infinity,
              height: 350,
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _phoneNumber,
                maxLength: 10,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    prefix: Text("+91"),
                    hintText: "Phone number",
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  var phoneNumber = "+91${_phoneNumber.text.toString()}";
                  // print(phoneNumber);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OtpScreen(userPhoneNumber: phoneNumber)));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 40,
                  child: Center(
                      child: const Text(
                    "Submit",
                    style: const TextStyle(color: Colors.white),
                  )),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
            Flexible(
              child: Container(),
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}
