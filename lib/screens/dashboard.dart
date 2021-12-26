import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queuems/components/background_login_signup.dart';
import 'package:queuems/components/or_divider.dart';
import 'package:queuems/model/User.dart';
import 'package:queuems/providers/auth_provider.dart';
import 'package:queuems/providers/bookings_provider.dart';
import 'package:queuems/screens/homepage/home_screen.dart';
import 'package:queuems/screens/login/login_screen.dart';
import 'package:queuems/utility/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var _user = {};
  var patientBookingDetails;
  @override
  void initState() {
    super.initState();
    // BookingDetails();
    Provider.of<BookingProvider>(context, listen: false).getAllBookingDetails();
    Provider.of<BookingProvider>(context, listen: false)
        .getQueueNumberOfPatient();
    final sp = AuthProvider().getPrefs('User').then((value) {
      // print(value);
      // print(jsonDecode(value!));
      setState(() {
        _user = jsonDecode(value!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var ab = context.watch<BookingProvider>().getPatientBookingDetails;
    // print('objectt ab ${ab}');
    patientBookingDetails = ab != '' ? jsonDecode(ab) : '';
    // print('patientBookingDetails ${patientBookingDetails.length}');
    // print('ab ${patientBookingDetails[0]['booking_status']}');
    var no_of_booking =
        patientBookingDetails != null ? patientBookingDetails.length : 0;
    var booking_status =
        no_of_booking != 0 ? patientBookingDetails[0]['booking_status'] : '';
    // print(jsonDecode(ab).length);
    var queue = context.watch<BookingProvider>().getQueueNum;
    print('queue $queue');
    Size size = MediaQuery.of(context).size;
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    User? authUser = authProvider.getUser;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: kprimaryColor),
              currentAccountPicture: Image.asset('assets/images/user.jpg'),
              accountName: Text(
                _user['first_name'] != null
                    ? _user['first_name'].toString().toUpperCase()
                    : '',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                  _user['email'] != null ? _user['email'].toString() : '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ),
            ListTile(
              title: const Text('History'),
              subtitle: Text(''),
              leading: const Icon(Icons.confirmation_num_outlined),
              onTap: () {},
            ),
            ListTile(
              title: const Text('My Profile'),
              subtitle: Text(''),
              leading: Icon(Icons.manage_accounts),
              onTap: () {},
            ),
            ListTile(
              title: Text('Change Password'),
              leading: Icon(Icons.lock_outline),
              onTap: () {
                Navigator.pushNamed(context, 'changePassword');
              },
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout_outlined),
              onTap: () {
                var a = authProvider.logout().then((value) {
                  // print(value);
                  if (value) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => Homescreen()),
                        (route) => false);
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Container(
                  height: size.height,
                  width: double.infinity,
                  child: Stack(children: [
                    Container(
                      height: size.height * 0.30,
                      decoration: const BoxDecoration(
                          color: kprimaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                    ),
                    Center(
                      child: Column(
                        children: [
                          AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            title: Text(
                              'Welcome ${_user['first_name'] != null ? _user['first_name'].toString().toUpperCase() : ''}',
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          Center(
                            child: Column(
                              children: const [
                                Text(
                                  'No live token yet',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'No live token yet',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          //white container start
                          SizedBox(
                            height: size.height * 0.1,
                          ),
                          no_of_booking != 0 &&
                                  booking_status != 'Canceled' &&
                                  booking_status != 'Completed'
                              ? Container(
                                  //if there is booking
                                  height: size.height * 0.65,
                                  width: size.width * 0.85,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // BuildContainer(
                                        //   color: Colors.white,
                                        //   text: 'you have no tokens',
                                        // ),

                                        Container(
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                    child: Text(
                                                        'You have $no_of_booking booking. Please checkin to get queue token'),
                                                  ),
                                                  const Expanded(
                                                      child: Divider(
                                                    color: Color(0xffd9d9d9),
                                                    height: 2,
                                                  )),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      // ignore: unrelated_type_equality_checks

                                                      TextButton(
                                                          onPressed:
                                                              booking_status !=
                                                                      'CheckedIn'
                                                                  ? () {
                                                                      //check in code here
                                                                      BookingProvider()
                                                                          .checkIn()
                                                                          .then(
                                                                              (result) {
                                                                        print(
                                                                            'result $result');
                                                                        Provider.of<BookingProvider>(context,
                                                                                listen: false)
                                                                            .getAllBookingDetails();
                                                                      });
                                                                    }
                                                                  : () {
                                                                      print(
                                                                          'already checked in');
                                                                    },
                                                          child: Text(
                                                              booking_status ==
                                                                      'CheckedIn'
                                                                  ? 'Checked In'
                                                                  : 'Check In')),
                                                      TextButton(
                                                          onPressed: () {},
                                                          child: const Text(
                                                              'Edit')),
                                                      TextButton(
                                                          onPressed: () {},
                                                          child: const Text(
                                                              'Cancel'))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            height: 110,
                                            width: double.infinity,
                                            decoration: _buildBoxDecoration()),
                                        Container(
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                        'You have ${booking_status == 'CheckedIn' ? 1 : 0} tokens on Waiting'),
                                                    const Expanded(
                                                        child: Divider(
                                                      color: Color(0xffd9d9d9),
                                                      height: 2,
                                                    )),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            'Your queue number is '),
                                                        Text(
                                                          ' $queue.',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )),
                                            height: 80,
                                            width: double.infinity,
                                            decoration: _buildBoxDecoration()),

                                        booking_status == 'CheckedIn'
                                            ? ClipPath(
                                                clipper: DolDurmaClipper(
                                                    bottom: 80, holeRadius: 30),
                                                child: Container(
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          RichText(
                                                              text: TextSpan(
                                                                  text:
                                                                      'Your token is ',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                  children: [
                                                                TextSpan(
                                                                    text:
                                                                        ' ${patientBookingDetails[0]['qr_code']}',
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold))
                                                              ])),
                                                          Container(
                                                            height: 160,
                                                            width: 160,
                                                            child: Image.network(
                                                                '${patientBookingDetails[0]['qr_code_image']}'),
                                                          )
                                                        ],
                                                      )),
                                                  height: size.height * 0.25,
                                                  width: double.infinity,
                                                  decoration:
                                                      _buildBoxDecoration(),
                                                ),
                                              )
                                            : Container(
                                                height: 180,
                                                width: 180,
                                                child: Center(),
                                              ),
                                      ],
                                    ),
                                  ))
                              //if there is no bookings so this container if not show container on line 185
                              : Container(
                                  height: size.height * 0.20,
                                  width: size.width * 0.85,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        child: Text('You have no bookings. '
                                            'Book appionment?'),
                                      ),
                                      const Expanded(
                                          child: Divider(
                                        color: Color(0xffd9d9d9),
                                        height: 2,
                                      )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // ignore: unrelated_type_equality_checks

                                          TextButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, 'bookAppoinment');
                                              },
                                              child: const Text('Book')),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                          //white container end
                        ],
                      ),
                    ),
                  ])),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.15),
          spreadRadius: 3,
          blurRadius: 5,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }
}

class DolDurmaClipper extends CustomClipper<Path> {
  final double holeRadius;
  final double bottom;

  DolDurmaClipper({required this.holeRadius, required this.bottom});

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0.0, size.height - bottom - holeRadius)
      ..arcToPoint(
        Offset(0, size.height - bottom),
        clockwise: true,
        radius: Radius.circular(1),
      )
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height - bottom)
      ..arcToPoint(
        Offset(size.width, size.height - bottom - holeRadius),
        clockwise: true,
        radius: Radius.circular(1),
      );

    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(DolDurmaClipper oldClipper) => true;
}
