import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queuems/screens/dashboard.dart';
import 'package:queuems/screens/homepage/home_screen.dart';

import '../providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splash";

  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
    print('splash');
  }

  void _checkAuthentication() async {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    if (await provider.isLoggedIn()) {
      Navigator.of(context).pushReplacementNamed(Dashboard.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(Homescreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/user.jpg",
          width: 250,
        ),
      ),
    );
  }
}
