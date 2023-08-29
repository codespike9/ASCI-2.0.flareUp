import 'package:flutter/material.dart';

import 'package:flutter_flareup/start-Up/config/pallete.dart';
import 'package:flutter_flareup/start-Up/config/snackbar.dart';
import 'package:flutter_flareup/start-Up/models/user.dart';
import 'package:flutter_flareup/start-Up/screens/buisness_screen.dart';
import 'package:flutter_flareup/start-Up/services/startup_auth.service.dart';
import 'package:flutter_flareup/start-Up/widgets/signin_textfield.dart';
import 'package:flutter_flareup/start-Up/widgets/startup_snackbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_flutter/icons_flutter.dart';

class BuisnessSigninScreen extends ConsumerStatefulWidget {
  const BuisnessSigninScreen({super.key});
  static const String routeName = '/buisness-signin-screen';

  @override
  ConsumerState<BuisnessSigninScreen> createState() =>
      _BuisnessSigninScreenState();
}

class _BuisnessSigninScreenState extends ConsumerState<BuisnessSigninScreen> {
  bool isMale = true;
  bool isSignUpScreen = true;
  bool isRememberMe = false;

  void onSignUpSuccess() {
    setState(() {
      isSignUpScreen = true;
    });
    showSnackBar(
      context,
      'Signup successful. Login with the same credentials.',
      callback: () {
        setState(() {
          isSignUpScreen = false;
        });
      },
    );
  }

  void onSignUpFailure() {
    showSnackbar(context, 'Signup failed. Please try again.');
  }

  void onSignInFailure() {
    showSnackbar(context, 'Login failed. Please check your credentials.');
  }

