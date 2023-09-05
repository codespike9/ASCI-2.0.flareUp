import 'package:flutter/material.dart';
import 'package:flutter_flareup/Investors/screen/in_buisnessdetails.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/Investor_buisness.dart';

class BusinessCard extends StatelessWidget {
  final InvestorBusiness business;
  final String authToken;

  BusinessCard({required this.business, required this.authToken});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuisnessDetails(
              authToken: authToken,
              business: business,
            ),
          ),
        );
      },
      child: Card(
        elevation: 6.0,
        margin: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Image.asset(
                'assets/images/dummyimage.jpg'), // Replace with your local image path
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.business,
                      color: Colors.blue), // Replace with your desired icon
                  const SizedBox(width: 8), // Add spacing between icon and text
                  Text(
                    'Comapny Name : ${business.companyName}',
                    style: GoogleFonts.phudu(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.monetization_on,
                          color:
                              Colors.green), // Replace with your desired icon
                      const SizedBox(
                          width: 8), // Add spacing between icon and text
                      Text(
                        'Valuation: ${business.valuation}',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 116, 116, 116),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.people,
                          color: Colors.blue), // Replace with your desired icon
                      const SizedBox(
                          width: 8), // Add spacing between icon and text
                      Text(
                        'Equity: ${business.equity}',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 3, 139, 73),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.category_outlined,
                          color: Color.fromARGB(255, 108, 108,
                              108)), // Replace with your desired icon
                      const SizedBox(
                          width: 8), // Add spacing between icon and text
                      Text(
                        'Sub-Category: ${business.industryCategory}', // Replace with the actual sub-category field
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 0, 45, 244),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
