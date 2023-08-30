import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

final authService = Provider<AuthService>((ref) => AuthService());

class AuthService {
  final String apiUrl = 'http://dharmarajjena.pythonanywhere.com/api/';

  Future<void> signUp(
      User user, Function onSignUpSuccess, Function onSignUpFailure) async {
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

  Future<void> signIn(String username, String password,
      Function onSignInSuccess, Function onSignInFailure) async {
    final headers = {
      'Access-Control-Allow-Credentials': 'true', 
    };

    final response = await http.post(
      Uri.parse('$apiUrl/loginAsCompanyManager/'),
      headers: headers,
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 201) {
      // Login successful
      print('Login Successful');
      onSignInSuccess();
    } else {
      // Handle login error
      print('Login Error: ${response.body}');
      onSignInFailure();
    }
  }
}
