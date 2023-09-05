import 'package:flutter/material.dart';
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

  void initState() {
    super.initState();
    _fetchInvestedBusinessData();
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
    print('profile page');
    print(response.body);

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
