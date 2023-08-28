import 'package:flutter/material.dart';

import 'package:flutter_flareup/start-Up/config/pallete.dart';
import 'package:flutter_flareup/start-Up/widgets/signin_textfield.dart';
import 'package:icons_flutter/icons_flutter.dart';

class BuisnessSigninScreen extends StatefulWidget {
  const BuisnessSigninScreen({super.key});
  static const String routeName = '/buisness-signin-screen';

  @override
  State<BuisnessSigninScreen> createState() => _BuisnessSigninScreenState();
}

class _BuisnessSigninScreenState extends State<BuisnessSigninScreen> {
  bool isMale = true;
  bool isSignUpScreen = true;
  bool isRememberMe = false;

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
                        child: const Column(
                          children: [
                            SigninTextField(
                                hintText: "Username",
                                keyboardType: TextInputType.name,
                                obscureText: false,
                                prefixIcon: Icons.person),
                            SizedBox(
                              height: 6,
                            ),
                            SigninTextField(
                                hintText: "Email",
                                keyboardType: TextInputType.emailAddress,
                                obscureText: false,
                                prefixIcon:
                                    MaterialCommunityIcons.email_outline),
                            SizedBox(
                              height: 6,
                            ),
                            SigninTextField(
                                hintText: "Password",
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                prefixIcon: MaterialCommunityIcons.lock),
                            SizedBox(
                              height: 6,
                            ),
                            SigninTextField(
                                hintText: "DOB(ddmmyyyy)",
                                keyboardType: TextInputType.datetime,
                                obscureText: false,
                                prefixIcon: Icons.calendar_month),
                            SizedBox(
                              height: 6,
                            ),
                            SigninTextField(
                              hintText: "Gender",
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              prefixIcon: Icons.people,
                            ),
                            SizedBox(height: 6),
                            SigninTextField(
                              hintText: "Marital Status",
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              prefixIcon: Icons.favorite,
                            ),
                            SizedBox(height: 6),
                            SigninTextField(
                              hintText: "Mobile Number",
                              keyboardType: TextInputType.phone,
                              obscureText: false,
                              prefixIcon: Icons.phone,
                            ),
                            SizedBox(height: 6),
                            SigninTextField(
                              hintText: "Alternate Mobile Number",
                              keyboardType: TextInputType.phone,
                              obscureText: false,
                              prefixIcon: Icons.phone,
                            ),
                            SizedBox(height: 6),
                            SigninTextField(
                              hintText: "Office Number",
                              keyboardType: TextInputType.phone,
                              obscureText: false,
                              prefixIcon: Icons.phone,
                            ),
                            SizedBox(height: 6),
                            SigninTextField(
                              hintText: "Founder/Cofounder Name",
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              prefixIcon: Icons.group,
                            ),
                            SizedBox(height: 6),
                            SigninTextField(
                              hintText: "Designation in Business",
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              prefixIcon: Icons.work,
                            ),
                            SizedBox(height: 6),
                            SigninTextField(
                              hintText: "Currently Employed",
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              prefixIcon: Icons.work_outline,
                            ),
                            SizedBox(height: 6),
                            SigninTextField(
                              hintText: "Home State",
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              prefixIcon: Icons.location_on,
                            ),
                          ],
                        ),
                      ),
                    if (!isSignUpScreen)
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            const SigninTextField(
                              hintText: "Email",
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              prefixIcon: MaterialCommunityIcons.email_outline,
                            ),
                            const SizedBox(height: 6),
                            const SigninTextField(
                              hintText: "Password",
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              prefixIcon: MaterialCommunityIcons.lock,
                            ),
                            const SizedBox(
                                height:
                                    12), // Add spacing between text fields and button
                            ElevatedButton(
                              onPressed: () {
                                // Perform submit actions
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                elevation: 5,
                                shadowColor: Colors.black,
                              ),
                              child: const Text(
                                "Submit",
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      221, 255, 153, 0), // Background color
                  elevation: 5, // Elevation
                  shadowColor: Colors.black, // Shadow color
                ),
                child: const Text(
                  "Submit",
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
