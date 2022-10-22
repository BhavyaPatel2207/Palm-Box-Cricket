import 'dart:convert';

import 'package:carousel_images/carousel_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_box_cricket/colors/color_file.dart';
import 'package:my_box_cricket/score/scoring.dart';
import 'package:my_box_cricket/screens/bookNow.dart';
import 'package:my_box_cricket/screens/bookedTicket.dart';
import 'package:http/http.dart' as http;

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<String> _images = [
    "assets/images/slide1.jpg",
    "assets/images/slide2.jpg",
    "assets/images/slide3.jpg",
    "assets/images/slide4.jpg",
    "assets/images/slide5.jpg",
  ];

  List<Score> match = [];
  Future<List<Score>> getRequest() async {
    var url = Uri.parse(
        "https://api.cricapi.com/v1/currentMatches?apikey=e29df08a-1751-4600-9eb7-420de40c661f&offset=0");
    final response = await http.get(url);

    var responseData = json.decode(response.body)["data"];

    // fetchIndex(String inningName, List teamInfo) {
    //   if (inningName == teamInfo[0]["name"].toString().split(" ")[0]) {
    //     print("0");
    //     return 0;
    //   } else if (inningName == teamInfo[1]["name"].toString().split(" ")[0]) {
    //     print("1");
    //     return 1;
    //   }
    // }

    int getIndex(String inningsName, List teamInfo, List Score) {
      int index = 0;
      // var teamName;
      for (var team in teamInfo) {
        if (team["name"].toString().split(" ")[0] == inningsName) {
          return index;
        } else if (team["name"].toString().split(" ")[0] != inningsName) {
          index++;
        }
      }
      // print("teamName");
      // print(teamName);
      // print("Innings");
      // print(inningsName);
      // print(index);
      return 0;
    }

    // Future<int> getIndex(String Inning,List TeamInfo) {
    //   int index = 0;
    //   for(var matchInfo in TeamInfo){

    //   }
    // }

    for (var matches in responseData) {
      if (matches == null && matches["score"].length == 1) {
        matches++;
      }
      Score matchScore = Score(
        oversA: matches["score"].length == 0
            ? 0
            : (matches["score"].length >= 1
                ? matches["score"][0
                    // matches["score"].length == 1 ? (matches["score"][0]["inning"].toString().split(" ")[0] == matches["teamInfo"][0]["name"].toString().split(" ")[0] ? 1 : 0) : 1
                    ]["o"]
                : 0),
        oversB: matches["score"].length == 0
            ? 0
            : (matches["score"].length == 2
                ? matches["score"][getIndex(
                    matches["score"][1]["inning"].toString().split(" ")[0],
                    matches["teamInfo"],
                    matches["score"])]["o"]
                : 0),
        scoreA: matches["score"].length == 0
            ? 0
            : (matches["score"].length >= 1
                ? matches["score"][0
                    // matches["score"].length == 1 ? (matches["score"][0]["inning"].toString().split(" ")[0] == matches["teamInfo"][0]["name"].toString().split(" ")[0] ? 1 : 0) : 1
                    ]["r"]
                : 0),

        scoreB: matches["score"].length == 0
            ? 0
            : (matches["score"].length == 2
                ? matches["score"][getIndex(
                    matches["score"][1]["inning"].toString().split(" ")[0],
                    matches["teamInfo"],
                    matches["score"])]["r"]
                : 0),
        wicketA: matches["score"].length == 0
            ? 0
            : (matches["score"].length >= 1
                ? matches["score"][0
                    // matches["score"].length == 1 ? (matches["score"][0]["inning"].toString().split(" ")[0] == matches["teamInfo"][0]["name"].toString().split(" ")[0] ? 1 : 0) : 1
                    ]["w"]
                : 0),
        wicketB: matches["score"].length == 0
            ? 0
            : (matches["score"].length == 2
                ? matches["score"][getIndex(
                    matches["score"][1]["inning"].toString().split(" ")[0],
                    matches["teamInfo"],
                    matches["score"])]["w"]
                : 0),
        teamAFlag: matches["teamInfo"].length >= 1
            ? matches["teamInfo"][0]["img"]
            : "https://images.unsplash.com/photo-1593341646782-e0b495cff86d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
        teamBFlag: matches["teamInfo"].length == 2
            ? matches["teamInfo"][1]["img"]
            : "https://images.unsplash.com/photo-1593341646782-e0b495cff86d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
        // shortA: matches["teamInfo"][0].length > 2
        //     ? matches["teamInfo"][matches["score"].length >= 1 ? (matches["score"][] )   ]["shortname"]
        //     : matches["teamInfo"][0]["name"]
        //         .toString()
        //         .split(" ")[0]
        //         .toUpperCase(),
        // shortB: matches["teamInfo"][1].length > 2
        //     ? matches["teamInfo"][1]["shortname"]
        //     : matches["teamInfo"][1]["name"]
        //         .toString()
        //         .split(" ")[0]
        //         .toUpperCase(),
        shortA: matches["teamInfo"][1]["shortname"],
        shortB: matches["teamInfo"][0]["shortname"],
        // shortA: matches["score"].length == 0 ? matches["teamInfo"][0]["shortname"] : (matches["score"].length == 1 ? (matches["score"][0]["inning"].toString().split(" ")[0] == matches["teamInfo"][0]["name"].toString().split(" ")[0] ? matches["teamInfo"][0]["shortname"] : matches["teamInfo"][1]["shortname"]): (matches["score"][0]["inning"].toString().split(" ")[0] == matches["teamInfo"][0]["name"].toString().split(" ")[0] ?  matches["teamInfo"][0]["shortname"] : matches["teamInfo"][1]["shortname"])),
        // shortB: matches["score"].length == 0 ? matches["teamInfo"][1]["shortname"] : (matches["score"].length == 1 ? (matches["score"][0]["inning"].toString().split(" ")[0] == matches["teamInfo"][0]["name"].toString().split(" ")[0] ? matches["teamInfo"][0]["shortname"] : matches["teamInfo"][1]["shortname"]): (matches["score"][0]["inning"].toString().split(" ")[0] == matches["teamInfo"][0]["name"].toString().split(" ")[0] ?  matches["teamInfo"][0]["shortname"] : matches["teamInfo"][1]["shortname"])),
        status: matches["status"],
        titleMatch: matches["name"],
        // scoreA: matches["score"].length == 0
        //     ? "No Data"
        //     : (matches["score"].length >= 1
        //         ? matches["score"][0]["r"]
        //         : "No Data"),
        // scoreB: matches["score"].length == 0
        //     ? "No Data"
        //     : (matches["score"].length != 1 ? matches["score"][1]["r"] : 0),
        // oversA: matches["score"].length == 0
        //     ? "No Data"
        //     : (matches["score"].length >= 1
        //         ? matches["score"][0]["o"]
        //         : "No Data"),
        // oversB: matches["score"].length == 0
        //     ? "No Data"
        //     : (matches["score"].length != 1 ? matches["score"][1]["o"] : 0),
        // wicketA: matches["score"].length == 0
        //     ? "No Data"
        //     : (matches["score"].length >= 1
        //         ? matches["score"][0]["w"]
        //         : "No Data"),
        // wicketB: matches["score"].length == 0
        //     ? "No Data"
        //     : (matches["score"].length != 1 ? matches["score"][1]["w"] : 0),
        // shortA: matches["score"].length == 0 ? "No data" : matches["teamInfo"][getIndex(matches["score"][0].toString().split(" ")[0], matches["teamInfo"], matches["score"])]["shortname"],
        // shortB: matches["score"].length == 0 ? "No data" : (matches["score"].length == 1 ? "No data" : matches["teamInfo"][getIndex(matches["score"][1].toString().split(" ")[0], matches["teamInfo"], matches["score"])]["shortname"]),
      );
      match.add(matchScore);
    }
    return match;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CarouselImages(
                listImages: _images,
                height: 300,
                verticalAlignment: Alignment.topCenter,
                borderRadius: 30,
                scaleFactor: 0.6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Divider(
                  height: 40,
                  thickness: 1.5,
                  color: Color.fromARGB(69, 154, 219, 187),
                ),
              ),
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: Center(
                    child: Text(
                      "Lorem ipsum dolor sit amet. Cum rerum dolores nam perferendis consectetur sit laudantium provident id necessitatibus quia et iusto velit id nostrum rerum aut harum unde. Sed ratione quidem ut laboriosam magni iure quisquam est Quis vitae est labore galisum. Et dignissimos praesentium aut veniam quos aut repellat Quis quo ratione sunt! In temporibus velit hic minima tenetur et ipsam optio sit velit minima",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                  onTap: () {
                    // FirebaseAuth.instance.signOut();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => bookNow()));
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => bookedTicket()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 40,
                    child: Center(
                        child: Text(
                      "Book Now",
                      style: TextStyle(color: Colors.white),
                    )),
                    decoration: BoxDecoration(
                      color: Color(0xff51c878),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 370,
                height: 194,
                child: FutureBuilder(
                  future: getRequest(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      );
                    } else {
                      int total_count = match.length;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: total_count,
                        itemBuilder: (context, index) {
                          if (!snapshot.data.toString().length.isNegative) {
                            return Card(
                              // margin: EdgeInsets.symmetric(
                              //     vertical: 7.5, horizontal: 15),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                    width: 350,
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot.data[index].titleMatch,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          softWrap: true,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors
                                                        .white
                                                        .withOpacity(0.5),
                                                    backgroundImage:
                                                        NetworkImage(snapshot
                                                            .data[index]
                                                            .teamAFlag),
                                                    radius: 22.5),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    snapshot.data[index].shortA
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "${snapshot.data[index].scoreA}-${snapshot.data[index].wicketA} (${snapshot.data[index].oversA})"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.white
                                                      .withOpacity(0.5),
                                                  backgroundImage: NetworkImage(
                                                      snapshot.data[index]
                                                          .teamBFlag),
                                                  radius: 22.5,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  snapshot.data[index].shortB,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "${snapshot.data[index].scoreB}-${snapshot.data[index].wicketB} (${snapshot.data[index].oversB})"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          snapshot.data[index].status,
                                          softWrap: true,
                                          maxLines: 2,
                                          style: TextStyle(color: Colors.grey),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    )),
                              ),
                            );
                            // return ListTile(
                            //     title: Text(snapshot.data[index].teamA),
                            //     subtitle: Text(snapshot.data[index].teamB),
                            //     contentPadding: EdgeInsets.only(bottom: 20.0)
                            //     );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
