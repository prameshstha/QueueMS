// ignore_for_file: unnecessary_this, file_names

import 'dart:convert';

class User {
  late int id;
  late String email;
  late String firstname;
  late String lastName;
  late bool isActive;
  late bool isStaff;
  late bool isSuperuser;
  late String token;
  late int userphone;

  User(
      {required this.id,
      required this.email,
      required this.firstname,
      required this.lastName,
      required this.isActive,
      required this.isStaff,
      required this.isSuperuser,
      required this.token,
      required this.userphone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstname = json['first_name'];
    lastName = json['last_name'];
    isActive = json['is_active'];
    isStaff = json['is_staff'];
    isSuperuser = json['is_superuser'];
    token = json['token'];
    userphone = json['user_phone'];
  }

  static Map<String, dynamic> toJson(User user) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = user.id;
    data['email'] = user.email;
    data['first_name'] = user.firstname;
    data['last_name'] = user.lastName;
    data['is_active'] = user.isActive;
    data['is_staff'] = user.isStaff;
    data['is_superuser'] = user.isSuperuser;
    data['token'] = user.token;
    data['user_phone'] = user.userphone;
    return data;
  }

  static String encode(List<User> user) => json.encode(
        user.map<Map<String, dynamic>>((user) => User.toJson(user)).toList(),
      );

  static List<User> decode(String user) => (json.decode(user) as List<dynamic>)
      .map<User>((item) => User.fromJson(item))
      .toList();
}
