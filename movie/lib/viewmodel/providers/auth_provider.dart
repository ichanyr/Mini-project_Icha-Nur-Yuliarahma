// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';

// enum Status {
//   NotLoggedIn,
//   NotRegistered,
//   LoggedIn,
//   Registered,
//   Authenticating,
//   Registering,
//   LoggedOut,
// }

// class AuthProvider extends ChangeNotifier {
//   Status _loggedInStatus = Status.NotLoggedIn;
//   Status _registeredInStatus = Status.NotRegistered;

//   Status get loggedInStatus => _loggedInStatus;

//   set loggedInStatus(Status value) {
//     _loggedInStatus = value;
//     notifyListeners();
//   }

//   Status get registeredInStatus => _registeredInStatus;

//   set registeredInStatus(Status value) {
//     _registeredInStatus = value;
//   }

//   Future<Map<String, dynamic>> register(String email, String password) async {
//     final Map<String, dynamic> apiBodyData = {
//       'email': email,
//       'password': password,
//     };

//     try {
//       final dio = Dio();
//       final response = await dio.post(
//         AppUrl.register, // Ganti dengan URL endpoint API Anda
//         data: json.encode(apiBodyData),
//         options: Options(
//           contentType: Headers.jsonContentType,
//         ),
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = response.data;

//         print(responseData);

//         var userData = responseData['data'];

//         User authUser = User.fromJson(userData);

//         UserPreferences().saveUser(authUser);

//         return {
//           'status': true,
//           'message': 'Successfully registered',
//           'data': authUser,
//         };
//       } else {
//         return {
//           'status': false,
//           'message': 'Failed to register',
//           'data': response.data,
//         };
//       }
//     } catch (e) {
//       print('Error: $e');
//       return {
//         'status': false,
//         'message': 'Unsuccessful Request',
//         'data': e.toString(),
//       };
//     }
//   }

//   notify() {
//     notifyListeners();
//   }

//   Future<Map<String, dynamic>> login(String email, String password) async {
//     var result;

//     final Map<String, dynamic> loginData = {
//       'UserName': 'kaliakoirdeo379',
//       'Password': 'kaliakoirdeo379@2020',
//     };

//     _loggedInStatus = Status.Authenticating;
//     notifyListeners();

//     try {
//       final dio = Dio();
//       final response = await dio.post(
//         AppUrl.login, // Ganti dengan URL endpoint API Anda
//         data: json.encode(loginData),
//         options: Options(
//           contentType: Headers.jsonContentType,
//           headers: {
//             'Authorization': 'Basic ZGlzYXBpdXNlcjpkaXMjMTIz',
//             'X-ApiKey': 'ZGlzIzEyMw==',
//           },
//         ),
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = response.data;

//         print(responseData);

//         var userData = responseData['Content'];

//         User authUser = User.fromJson(userData);

//         UserPreferences().saveUser(authUser);

//         _loggedInStatus = Status.LoggedIn;
//         notifyListeners();

//         result = {
//           'status': true,
//           'message': 'Successful',
//           'user': authUser,
//         };
//       } else {
//         _loggedInStatus = Status.NotLoggedIn;
//         notifyListeners();
//         result = {
//           'status': false,
//           'message': response.data['error'],
//         };
//       }
//     } catch (e) {
//       print('Error: $e');
//       result = {
//         'status': false,
//         'message': 'Unsuccessful Request',
//         'data': e.toString(),
//       };
//     }

//     return result;
//   }
// }
