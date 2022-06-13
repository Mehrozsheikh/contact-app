class ContactModel {
  final String name;
  final String phone;

  ContactModel({
    required this.name,
    required this.phone,
  });

  ContactModel.fromMap(Map<String, dynamic> res)
      : name = res['name'],
        phone = res['phone'];

  Map<String, Object> toMap() {
    return {'name': name, 'phone': phone};
  }
}
