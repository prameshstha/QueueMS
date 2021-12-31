import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:queuems/components/background_login_signup.dart';
import 'package:queuems/providers/auth_provider.dart';
import 'package:queuems/utility/constant.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  final loginformKey = GlobalKey<FormState>();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Background(
            child: Column(
              children: [
                AppBar(
                  leading: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back)),
                  backgroundColor: Colors.transparent,
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/user.jpg',
                      fit: BoxFit.fill,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  height: 100,
                ),
                SizedBox(
                  height: size.height * 0.07,
                ),
                Container(
                  height: size.height * 0.50,
                  width: size.width * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        const Text(
                          'Create New password',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        const Text(
                          'Create new password and never share with anyone.',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Form(
                            key: loginformKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                //password textformfield start
                                Container(
                                  height: 70,
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: password1Controller,
                                    obscureText: true,
                                    validator: (value) => value!.isEmpty
                                        ? "Please enter your Password"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.lock),
                                      hintText: 'Password',
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          10,
                                          10,
                                          10,
                                          0), // control your hints text size(

                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                              color: kprimaryColor)),
                                    ),
                                  ),
                                ),
                                //password2 textform field end
                                //password textformfield start
                                Container(
                                  height: 70,
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: password2Controller,
                                    obscureText: true,
                                    validator: (value) => value!.isEmpty
                                        ? "Please enter your Password"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.lock),
                                      hintText: 'Password',
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          10,
                                          10,
                                          10,
                                          0), // control your hints text size(

                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                              color: kprimaryColor)),
                                    ),
                                  ),
                                ),
                                //password2 textform field end
                              ],
                            )),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ConstrainedBox(
                                constraints:
                                    const BoxConstraints.tightFor(height: 50),
                                child: ElevatedButton(
                                    onPressed: () {
                                      final loginKey =
                                          loginformKey.currentState;
                                      print(loginKey);
                                      if (loginKey!.validate()) {
                                        String password =
                                            password1Controller.text;
                                        AuthProvider().changePassowrd(password);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Enter you both passwords')));
                                      }
                                    },
                                    child: const Text(
                                      'Change Password',
                                      style: TextStyle(fontSize: 18),
                                    ))),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