  void onSignInSuccess() {
    Navigator.pushNamed(context, BuisnessScreen.routeName);
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phonenoController = TextEditingController();
  final TextEditingController _officenoController = TextEditingController();
  final TextEditingController _focoController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _statenameController = TextEditingController();
  final TextEditingController _citynameController = TextEditingController();
  final TextEditingController _officeaddController = TextEditingController();
  final TextEditingController _officepinController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _dobController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _phonenoController.dispose();
    _officenoController.dispose();
    _focoController.dispose();
    _designationController.dispose();
    _statenameController.dispose();
    _citynameController.dispose();
    _officeaddController.dispose();
    _officepinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/signin.jpg"),
                    fit: BoxFit.fill),
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 95, left: 20),
                color: const Color.fromARGB(149, 63, 123, 228),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: isSignUpScreen ? "Welcome to" : "Welcome",
                        style: const TextStyle(
                          letterSpacing: 2,
                          fontSize: 23,
                          color: Colors.amber,
                        ),
                        children: [
                          TextSpan(
                            text: isSignUpScreen ? " FlareUP" : " Back",
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      isSignUpScreen
                          ? "Signup to continue"
                          : "Login to continue",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            curve: Curves.bounceInOut,
            top: isSignUpScreen ? 220 : 280,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              curve: Curves.bounceInOut,
              padding: const EdgeInsets.all(20),
              height: isSignUpScreen ? 420 : 270,
              width: MediaQuery.of(context).size.width - 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 240, 240, 243),
                    Color.fromARGB(255, 224, 224, 232),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignUpScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignUpScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (!isSignUpScreen)
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color:
                                      const Color.fromARGB(255, 240, 143, 39),
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignUpScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Signup",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSignUpScreen
                                      ? Palette.activeColor
                                      : Palette.textColor1,
                                ),
                              ),
                              if (isSignUpScreen)
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color:
                                      const Color.fromARGB(255, 240, 143, 39),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (isSignUpScreen)
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            SigninTextField(
                              hintText: "Username",
                              keyboardType: TextInputType.name,
                              obscureText: false,
                              prefixIcon: Icons.person,
                              controller: _usernameController,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            SigninTextField(
                              hintText: "Email",
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              prefixIcon: MaterialCommunityIcons.email_outline,
                              controller: _emailController,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            SigninTextField(
                              hintText: "Password",
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              prefixIcon: MaterialCommunityIcons.lock,
                              controller: _passwordController,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            SigninTextField(
                                hintText: "Name",
                                keyboardType: TextInputType.name,
                                obscureText: false,
                                prefixIcon: Icons.person_2_sharp,
                                controller: _nameController),
                            const SizedBox(
                              height: 6,
                            ),
                            SigninTextField(
                              hintText: "DOB(ddmmyyyy)",
                              keyboardType: TextInputType.datetime,
                              obscureText: false,
                              prefixIcon: Icons.calendar_month,
                              controller: _dobController,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            SigninTextField(
                              hintText: "age",
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              prefixIcon: Icons.people,
                              controller: _ageController,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            SigninTextField(
                              hintText: "Gender",
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              prefixIcon: Icons.people,
                              controller: _genderController,
                            ),
                            const SizedBox(height: 6),
                            SigninTextField(
                              hintText: "Mobile Number",
                              keyboardType: TextInputType.phone,
                              obscureText: false,
                              prefixIcon: Icons.phone,
                              controller: _phonenoController,
                            ),
                            const SizedBox(height: 6),
                            SigninTextField(
                              hintText: "Office Number",
                              keyboardType: TextInputType.phone,
                              obscureText: false,
                              prefixIcon: Icons.phone,
                              controller: _officenoController,
                            ),
                            const SizedBox(height: 6),
                            SigninTextField(
                              hintText: "Founder/Cofounder Name",
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              prefixIcon: Icons.group,
                              controller: _focoController,
                            ),
                            const SizedBox(height: 6),
                            SigninTextField(
                              hintText: "Designation in Business",
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              prefixIcon: Icons.work,
                              controller: _designationController,
                            ),
                            const SizedBox(height: 6),
                            SigninTextField(
                              hintText: "State",
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              prefixIcon: Icons.location_on,
                              controller: _statenameController,
                            ),
                            const SizedBox(height: 6),
                            SigninTextField(
                                hintText: "City",
                                keyboardType: TextInputType.name,
                                obscureText: false,
                                prefixIcon: Icons.location_off_sharp,
                                controller: _citynameController),
                            const SizedBox(height: 6),
                            SigninTextField(
                                hintText: "office-addr",
                                keyboardType: TextInputType.streetAddress,
                                obscureText: false,
                                prefixIcon: Icons.location_off_sharp,
                                controller: _officeaddController),
                            const SizedBox(height: 6),
                            SigninTextField(
                                hintText: "office-pincode",
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                prefixIcon: Icons.location_off_sharp,
                                controller: _officepinController),
                          ],
                        ),
                      ),
                    if (!isSignUpScreen)
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            SigninTextField(
                              hintText: "Username",
                              keyboardType: TextInputType.name,
                              obscureText: false,
                              prefixIcon: Icons.person,
                              controller: _usernameController,
                            ),
                            const SizedBox(height: 6),
                            SigninTextField(
                              hintText: "Password",
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              prefixIcon: MaterialCommunityIcons.lock,
                              controller: _passwordController,
                            ),
                            const SizedBox(
                                height:
                                    12), // Add spacing between text fields and button
                            ElevatedButton(
                              onPressed: () async {
                                final authServiceInstance =
                                    ref.read(authService);
                                await authServiceInstance.signIn(
                                  _usernameController.text,
                                  _passwordController.text,
                                  onSignInSuccess,
                                  onSignInFailure,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                elevation: 5,
                                shadowColor: Colors.black,
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (isSignUpScreen)
            Positioned(
              top: MediaQuery.of(context).size.height - 80,
              right: 75,
              left: 75,
              child: ElevatedButton(
                onPressed: () async {
                  final user = User(
                    username: _usernameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                    name: _nameController.text,
                    dob: _dobController.text,
                    age: int.parse(_ageController.text),
                    gender: _genderController.text,
                    phoneNo: _phonenoController.text,
                    officeNo: _officenoController.text,
                    foco: _focoController.text,
                    designation: _designationController.text,
                    state: _statenameController.text,
                    city: _citynameController.text,
                    officeAddress: _officeaddController.text,
                    officePincode: int.parse(_officepinController.text),
                  );
                  final authServiceInstance = ref.read(authService);
                  await authServiceInstance.signUp(
                      user, onSignUpSuccess, onSignUpFailure);
                  // Call the signUp method
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      221, 255, 153, 0), // Background color
                  elevation: 5, // Elevation
                  shadowColor: Colors.black, // Shadow color
                ),
                child: const Text(
                  "SignUP",
                  style: TextStyle(
                      fontSize: 16, color: Colors.white), // Text color
                ),
              ),
            ),
        ],
      ),
    );
  }
}
