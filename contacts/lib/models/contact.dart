// To parse this JSON data, do
//
//     final contact = contactFromJson(jsonString);

import 'dart:convert';

Contact contactFromJson(String str) => Contact.fromJson(json.decode(str));

String contactToJson(Contact data) => json.encode(data.toJson());

class Contact {
  static final String contactTable = "contactTable";
  static final String idColumn = "idColumn";
  static final String nameColumn = "nameColumn";
  static final String phoneColumn = "phoneColumn";
  static final String emailColumn = "emailColumn";
  static final String imageColumn = "imgColumn";

  Contact({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
  });

  int id;
  String name;
  String email;
  String phone;
  String image;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
      };

  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    image = map[imageColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imageColumn: image
    };
    if (id != null) map[idColumn] = id;

    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $image)";
  }
}
