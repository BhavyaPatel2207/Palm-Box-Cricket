import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_box_cricket/colors/color_file.dart';

class bookedTicket extends StatefulWidget {
  const bookedTicket({Key? key}) : super(key: key);

  @override
  State<bookedTicket> createState() => _bookedTicketState();
}

class _bookedTicketState extends State<bookedTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Ticket Name"),
      ),
      body: SingleChildScrollView(),
    );
  }
}
