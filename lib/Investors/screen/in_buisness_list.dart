import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BuisnessList extends StatefulWidget {
  const BuisnessList({super.key});
  static const String routeName = '/investor-buisness-list';

  @override
  State<BuisnessList> createState() => _BuisnessListState();
}

class _BuisnessListState extends State<BuisnessList> {
  List<BusinessModel> businessList = [];

  @override
  void initState() {
    super.initState();
    _fetchBusinessData();
  }

  Future<void> _fetchBusinessData() async {
    final response = await http.get(
      Uri.parse('http://dharmarajjena.pythonanywhere.com/api/companyList/'),
    );

    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> businessDataList = jsonData as List<dynamic>;

      setState(() {
        businessList = businessDataList.map((data) {
          return BusinessModel.fromJson(data);
        }).toList();
      });
    } else {
      print('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business List'),
      ),
      body: ListView.builder(
        itemCount: businessList.length,
        itemBuilder: (context, index) {
          final business = businessList[index];
          return ListTile(
            title: Text(business.companyName),
            // You can customize the tile appearance here
          );
        },
      ),
    );
  }
}

class BusinessModel {
  final String companyName;

  BusinessModel({
    required this.companyName,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      companyName: json['companyName'],
    );
  }
}
