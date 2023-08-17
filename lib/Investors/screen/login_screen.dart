import 'package:flutter/material.dart';

import 'package:flutter_flareup/widgets/common/common_textfield.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/investor-login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 156, 209, 234),
              Colors.white
            ], // Set your gradient colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome\nBack',
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 33,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: _emailController, hintText: 'Email'),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomTextField(
                              controller: _passwordController,
                              hintText: 'Password'),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w500),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor:
                                    const Color.fromARGB(255, 64, 63, 68),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {},
                                style: const ButtonStyle(),
                                child: const Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff4c505b),
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
