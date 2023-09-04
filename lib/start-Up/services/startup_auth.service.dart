import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_flareup/start-Up/screens/buisness_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

final authService = Provider<AuthService>((ref) => AuthService());

/*final startuptokenProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('Token') ?? '';
});*/

class AuthService {
  final String apiUrl = 'http://dharmarajjena.pythonanywhere.com/api/';

  Future<void> signUp(CompanyUser user, Function onSignUpSuccess,
      Function onSignUpFailure) async {
    final response = await http.post(
      Uri.parse('$apiUrl/register_as_company_manager/'),
      body: {
        'username': user.username,
        'email': user.email,
        'password': user.password,
        'name': user.name,
        'dob': user.dob,
        'age': user.age.toString(),
        'gender': user.gender,
        'mobile_number': user.phoneNo,
        'office_number': user.officeNo,
        'foco': user.foco,
        'designation': user.designation,
        'state': user.state,
        'city': user.city,
        'office_address': user.officeAddress,
        'office_pincode': user.officePincode.toString(),
        // Add more fields as needed
      },
    );

    if (response.statusCode == 201) {
      // Signup successful
      print('Signup Successful');
      onSignUpSuccess();
    } else {
      // Handle signup error
      print('Signup Error: ${response.body}');
      onSignUpFailure();
    }
  }

  Future<void> signIn(
    String username,
    String password,
    Function onSignInSuccess,
    Function onSignInFailure,
  ) async {
    final response = await http.post(
      Uri.parse('$apiUrl/loginAsCompanyManager/'),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 201) {
      //print('Login Successful');
      //print(response.body);
      final responseData = json.decode(response.body);
      final token = responseData['token'];
      //print(token);
      //await _saveToken(token);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('authToken', token);
      print("Login Successful, Token: $token");
      onSignInSuccess(token);
    } else {
      // Handle login error
      print('Login Error: ${response.body}');
      onSignInFailure();
    }
  }

  /*Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Token', token);
  }*/
}
