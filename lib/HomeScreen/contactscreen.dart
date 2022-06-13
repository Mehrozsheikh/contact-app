import 'package:contact/ContactDetail/contactdetail.dart';
import 'package:contact/boxes.dart';
import 'package:contact/database/contacts_db.dart';
import 'package:contact/models/ContactCard.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  void dispose() {
    Hive.close();
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  void addContacts(String name, String phone) {
    Box<Contacts> contactBox = Hive.box<Contacts>(HiveBoxes.contact);
    contactBox.add(Contacts(name: name, phone: phone));
  }

  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff22303c),
      appBar: AppBar(
        backgroundColor: const Color(0xff15202b),
        centerTitle: true,
        title: const Text(
          'Contacts',
          style: TextStyle(fontSize: 23),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: const Color(0xff22303c),
                    title: const Text('Enter Contact Details'),
                    content: SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        children: [
                          TextField(
                            controller: _name,
                            textInputAction: TextInputAction.go,
                            decoration: const InputDecoration(
                              label: Text("Enter Name"),
                            ),
                          ),
                          TextField(
                            controller: _phone,
                            textInputAction: TextInputAction.go,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text("Enter Phone"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      Center(
                        child: ElevatedButton(
                          child: const Text('Save'),
                          onPressed: () {
                            setState(() {
                              addContacts(_name.text, _phone.text);
                            });
                            _phone.text = "";
                            _name.text = "";
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
              child: const ListTile(
                leading: Icon(
                  Icons.person_add_alt_outlined,
                  color: Color.fromARGB(255, 33, 131, 211),
                ),
                title: Text(
                  'Add new Contact',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 33, 131, 211),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable:
                  Hive.box<Contacts>(HiveBoxes.contact).listenable(),
              builder: (context, Box<Contacts> box, _) {
                if (box.values.isEmpty) {
                  return const Center(
                    child: Text('No Contacts yet'),
                  );
                }
                return ListView.builder(
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    Contacts? res = box.getAt(index);
                    return InkWell(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: ContactCard(
                        name: res!.name,
                        phone: res.phone,
                        key: UniqueKey(),
                      ),
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            backgroundColor: const Color(0xff22303c),
                            title: const Text('Are You Sure?'),
                            actions: <Widget>[
                              Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Colors.green,
                                        ),
                                      ),
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Colors.red,
                                        ),
                                      ),
                                      child: const Text('Delete'),
                                      onPressed: () {
                                        setState(() {
                                          res.delete();
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactDetail(
                              name: res.name,
                              phone: res.phone,
                              index: index,
                              key: UniqueKey(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
