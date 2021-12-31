import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queuems/components/select_date_widget.dart';
import 'package:queuems/model/User.dart';
import 'package:queuems/providers/auth_provider.dart';
import 'package:queuems/providers/bookings_provider.dart';
import 'package:queuems/utility/constant.dart';

class BookAppoinment extends StatefulWidget {
  const BookAppoinment({Key? key}) : super(key: key);

  @override
  _BookAppoinmentState createState() => _BookAppoinmentState();
}

var time_slot = [];
String datess = '';
User? selectedDoc;
var selected_time_slot = '--Select Time--';

class _BookAppoinmentState extends State<BookAppoinment> {
  var _docList = [];
  @override
  void initState() {
    super.initState();
    // var dlist = AuthProvider().getDocList().then((value) {
    //   print('dlist $value');

    //   // print(json.decode(value));
    // });
    Provider.of<AuthProvider>(context, listen: false).getDocList();

    var value = AuthProvider().getPrefs('docList').then((s) {
      print('ssssssssssss $s');
      // var aa = jsonDecode(s.toString());
      // print(aa);
      // final List<User> usesr = User.decode(s.toString());
      // var docList = User.encode(usesr);
      // print(usesr);
      // print(User.encode(usesr));
      // print('sdfasdfljakk');
    });
  }

  @override
  void dispose() {
    super.dispose();
    datess = '';
// User? selectedDoc;
    selected_time_slot = '--Select Time--';
    print('disposee');
  }

  @override
  Widget build(BuildContext context) {
    var val = context.watch<AuthProvider>().getDocUser;
    print('docuerrr $val');
    if (val != '') {
      print('not null');
      var js = json.decode(val.toString());
      final List<User> usesr = User.decode(val.toString());
      print('jss ${usesr[0].email}');
      _docList = usesr;
      selectedDoc = _docList[0];
      // var u = User.encode(val);
    } else {
      print('null');
    }
    // _docList = val;
    Size size = MediaQuery.of(context).size;
    // var jsonen = User.decode(_docList);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
                            title: const Text(
                              'Book an appoinment here',
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          Center(
                            child: Column(
                              children: [
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

                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          //white container start
                          BookBody(docList: _docList),
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
}

class BookBody extends StatefulWidget {
  var docList;

  BookBody({
    Key? key,
    required this.docList,
  }) : super(key: key);

  @override
  State<BookBody> createState() => _BookBodyState();
}

class _BookBodyState extends State<BookBody> {
  @override
  Widget build(BuildContext context) {
    List docList = widget.docList;
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.65,
        width: size.width * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //container for dateselect start
              Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          'Select Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SelectDateWidget(
                            dateSelect: _dateSelect, datess: datess),
                      ],
                    ),
                  ),
                  height: 90,
                  width: double.infinity,
                  decoration: _buildBoxDecoration()),
              //container for dateselect end

              Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 110,
                  width: double.infinity,
                  decoration: _buildBoxDecoration(),
                  child: Column(
                    children: [
                      const Text(
                        'Select available doc',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      //dropdown item for docs starts
                      DropdownButton<User>(
                          value: selectedDoc,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 42,
                          underline: const SizedBox(),
                          onChanged: (newValue) {
                            if (datess != '') {
                              // print(datess);

                              void _timeSlot() async {
                                var time1 = await bookingProvider
                                    .getAvailableTime(datess, newValue!.id);
                                print(time1);
                                print(newValue.id);
                                setState(() {
                                  selectedDoc = newValue;
                                  // print(newValue!.email);
                                  // print(
                                  // newValue.firstname);
                                  time_slot =
                                      time1 != '' ? json.decode(time1) : [];
                                });
                              }

                              _timeSlot();
                            } else {
                              setState(() {
                                selectedDoc = newValue;
                              });
                            }
                          },
                          items: (docList).map<DropdownMenuItem<User>>((value) {
                            return DropdownMenuItem<User>(
                              value: value,
                              child: Text(User.toJson(value)['first_name']
                                      .toString() +
                                  ' ' +
                                  User.toJson(value)['last_name'].toString()),
                            );
                          }).toList()),

                      //dropdown item for docs ends
                    ],
                  )),
              //container for doc select end
              //container for time select start
              Container(
                  padding: const EdgeInsets.all(8.0),
                  height: size.height * 0.2,
                  width: double.infinity,
                  decoration: _buildBoxDecoration(),
                  child: Column(
                    children: [
                      const Text(
                        'Select available time slot',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      DropdownButton(
                          value: selected_time_slot,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 42,
                          onChanged: (newValue) {
                            setState(() {
                              selected_time_slot = newValue.toString();
                            });
                          },
                          items: (time_slot)
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()),
                      ElevatedButton(
                          onPressed: () {
                            if (datess != '' &&
                                // ignore: unrelated_type_equality_checks
                                selectedDoc!.firstname != '--Select -' &&
                                selected_time_slot != '--Select Time--') {
                              print('yes');
                              //booking function call from here
                              bookingProvider
                                  .bookAppionment(selected_time_slot,
                                      selectedDoc!.id, datess)
                                  .then((booked) {
                                print(booked);
                                if (booked == 'success') {
                                  //clear this variable to set initial value

                                  Navigator.pushNamed(context, 'dashboard');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              (jsonDecode(booked))['error'])));
                                }
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Please select all of the above fields.')));
                            }
                          },
                          child: const Text('Book Now'))
                    ],
                  )),
              //container for time select end
            ],
          ),
        ));
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

  var bookingProvider = BookingProvider();
  String time = '';
  void _dateSelect(String date) async {
    // get available time after date is selected
    // print('selectedDoc ${selectedDoc!.firstname}');
    if (selectedDoc!.firstname != '--Select -') {
      time = await bookingProvider.getAvailableTime(date, selectedDoc!.id);
      // print(time);
    }
    setState(() {
      datess = date;
      // print(time);
      time_slot = time != '' ? json.decode(time) : [];
    });
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
