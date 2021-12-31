import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:queuems/components/already_have_account_check.dart';
import 'package:queuems/components/background_login_signup.dart';
import 'package:queuems/components/or_divider.dart';
import 'package:queuems/components/social_icons.dart';
import 'package:queuems/providers/auth_provider.dart';
import 'package:queuems/screens/dashboard.dart';
import 'package:queuems/utility/constant.dart';

class LoginBody extends StatelessWidget {
  LoginBody({Key? key}) : super(key: key);
  final loginformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
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
                  height: size.height * 0.02,
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
                  height: size.height * 0.55,
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
                                //emaill textformfield start
                                Container(
                                  height: 70,
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: usernameController
                                      ..text = 'p@g.com',
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
                                    controller: passwordController
                                      ..text = 'pass',
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
                                        authProvider
                                            .login(email, password)
                                            .then((value) {
                                          print(value);
                                          if (value['status']) {
                                            // Wrap Navigator with SchedulerBinding to wait for rendering state before navigating
                                            // SchedulerBinding.instance?.addPostFrameCallback((_) {
                                            //   Navigator.of(context).pushReplacementNamed(Dashboard.routeName);
                                            // });
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushReplacementNamed(
                                                    Dashboard.routeName);

                                            // Navigator.pushNamed(
                                            //     context, 'dashboard');
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        value['message']
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
                                      'Login',
                                      style: TextStyle(fontSize: 18),
                                    ))),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const AlreadyHaveAccountCheck(login: true),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, 'forgotPassword');
                                  },
                                  child: const Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                        color: kprimaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        OrDivider(),
                        const Text(
                          'Login using',
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
