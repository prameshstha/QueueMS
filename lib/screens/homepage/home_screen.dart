import 'package:flutter/material.dart';
import 'package:queuems/components/background_login_signup.dart';
import 'package:queuems/screens/homepage/body.dart';

class Homescreen extends StatelessWidget {
  static const routeName = "/homescreen";
  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Body());
  }
}
