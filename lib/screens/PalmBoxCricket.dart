import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_box_cricket/screens/bookingsDone.dart';
import 'package:my_box_cricket/screens/homePage.dart';
import 'package:my_box_cricket/screens/profilePageAccount.dart';
import 'package:my_box_cricket/screens/reachUs.dart';

class PalmBoxCricket extends StatefulWidget {
  @override
  State<PalmBoxCricket> createState() => _PalmBoxCricket();
}

class _PalmBoxCricket extends State<PalmBoxCricket> {
  int _pageindex = 0;

  List _pages = [homePage(), bookingsDone(), reachUs(), profilePageAccount()];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    double barHeight;
    double barHeightWithNotch = 67;
    double arcHeightWithNotch = 67;

    if (size.height > 700) {
      barHeight = 70;
    } else {
      barHeight = size.height * 0.1;
    }

    if (viewPadding.bottom > 0) {
      barHeightWithNotch = (size.height * 0.07) + viewPadding.bottom;
      arcHeightWithNotch = (size.height * 0.075) + viewPadding.bottom;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Palm Box Cricket"),
          backgroundColor: Color(0xff51c878),
        ),
        body: _pages[_pageindex],
        bottomNavigationBar: CircleBottomNavigationBar(
          initialSelection: _pageindex,
          hasElevationShadows: true,
          inactiveIconColor: Colors.grey,
          barHeight: viewPadding.bottom > 0 ? barHeightWithNotch : barHeight,
          arcHeight: viewPadding.bottom > 0 ? arcHeightWithNotch : barHeight,
          itemTextOff: viewPadding.bottom > 0 ? 0 : 1,
          itemTextOn: viewPadding.bottom > 0 ? 0 : 0.5,
          blurShadowRadius: 50.0,
          tabs: [
            TabData(
                icon: Icons.home,
                title: "Home",
                iconSize: 25,
                fontSize: 12,
                fontWeight: FontWeight.bold),
            TabData(
                icon: Icons.book,
                title: "Bookings",
                iconSize: 25,
                fontSize: 12,
                fontWeight: FontWeight.bold),
            TabData(
                icon: Icons.map,
                title: "Reach Us",
                iconSize: 25,
                fontSize: 12,
                fontWeight: FontWeight.bold),
            TabData(
                icon: Icons.person,
                title: "Profile",
                iconSize: 25,
                fontSize: 12,
                fontWeight: FontWeight.bold)
          ],
          activeIconColor: Colors.white,
          circleColor: Color(0xff51c878),
          onTabChangedListener: (index) {
            setState(() {
              _pageindex = index;
            });
          },
        ));
  }
}
