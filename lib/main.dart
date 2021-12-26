import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queuems/model/User.dart';
import 'package:queuems/providers/auth_provider.dart';
import 'package:queuems/providers/bookings_provider.dart';
import 'package:queuems/screens/book_appoinment.dart';
import 'package:queuems/screens/change_password.dart';
import 'package:queuems/screens/dashboard.dart';
import 'package:queuems/screens/forgot_password.dart';
import 'package:queuems/screens/homepage/home_screen.dart';
import 'package:queuems/screens/login/login_screen.dart';
import 'package:queuems/screens/password_changed.dart';
import 'package:queuems/screens/signup/signup_screen.dart';
import 'package:queuems/utility/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  String initialRt;

  // handle exceptions caused by making main async
  WidgetsFlutterBinding.ensureInitialized();

  // init a shared preferences variable
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // read user
  String? user = '';
  String initRoute = '';
  user = prefs.getString('User') ?? 'noUser';
  // print('user main .dart $user');
  if (user == 'noUser') {
    initRoute = '/';
  } else {
    AuthProvider().setUser = User.fromJson(jsonDecode(user));
    user = user;
    initRoute = 'dashboard';
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProvider(create: (_) => BookingProvider()),
    ],
    child: MyApp(
      user: user,
      initRoute: initRoute,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final user;
  final String initRoute;
  const MyApp({Key? key, required this.initRoute, required this.user})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // print('initRoute ${initRoute} user $user');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QueueMS',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            primaryColor: kprimaryLightColor,
            appBarTheme: const AppBarTheme(elevation: 0.0)),
        initialRoute: initRoute,
        routes: {
          '/': (context) => Homescreen(),
          'loginScreen': (context) => const Loginscreen(),
          'signUpScreen': (context) => const SignUpScreen(),
          'forgotPassword': (context) => ForgotPassword(),
          'changePassword': (context) => ChangePassword(),
          'passwordChanged': (context) => const PasswordChanged(),
          'dashboard': (context) => const Dashboard(),
          'bookAppoinment': (context) => const BookAppoinment(),
        });
  }
}
