import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:queuems/components/already_have_account_check.dart';
import 'package:queuems/components/background_login_signup.dart';
import 'package:queuems/components/or_divider.dart';
import 'package:queuems/components/social_icons.dart';
import 'package:queuems/providers/auth_provider.dart';
import 'package:queuems/utility/constant.dart';

class SignUpBody extends StatelessWidget {
  SignUpBody({Key? key}) : super(key: key);
  final loginformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController firstnameController = TextEditingController();
    TextEditingController lastnameController = TextEditingController();

    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    return Background(
      child: Column(
        children: [
          AppBar(
            leading: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(Icons.arrow_back)),
            backgroundColor: Colors.transparent,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/user.jpg',
                      fit: BoxFit.fill,
                      width: 70,
                      height: 70,
                    ),
                  ),
                  height: 70,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  height: size.height * 0.7,
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
                        Form(
                            key: loginformKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
//firstname textformfield start
                                Container(
                                  height: 70,
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: firstnameController,
                                    validator: (value) => value!.isEmpty
                                        ? "Please enter your Firstname"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.email),
                                      hintText: 'Firstname',
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
                                //firstname textform field end
//lastname textformfield start
                                Container(
                                  height: 70,
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: lastnameController,
                                    validator: (value) => value!.isEmpty
                                        ? "Please enter your Lastname"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.email),
                                      hintText: 'Lastname',
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
                                //lastname textform field end
                                //emaill textformfield start
                                Container(
                                  height: 70,
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: usernameController,
                                    validator: (value) => value!.isEmpty
                                        ? "Please enter your Email"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.email),
                                      hintText: 'Email',
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
                                //email textform field end
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                //password textformfield start
                                SizedBox(
                                  height: 69,
                                  child: TextFormField(
                                    controller: passwordController,
                                    validator: (value) => value!.isEmpty
                                        ? "Please enter your Password"
                                        : null,
                                    obscureText: true,
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

                                //password textformfield end
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
                                        String email = usernameController.text;
                                        String password =
                                            passwordController.text;
                                        String firstname =
                                            firstnameController.text;
                                        String lastname =
                                            lastnameController.text;
                                        print('$email, $password');

                                        authProvider
                                            .register(email, password,
                                                firstname, lastname)
                                            .then((value) {
                                          print(value);
                                          if (value['status']) {
                                            Navigator.pushNamed(
                                                context, 'dashboard');
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(value['data']
                                                        .toString())));
                                          }
                                        });
                                      } else {
                                        print('not validate');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Something\'s wrong. Please try again!')));
                                      }
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(fontSize: 18),
                                    ))),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              children: const [
                                AlreadyHaveAccountCheck(login: false),
                                // Text(
                                //   'Forgot password?',
                                //   style: TextStyle(
                                //       color: kprimaryColor,
                                //       fontWeight: FontWeight.bold),
                                // ),
                              ],
                            )
                          ],
                        ),
                        OrDivider(),
                        const Text(
                          'Sign Up using',
                          style: TextStyle(color: kprimaryColor),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Row(
                          children: [
                            SocialIcon(
                                svgPic: 'assets/icons/facebook.svg',
                                press: () {}),
                            SocialIcon(
                                svgPic: 'assets/icons/google-plus.svg',
                                press: () {}),
                            SocialIcon(
                                svgPic: 'assets/icons/viber.svg', press: () {}),
                            SocialIcon(
                                svgPic: 'assets/icons/apple.svg', press: () {})
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
