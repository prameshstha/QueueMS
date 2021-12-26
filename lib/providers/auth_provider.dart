// ignore_for_file: unnecessary_getters_setters

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:queuems/model/User.dart';
import 'package:queuems/utility/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  User? _user;
  String _docUser = '';
  User? get getUser {
    return _user;
  }

  String get getDocUser {
    return _docUser;
  }

  set setUser(User? user) {
    // print('set user ${user!.token}');
    _user = user;
    // print('_user $_user');
    notifyListeners();
  }

  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get registeredStatus => _registeredStatus;

  set registeredStatus(Status value) {
    _registeredStatus = value;
  }

  Future<Map<String, dynamic>> register(
      String email, String password, String firstname, String lastname) async {
    final Map<String, dynamic> apiBodyData = {
      'email': email,
      'password': password,
      'first_name': firstname,
      'last_name': lastname,
    };
    var result;
    try {
      // print(password + email);
      var response = await http.post(Uri.parse(ApiUrl.register),
          body: json.encode(apiBodyData),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          });

      final Map<String, dynamic> responseData = json.decode(response.body);
      // print(response.statusCode);
      // print(responseData);
      if (response.statusCode == 200) {
        User authUser = User.fromJson(responseData);
        // print(1);
        _user = authUser;
        _loggedInStatus = Status.LoggedIn;
        // UserPreferences().saveUser(authUser);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('User', jsonEncode(responseData));
        // print('auth $authUser');
        // print('responsedata $responseData');
        notifyListeners();
        result = {
          'status': true,
          'message': 'Successfully registered',
          'data': responseData
        };
        return result;
      } else if (response.statusCode == 403) {
        // print('Status code: ${response.statusCode} error: ');
        result = {'status': false, 'data': responseData['email']};
        return result;
      }
    } catch (error) {
      print(error);
    }
    result = {
      'status': false,
      'message': 'Something went wrong',
      'data': 'error mate'
    };
    return result;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;
    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    _loggedInStatus = Status.Authenticating;

    notifyListeners();

    try {
      Response response = await http.post(Uri.parse(ApiUrl.login),
          body: json.encode(loginData),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          });
      // print(response.statusCode);
      //print(json.decode(response.body));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // print('responseData ${responseData}');
        // print(json.decode(responseData));
        User authUser = User.fromJson(responseData);
        // print('authUser $authUser');
        // UserPreferences().saveUser(authUser);
        final prefs = await SharedPreferences
            .getInstance(); // initializing sharedpreference
        prefs.setString(
            'User',
            jsonEncode(
                responseData)); //setting key = 'User' and value = jsonEncode(responseData)
        _user = authUser;
        // print('_user $_user');
        _loggedInStatus = Status.LoggedIn;

        notifyListeners();
        result = {
          'status': true,
          'message': 'Successful login',
          'user': authUser
        };
        return result;
      } else if (response.statusCode == 403) {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
        result = {'status': false, 'message': 'Email or password wrong'};
        return result;
      } else {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
        result = {'status': false, 'message': 'User doesnot exists'};
        return result;
      }
    } catch (error) {
      print(error);
      result = {'status': false, 'message': error};
      return result;
    }
  }

  Future<String> getDocList() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString("User");
    if (userJson != null) {
      _user = User.fromJson(jsonDecode(userJson));
      // print(_user!.token);
    }
    //The below code is giving _user null, don't know what is worng so using above code to get user
    // print('user list $_user');
    // var user = getUser;
    print('$_user user');
    try {
      Response response = await http.get(Uri.parse(ApiUrl.docList), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'token ${_user?.token}'
      });
      // print('status code doc list');
      // print(response.statusCode);
      // print(response.body); // this is in string => '[{"a": "b"},{"c": "d"}]'
      // print('response.body[psoo] ${response.body[0]}');
      List a = jsonDecode(response.body)
          as List; //decode to json format=> [{"a": "b"},{"c": "d"}]
      if (response.statusCode == 200) {
        // print('dddddddddddddddddddddd');
        // final List docList = json.decode(response.body);
        List<User> docList = a.map((m) => User.fromJson(m)).toList();

        // print('responseData doclist ${docList}');

        // final prefs = await SharedPreferences.getInstance();
        // prefs.setString('docList', User.encode(docList));
        // prefs.setStringList('docList', jsonDecode(docList.toString()));
        _docUser = response.body;
        notifyListeners();
        return _docUser;
        // print(json.decode(responseData));
        // User docUser = User.fromJson(responseData);
        // // UserPreferences().saveUser(authUser);
        // final prefs = await SharedPreferences.getInstance();
        // prefs.setString('DocUser', jsonEncode(docUser));
        // _docUser = docUser;
        // print('docuser $docUser');
      } else {
        print('else');
        return _docUser;
      }
    } catch (error) {
      print('error: $error');
      return _docUser;
    }
  }

  Future<String> changePassowrd(
      String password, String email, String token) async {
    final Map<String, dynamic> changePasswordData = {
      'password': password,
      'email': email,
    };
    // print(token);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'token $token'
    };
    var body = json.encode(changePasswordData);
    try {
      final response = await http.patch(
          Uri.parse(ApiUrl.changePassword + '$email/'),
          body: body,
          headers: headers);
      final responseData = jsonDecode(response.body);
      // print(response);
      // print(response.statusCode);
      // print(responseData);
      // print(response.reasonPhrase);
      if (response.statusCode != 200) {
        return response.statusCode.toString();
      }
      return response.statusCode.toString();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // read user
    String? us = prefs.getString('User');
    var gotuser = User.fromJson(jsonDecode(us!));
    // print('tok tok ${gotuser}');
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    try {
      final response =
          await http.post(Uri.parse(ApiUrl.logout), headers: headers);
      final responseData = jsonDecode(response.body);
      // print(response.statusCode);
      // print(responseData);
      if (response.statusCode != 200) {
        throw HttpException(responseData['message']);
      }
      print('logout');
      return clearData();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<bool> clearData() async {
    _user = null;
    // _docUser = null;
    _loggedInStatus = Status.NotLoggedIn;

    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  Future<String?> getPrefs(String key) async {
    SharedPreferences sprefs = await SharedPreferences.getInstance();
    String? user = sprefs.getString(key);

    return user;
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString("User");
    if (userJson != null) {
      _user = User.fromJson(jsonDecode(userJson));
      print(_user!.token);
      return true;
    }
    return false;
  }
}
