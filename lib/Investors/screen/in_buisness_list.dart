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
  List<InvestorBusiness> originalBusinessList = [];

  RangeValues valuationRange =
      const RangeValues(100000, 2000000); // 1 lakh to 20 lakh

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
        'Authorization': 'Token $authToken',
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
        // Create a copy of the original list for resetting the filter
        originalBusinessList = List<InvestorBusiness>.from(businessList);
      });
    } else {
      print('Failed to fetch data');
    }
  }

  Future<void> _showFilterDialog() async {
    RangeValues newRange = valuationRange;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter by Valuation'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RangeSlider(
                    values: newRange,
                    min: 100000,
                    max: 2000000,
                    divisions: 100,
                    onChanged: (RangeValues values) {
                      setState(() {
                        newRange = values;
                      });
                    },
                  ),
                  Text('Valuation Range: ${newRange.start} - ${newRange.end}'),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  valuationRange = newRange;
                });
                filterBusinessesByValuation();
                Navigator.of(context).pop();
              },
              child: const Text('Apply Filter'),
            ),
            TextButton(
              onPressed: () {
                resetFilter();
                Navigator.of(context).pop();
              },
              child: const Text('Reset Filter'),
            ),
          ],
        );
      },
    );
  }

  void filterBusinessesByValuation() {
    setState(() {
      businessList = originalBusinessList.where((business) {
        final valuation = double.parse(business.valuation.toString());
        return valuation >= valuationRange.start &&
            valuation <= valuationRange.end;
      }).toList();
    });
  }

  void resetFilter() {
    setState(() {
      businessList = List<InvestorBusiness>.from(originalBusinessList);
      valuationRange = const RangeValues(100000, 2000000);
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
              Color.fromARGB(255, 252, 252, 252),
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFilterDialog();
        },
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}