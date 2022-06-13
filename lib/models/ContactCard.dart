import 'package:contact/CallMaker/callmaker.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

// ignore: must_be_immutable
class ContactCard extends StatelessWidget {
  String name = "";
  String phone = "";

  ContactCard({
    Key? key,
    this.name = "",
    this.phone = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3),
      child: SizedBox(
        height: size.height * 0.1,
        width: size.width,
        child: Card(
          elevation: 2,
          color: const Color(0xff192734),
          child: Center(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xff8899A6),
                radius: 25,
                child: Text(
                  name[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
              title: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  callNumber(phone);
                },
                icon: const Icon(
                  Icons.call,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
