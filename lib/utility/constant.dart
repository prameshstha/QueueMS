import 'package:flutter/cupertino.dart';

const Color kprimaryColor = Color(0xffba22bd);
const Color kprimaryDarkColor = Color(0xff651766);
const Color kprimaryLightColor = Color(0xffce95cf);

class ApiUrl {
  static const String baseUrl =
      'http://192.168.1.129:8000/'; //testing at home network
  // static const String baseUrl =
  // 'http://10.0.0.10:8000/'; //testing at office network
  static const String register = baseUrl + 'accounts/register/';
  static const String login = baseUrl + 'accounts/login/';
  static const String logout = baseUrl + 'accounts/logout/';
  static const String changePassword = baseUrl + 'accounts/user-edit-delete/';
  static const String userList = baseUrl + 'accounts/user-list/';
  static const String userEditUpdateDelete =
      baseUrl + 'accounts/user-edit-delete/';

  static const String docList = baseUrl + 'accounts/doc-list/';

  static const String availableTime = baseUrl + 'bookings/available-time/';
  static const String booking = baseUrl + 'bookings/list-create-booking/';
  static const String bookingDetails = baseUrl + 'bookings/booking-details/';
  static const String UserBookingDetails =
      baseUrl + 'bookings/user-booking-details/';
  static const String checkIn =
      baseUrl + 'bookings/check-in/'; //with booking id parameter
  static const String checkedInQueue =
      baseUrl + 'bookings/checked-in-queue/'; //with patient id parameter
}
