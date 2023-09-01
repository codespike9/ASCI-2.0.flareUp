import 'package:flutter/material.dart';
import 'package:flutter_flareup/Investors/models/Investor_buisness.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widget/buisnesscard.dart';

class BuisnessList extends StatefulWidget {
  const BuisnessList({super.key, required this.authToken});
  static const String routeName = '/investor-buisness-list';
  final String authToken;

  @override
  State<BuisnessList> createState() => _BuisnessListState();
}

class _BuisnessListState extends State<BuisnessList> {
  List<InvestorBusiness> businessList = [];
  RangeValues valuationRange = RangeValues(0, 100);

  @override
  void initState() {
    super.initState();

    _fetchBusinessData();
  }

  Future<void> _fetchBusinessData() async {
    final authToken = widget.authToken;
    final response = await http.get(
      Uri.parse('http://dharmarajjena.pythonanywhere.com/api/companyList/'),
      headers: {
        'Authorization': 'Token $authToken', // Use the authToken here
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> businessDataList = jsonData as List<dynamic>;

      setState(() {
        businessList = businessDataList.map((data) {
          return InvestorBusiness.fromJson(data);
        }).toList();
      });
    } else {
      print('Failed to fetch data');
    }
  }

   void filterBusinessesByValuation() {
    setState(() {
      // Apply the valuation filter
      businessList = businessList.where((business) {
        final valuation = double.parse(business.valuation.toString());
        return valuation >= valuationRange.start &&
            valuation <= valuationRange.end;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business List'),
      ),
      body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color.fromARGB(242, 193, 228, 244),
                Color.fromARGB(255, 252, 252, 252)
              ],
              center: Alignment.topLeft,
              radius: 1.2,
            ),
          ),
          child: ListView.builder(
            itemCount: businessList.length,
            itemBuilder: (context, index) {
              final business = businessList[index];
              return BusinessCard(business: business);
            },
          )),
    );
  }
}
