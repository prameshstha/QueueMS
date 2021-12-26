import 'package:flutter/material.dart';
import 'package:queuems/components/background_login_signup.dart';
import 'package:queuems/components/or_divider.dart';
import 'package:queuems/components/social_icons.dart';
import 'package:queuems/utility/constant.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.2,
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
                  height: size.height * 0.5,
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
                          'Welcome to Queue MS',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        const Text(
                          'Queue is now easy, wait from anywhere',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ConstrainedBox(
                                constraints:
                                    const BoxConstraints.tightFor(height: 50),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, 'loginScreen');
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(fontSize: 18),
                                    ))),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            ConstrainedBox(
                                constraints:
                                    const BoxConstraints.tightFor(height: 50),
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, 'signUpScreen');
                                  },
                                  child: const Text('Sign Up',
                                      style: TextStyle(
                                          color: kprimaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  style: OutlinedButton.styleFrom(
                                    primary: Colors.white,
                                    side:
                                        const BorderSide(color: kprimaryColor),
                                  ),
                                )),
                          ],
                        ),
                        OrDivider(),
                        const Text(
                          'Connect using',
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
                // Container(
                //   width: size.width * 0.4,
                //   height: size.height * 0.06,
                //   margin: EdgeInsets.only(left: size.width * 0.5),
                //   child: TextButton(
                //     onPressed: () {
                //       Navigator.pushNamed(context, 'loginScreen');
                //     },
                //     child: Text(
                //       'Get Started',
                //       style: TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.grey.shade500),
                //     ),
                //     style: OutlinedButton.styleFrom(
                //       shape: BeveledRectangleBorder(
                //         borderRadius: BorderRadius.circular(3),
                //         side: BorderSide(color: Colors.grey.shade300),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
