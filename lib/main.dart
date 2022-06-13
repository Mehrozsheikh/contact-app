import 'package:contact/HomeScreen/contactscreen.dart';
import 'package:contact/boxes.dart';
import 'package:contact/database/contacts_db.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactsAdapter());
  await Hive.openBox<Contacts>(HiveBoxes.contact);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts',
      theme: ThemeData.dark(),
      home: const ContactScreen(title: 'Contacts'),
    );
  }
}
