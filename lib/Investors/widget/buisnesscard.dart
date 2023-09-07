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
            _buildImage(),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.business, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    'Company Name : ${business.companyName}',
                    style: GoogleFonts.phudu(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    Icons.monetization_on,
                    'Valuation: ${business.valuation}',
                    const Color.fromARGB(255, 116, 116, 116),
                  ),
                  _buildInfoRow(
                    Icons.people,
                    'Equity: ${business.equity}',
                    const Color.fromARGB(255, 3, 139, 73),
                  ),
                  _buildInfoRow(
                    Icons.category_outlined,
                    'Sub-Category: ${business.industryCategory}',
                    const Color.fromARGB(255, 0, 45, 244),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    String baseUrl =
        'http://dharmarajjena.pythonanywhere.com'; // Replace with your backend's base URL
    String imageUrl = business.image ?? '/media/cover_images/Alzeimers.jpg';
    // Use the business image URL if available, or the dummy image URL as a fallback

    String completeImageUrl = baseUrl + imageUrl;
    if (business.image != null) {
      return Image.network(
        completeImageUrl,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/images/dummyimage.jpg',
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }

  Widget _buildInfoRow(IconData icon, String text, Color textColor) {
    return Row(
      children: [
        Icon(icon, color: textColor),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
