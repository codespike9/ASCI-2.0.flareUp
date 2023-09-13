import 'package:flutter/material.dart';
import 'package:flutter_flareup/Investors/screen/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class BankDetailsScreen extends StatelessWidget {
  static const String routeName = '/investor-bank-screen';
  const BankDetailsScreen({super.key, required this.authToken});
  final String authToken;
  @override
  Widget build(BuildContext context) {
    final _Key = GlobalKey<FormState>();
    var _accountno = '';
    var _ifsc = '';

    void _saveInfo() async {
      if (_Key.currentState!.validate()) {
        _Key.currentState!.save();

        const apiUrl = 'http://dharmarajjena.pythonanywhere.com/api/bank_info/';

        final requestBody = {
          "IFSC_code": _ifsc,
          "ACC_no": _accountno,
        };

        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Authorization': 'Token $authToken',
          },
          body: requestBody,
        );

        if (response.statusCode == 201) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Registration successful! Login with same credentials'),
              duration: Duration(seconds: 3),
            ),
          );
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, LoginScreen.routeName);
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration failed try again'),
              duration: Duration(seconds: 2), // Adjust the duration as needed
            ),
          );

          print('Registration failed with status code: ${response.statusCode}');
        }
      }
    }

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(17),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(176, 144, 104, 232),
                Color.fromARGB(219, 255, 255, 255),
              ], // Set your gradient colors
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Form(
              key: _Key,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Bank Details',
                      style: GoogleFonts.workSans(
                          fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Account Number',
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                          // Border color when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 1.5),
                          borderRadius: BorderRadius.circular(
                              10.0), // Border color when enabled
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(
                              10.0), // Border color when error
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2.0), // Adjust the border width
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your bank account number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _accountno = value!;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'ifsc code',
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                          // Border color when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 1.5),
                          borderRadius: BorderRadius.circular(
                              10.0), // Border color when enabled
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(
                              10.0), // Border color when error
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2.0), // Adjust the border width
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.streetAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your ifsc code';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _ifsc = value!;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _saveInfo,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black, // Background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Rounded corners
                            ),
                          ),
                          child: const Text('Save',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
