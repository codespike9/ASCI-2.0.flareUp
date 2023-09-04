import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YourInvestmentPage extends StatefulWidget {
  const YourInvestmentPage({super.key});
  static const String routeName = '/investor-your_investment-page';

  @override
  State<YourInvestmentPage> createState() => _YourInvestmentPageState();
}

class _YourInvestmentPageState extends State<YourInvestmentPage> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Image.network(
                  "https://images.pexels.com/photos/351264/pexels-photo-351264.jpeg?auto=compress&cs=tinysrgb&w=600",
                  height: h / 3,
                ),
                const Positioned(
                  bottom: -40,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://www.w3schools.com/howto/img_avatar.png"),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Column(
                children: [
                  const Text(
                    "Name : Dharmaraj",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Your Investments",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
