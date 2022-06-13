import 'package:hive/hive.dart';
part 'contacts_db.g.dart';

@HiveType(typeId: 0)
class Contacts extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String phone;

  Contacts({
    required this.name,
    required this.phone,
  });
}
