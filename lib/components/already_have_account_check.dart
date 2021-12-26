import 'package:flutter/material.dart';
import 'package:queuems/utility/constant.dart';

class AlreadyHaveAccountCheck extends StatelessWidget {
  const AlreadyHaveAccountCheck({
    Key? key,
    required this.login,
  }) : super(key: key);

  final bool login;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            login ? 'New Here? ' : 'Got an Account? ',
            style: const TextStyle(color: kprimaryColor),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context, login ? 'signUpScreen' : 'loginScreen');
            },
            child: Text(
              login ? 'Register' : 'Sign In ',
              style: const TextStyle(
                  color: kprimaryColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
