import 'package:flutter/material.dart';
import 'package:flutter_flareup/Investors/models/in_profile.dart';
import 'package:google_fonts/google_fonts.dart';

class InvestedBuisnessCard extends StatelessWidget {
  const InvestedBuisnessCard({super.key, required this.business});
  final InvestorProfile business;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        title: Text(
          business.investedCompanyName,
          style: titleTextStyle,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Equity : ${business.equityInvested}%',
              style: subtitleTextStyle,
            ),
            Text(
              'Amount : INR ${business.pricePaid.toString()}',
              style: subtitleTextStyle,
            ),
            Text(
              'payid : ${business.paymentid} ',
              style: subtitleTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle titleTextStyle = GoogleFonts.lato(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

TextStyle subtitleTextStyle = GoogleFonts.openSans(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: Colors.grey,
);
