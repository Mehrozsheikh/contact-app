import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

callNumber(String phoneNumber) async {
  String number = phoneNumber;
  await FlutterPhoneDirectCaller.callNumber(number);
}
