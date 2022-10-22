import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:maps_launcher/maps_launcher.dart';

class reachUs extends StatefulWidget {
  const reachUs({Key? key}) : super(key: key);

  @override
  State<reachUs> createState() => _reachUsState();
}

class _reachUsState extends State<reachUs> {
  _callNumber() async {
    var number = "+919327625700";
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Card(
              elevation: 5,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "CONTACT US",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Office Number",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                          style: ButtonStyle(),
                          onPressed: _callNumber,
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Color(0xff51c878),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Call",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xff51c878)),
                              )
                            ],
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Ketan Patel     ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                          onPressed: _callNumber,
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Color(0xff51c878),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Call",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xff51c878)),
                              )
                            ],
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Vipul Patel     ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                          onPressed: _callNumber,
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Color(0xff51c878),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Call",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xff51c878)),
                              )
                            ],
                          ))
                    ],
                  ),
                ],
              )),
          SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              "assets/images/box_cricket_location.jpg"))),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20))),
                  child: Row(
                    children: [
                      // GestureDetector(
                      //   child: Container(
                      //     width: 174.545454545454535,
                      //     height: 50,
                      //     child: Center(
                      //       child: Text("Ahiya su lakhu ?"),
                      //     ),
                      //     decoration: BoxDecoration(
                      //         color: Colors.grey,
                      //         borderRadius: BorderRadius.only(
                      //             bottomLeft: Radius.circular(20))),
                      //   ),
                      //   onTap: () {
                      //     print(MediaQuery.of(context).size.width / 1.1);
                      //   },
                      // ),
                      GestureDetector(
                        child: Container(
                          width: 174.545454545454535 * 2,
                          height: 50,
                          child: Center(
                            child: Text(
                              "Show Direction",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20))),
                        ),
                        onTap: () => MapsLauncher.launchQuery(
                            'Palm Box Cricket, near sangini Swaraj, opp. Exiito, Jahangir Pura, pisad, Surat, Gujarat 395005'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )

          // Container(
          //   width: MediaQuery.of(context).size.width / 1.1,
          //   height: 400,
          //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          //   child: Column(children: [
          //     Image.asset("assets/images/box_cricket_location.jpg"),
          //     MaterialButton(
          //       height: 55,
          //       minWidth: 400,
          //       elevation: 0,
          //       color: Color.fromARGB(255, 241, 240, 240),
          //       child: Text("Show direction"),
          //       onPressed: () => MapsLauncher.launchQuery(
          //           'Palm Box Cricket, near sangini Swaraj, opp. Exiito, Jahangir Pura, pisad, Surat, Gujarat 395005'),
          //     )
          //   ]),
          // ),
          // Card(
          //     elevation: 5,
          // child: ElevatedButton(
          //   child: Text("Show direction"),
          //   onPressed: () => MapsLauncher.launchQuery(
          //       'Palm Box Cricket, near sangini Swaraj, opp. Exiito, Jahangir Pura, pisad, Surat, Gujarat 395005'),
          // ))
        ],
      ),
    ));
  }
}
