import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

final authService = Provider<AuthService>((ref) => AuthService());

class AuthService {
  final String apiUrl = 'http://dharmarajjena.pythonanywhere.com/api/';

  Future<void> signUp(User user) async {
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
    
    /*if (response.statusCode == 200) {
      // Signup successful
      print('Signup Successful');
    } else {
      // Handle signup error
      print('Signup Error: ${response.body}');
    }*/
  }

  Future<void> signIn(String email, String password) async {
    // Simulate a login process
    await Future.delayed(const Duration(seconds: 2));
  }
}
