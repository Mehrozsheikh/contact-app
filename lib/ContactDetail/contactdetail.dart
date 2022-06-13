import 'package:contact/database/contacts_db.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:contact/CallMaker/callmaker.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class ContactDetail extends StatefulWidget {
  String name = "";
  String phone = "";
  final int index;
  ContactDetail({
    Key? key,
    this.name = "",
    this.phone = "",
    required this.index,
  }) : super(key: key);

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff22303c),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contact Details'),
        backgroundColor: const Color(0xff15202b),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 58.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: SizedBox(
                    width: size.width * 0.9,
                    height: size.height * 0.57,
                    child: Card(
                      elevation: 3,
                      color: const Color(0xff192734),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 84.0),
                        child: Column(
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                fontSize: 35,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.phone,
                              style: const TextStyle(
                                fontSize: 23,
                                color: Colors.white54,
                              ),
                            ),
                            const Divider(
                              indent: 10,
                              endIndent: 20,
                              color: Colors.white24,
                            ),
                            const SizedBox(
                              height: 200,
                            ),
                            SizedBox(
                              child: SizedBox(
                                height: 55,
                                width: 142,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.green,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          30.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    callNumber(widget.phone);
                                  },
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Text(
                                          'Call',
                                          style: TextStyle(
                                            fontSize: 25,
                                          ),
                                        ),
                                        Icon(
                                          Icons.call,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.9,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 57,
                      backgroundColor: const Color(0xff8899A6),
                      child: Text(
                        widget.name[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 70,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
