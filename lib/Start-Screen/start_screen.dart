import 'package:flutter/material.dart';
import 'package:flutter_flareup/Investors/screen/login_screen.dart';
import 'package:flutter_flareup/start-Up/screens/sign_in.dart';
import 'package:flutter_flareup/widgets/common/common_button.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 156, 209, 234), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'FlareUp',
                  style: GoogleFonts.pacifico(
                      color: const Color.fromARGB(185, 24, 76, 179),
                      fontSize: 55,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'assets/images/StartScreen.png',
                  width: 500,
                ),
                const SizedBox(
                  height: 50,
                ),
                Builder(builder: (context) {
                  return CustomButton(
                      text: 'Sign-In as Investor',
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      });
                }),
                const SizedBox(
                  height: 25,
                ),
                Builder(builder: (context) {
                  return CustomButton(
                    text: 'Sign-In as Start-Up',
                    onTap: () {
                      Navigator.pushNamed(
                          context, SigninStartupScreen.routeName);
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
