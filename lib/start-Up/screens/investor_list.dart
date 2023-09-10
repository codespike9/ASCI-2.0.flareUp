import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/investor_invested.dart';

class InvestedBuisnessList extends StatefulWidget {
  const InvestedBuisnessList({super.key, required this.id});
  final int id;

  @override
  State<InvestedBuisnessList> createState() => _InvestedBuisnessListState();
}

class _InvestedBuisnessListState extends State<InvestedBuisnessList> {
  List<InvestorInvested> investorinvestedList = [];

  @override
  void initState() {
    super.initState();
    fetchInvestorInvestedInfo();
  }

  Future<void> fetchInvestorInvestedInfo() async {
    final response = await http.get(Uri.parse(
        "https://dharmarajjena.pythonanywhere.com/api/investor_bank_info/${widget.id}"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final List<InvestorInvested> tempList = [];
      for (final item in jsonResponse) {
        tempList.add(InvestorInvested.fromJson(item));
      }
      setState(() {
        investorinvestedList = tempList;
      });
    } else {
      throw Exception('Failed to load investor invested data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 112, 147, 165),
                  Colors.white12,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 0, // You can adjust the left position as needed
            right: 0, // You can adjust the right position as needed
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0), // Add horizontal padding
              child: Container(
                color:
                    Colors.white, // Set the background color of the container
                padding: const EdgeInsets.all(16.0), // Add internal padding
                child: const Text(
                  'Invested Investor List',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 190,
            left: 15,
            right: 15,
            bottom: 0,
            child: Container(
              height: 300,
              width: 250,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 254, 255, 255),
                    Colors.white12,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: investorinvestedList.isEmpty
                  ? const Center(
                      child: Text(
                        "No one has invested yet",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: investorinvestedList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final investor =
                            investorinvestedList.reversed.toList()[index];
                        return Card(
                          elevation:
                              4.0, // Customize the elevation for the shadow effect
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: const Icon(
                                Icons.person), // Add an appropriate icon
                            title: Text(
                              'Name : ${investor.name}',
                              style: GoogleFonts.adamina(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email: ${investor.email}',
                                  style: subtitleTextStyle,
                                ),
                                Text(
                                  'Equity: ${investor.equity}%',
                                  style: subtitleTextStyle,
                                ),
                                Text(
                                  'IFSC: ${investor.ifscCode}',
                                  style: subtitleTextStyle,
                                ),
                                Text(
                                  'Account: ${investor.accountNumber}',
                                  style: subtitleTextStyle,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          Positioned(
            top: 125,
            left: 100,
            right: 100,
            child: GestureDetector(
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://www.kindpng.com/picc/m/497-4973038_profile-picture-circle-png-transparent-png.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle subtitleTextStyle = GoogleFonts.lato(
    fontSize: 15.0,
    fontWeight: FontWeight.w400,
  );
}
