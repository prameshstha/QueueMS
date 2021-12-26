import 'package:flutter/material.dart';
import 'package:queuems/components/background_login_signup.dart';
import 'package:queuems/utility/constant.dart';

class PasswordChanged extends StatelessWidget {
  const PasswordChanged({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
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
                  height: size.height * 0.40,
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
                          'Password Changed',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        const Text(
                          'Congratulations! Your password has been changed.',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/icons/tick.png',
                              fit: BoxFit.fill,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          height: 100,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'loginScreen');
                                },
                                child: const Text(
                                  'Back to Login',
                                  style: TextStyle(fontSize: 18),
                                ))
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
