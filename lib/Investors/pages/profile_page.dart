import 'package:flutter/material.dart';
import 'package:flutter_flareup/Investors/models/in_bankdetails.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/in_profile.dart';
import '../widget/in_buisnesscard.dart';

class YourInvestmentPage extends StatefulWidget {
  const YourInvestmentPage({super.key, required this.authToken});
  final String authToken;

  static const String routeName = '/investor-your_investment-page';

  @override
  State<YourInvestmentPage> createState() => _YourInvestmentPageState();
}

class _YourInvestmentPageState extends State<YourInvestmentPage> {
  List<InvestorProfile> investedbusinessList = [];
  List<InvestorBankDetails> investorBankDetailsList = [];

  void initState() {
    super.initState();
    _fetchInvestedBusinessData();
    _fetchBankDetails();
  }

  Future<void> _fetchInvestedBusinessData() async {
    final authToken = widget.authToken;
    final response = await http.get(
      Uri.parse(
          'http://dharmarajjena.pythonanywhere.com/api/porfolio_details/'),
      headers: {
        'Authorization': 'Token $authToken',
      },
    );

    if (response.statusCode == 200) {
      print('Profile data fetch possible');
      final jsonData = json.decode(response.body);
      final List<dynamic> investorBusinessDataList = jsonData as List<dynamic>;

      setState(() {
        investedbusinessList = investorBusinessDataList.map((data) {
          return InvestorProfile.fromJson(data);
        }).toList();
        // Create a copy of the original list for resetting the filter
      });
    } else {
      print('Failed to fetch data ${response.statusCode}');
    }
  }

  Future<void> _fetchBankDetails() async {
    final authToken = widget.authToken;
    final response = await http.get(
      headers: {
        'Authorization': 'Token $authToken',
      },
      Uri.parse('http://dharmarajjena.pythonanywhere.com/api/bank_info/'),
    );
    print('Bank details');
    print(response.body);

    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      final investorBankDetails = InvestorBankDetails.fromJson(jsonData);

      setState(() {
        investorBankDetailsList = [investorBankDetails];
        // Create a copy of the original list for resetting the filter
      });
    } else {
      print('Failed to fetch data ${response.statusCode}');
    }
  }

  void _showBankDetailsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bank Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: investorBankDetailsList.isNotEmpty
                ? investorBankDetailsList.map((bankDetails) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'IFSC Code : ${bankDetails.ifsc}',
                          style: titleTextStyle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Account Number : ${bankDetails.accno}',
                          style: titleTextStyle,
                        ),
                      ],
                    );
                  }).toList()
                : [const Text('No Bank Details')],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String userName = investedbusinessList[0].userName;

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
                Positioned(
                  bottom: -40,
                  child: GestureDetector(
                    onTap: _showBankDetailsDialog,
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://www.w3schools.com/howto/img_avatar.png"),
                    ),
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
                  Text(
                    'Name : $userName',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
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
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: investedbusinessList.isEmpty
                  ? const Center(
                      child: Text('No Investment Done!'),
                    )
                  : ListView.builder(
                      itemCount: investedbusinessList.length,
                      itemBuilder: (context, index) {
                        final investedBuisness =
                            investedbusinessList.reversed.toList()[index];
                        return InvestedBuisnessCard(
                          business: investedBuisness,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle titleTextStyle = GoogleFonts.lato(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  color: Color.fromARGB(226, 43, 5, 236),
);
