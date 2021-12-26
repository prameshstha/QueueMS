import 'package:flutter/material.dart';
import 'package:queuems/components/background_login_signup.dart';
import 'package:queuems/utility/constant.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);
  final loginformKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
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
                          'Recover your password',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        const Text(
                          'Please enter your email address below to reset your password.',
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

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('Processing Data')));
                                      } else {
                                        print('not validate');
                                      }
                                    },
                                    child: const Text(
                                      'Recover Password',
                                      style: TextStyle(fontSize: 18),
                                    ))),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, 'loginScreen');
                                      },
                                      child: const Text('Sign In',
                                          style: TextStyle(
                                              color: kprimaryColor,
                                              fontWeight: FontWeight.bold))),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, 'signUpScreen');
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: kprimaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
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
