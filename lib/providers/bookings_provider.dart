import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:queuems/model/User.dart';
import 'package:queuems/utility/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookingProvider extends ChangeNotifier {
  var _available_time;
  var _patientBookingDetails = '';
  User? _user;
  var _queue = 0;

  String get getPatientBookingDetails {
    // print('return $_patientBookingDetails');
    return _patientBookingDetails;
  }

  set setPatientBookingDetails(String bookingDetails) {
    print('set user $bookingDetails');
    _patientBookingDetails = bookingDetails;
    // print('_user $_user');
    notifyListeners();
  }

  // set setQueueNum(int queue_num) {
  //   _queue = queue_num;
  // }
  int get getQueueNum {
    print('return $_queue');
    return _queue;
  }

  Future<String> getAvailableTime(String date, int doc_id) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString("User");
    if (userJson != null) {
      _user = User.fromJson(jsonDecode(userJson));
    }
    // print(date);
    final Map<String, dynamic> apiBodyData = {
      'booking_date': date,
      'doc_id': doc_id
    };
    try {
      var response = await http.post(Uri.parse(ApiUrl.availableTime),
          body: jsonEncode(apiBodyData),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'token ${_user?.token}'
          });
      final String responseData = (response.body);
      // print(responseData);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        _available_time = responseData;
        return responseData;
      } else {
        return responseData;
      }
    } catch (error) {
      print(error);
      return error.toString();
    }
  }

  Future<String> bookAppionment(
    String time,
    int doc_id,
    String date,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString("User");
    if (userJson != null) {
      _user = User.fromJson(jsonDecode(userJson));
    }
    print(date);
    final Map<String, dynamic> apiBodyData = {
      'booking_status': 'Booked',
      'booking_time': time,
      'patient_id': _user!.id,
      'doc_id': doc_id,
      'booking_date': date,
    };
    try {
      // print('tokennnnnnnnnn ${_user?.token}');
      var response = await http.post(Uri.parse(ApiUrl.booking),
          body: jsonEncode(apiBodyData),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'token ${_user?.token}'
          });
      final String responseData = (response.body);
      // print(responseData);
      print(response.body);
      if (response.statusCode == 201) {
        _available_time = responseData;
        return 'success';
      } else {
        var error = (jsonDecode(response.body))['error'];

        return response.body;
      }
    } catch (error) {
      print(error);
      return error.toString();
    }
  }

//get all booking details of one patient
  Future<String> getAllBookingDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString("User");
    if (userJson != null) {
      _user = User.fromJson(jsonDecode(userJson));
    }

    try {
      print('tokennnnnnnnnn ${_user?.token}');
      var response = await http.get(
          Uri.parse(ApiUrl.UserBookingDetails + _user!.id.toString()),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'token ${_user?.token}'
          });
      final String responseData = (response.body);
      // print(responseData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        // setPatientBookingDetails(responseData);

        _patientBookingDetails = responseData;
        // print('_patientBookingDetails $_patientBookingDetails');
        notifyListeners();
        return responseData;
      } else {
        return 'failed getall booking';
      }
    } catch (error) {
      print(error);
      return error.toString();
    }
  }

//get queue number of patient
  Future<String> getQueueNumberOfPatient() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString("User");
    if (userJson != null) {
      _user = User.fromJson(jsonDecode(userJson));
    }

    try {
      // print(' ${_user?.token}');
      var response = await http.get(
          Uri.parse(ApiUrl.checkedInQueue + _user!.id.toString()),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'token ${_user?.token}'
          });
      final responseData = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        // setPatientBookingDetails(responseData);
        print(response.body);
        print(responseData);
        print(responseData[0]['queue_num']);
        _queue = responseData[0]['queue_num'];
        // print('_patientBookingDetails $_patientBookingDetails');
        notifyListeners();
        return response.body;
      } else {
        return 'failed queue';
      }
    } catch (error) {
      print(error);
      return error.toString();
    }
  }

//get one booking details
  Future<String> getBookingDetails(int booking_id) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString("User");
    if (userJson != null) {
      _user = User.fromJson(jsonDecode(userJson));
    }

    try {
      // print('tokennnnnnnnnn ${_user?.token}');
      var response = await http.get(
          Uri.parse(ApiUrl.bookingDetails + booking_id.toString()),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'token ${_user?.token}'
          });
      final String responseData = (response.body);
      // print(responseData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return responseData;
      } else {
        return 'failed';
      }
    } catch (error) {
      print(error);
      return error.toString();
    }
  }

//get one booking details
  Future<String> checkIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString("User");
    if (userJson != null) {
      _user = User.fromJson(jsonDecode(userJson));
    }

    try {
      // print('tokennnnnnnnnn ${_user?.token}');
      var response = await http.patch(
          Uri.parse(ApiUrl.checkIn + _user!.id.toString() + '/'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'token ${_user?.token}'
          });

      // print(responseData);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final String responseData = (jsonDecode(response.body));
        return responseData;
      } else {
        print(response.body);
        return 'failed';
      }
    } catch (error) {
      print(error);
      return error.toString();
    }
  }
}
