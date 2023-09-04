import 'package:flutter/material.dart';
import 'package:flutter_flareup/start-Up/models/buisness_company.dart';
import 'package:flutter_flareup/start-Up/screens/buisness_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../services/startup_auth.service.dart';

class BuisnessScreen extends ConsumerStatefulWidget {
  const BuisnessScreen({super.key, required this.authToken});
  final String authToken;
  static const String routeName = '/buisness-startup-screen';
  @override
  ConsumerState<BuisnessScreen> createState() => _BuisnessScreenState();
}

class _BuisnessScreenState extends ConsumerState<BuisnessScreen> {
  List<BusinessFormData> submittedBusinesses = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      /*final token =
          ref.read(startuptokenProvider); */ // Use ref.read with listen: false
      final authToken = widget.authToken;
      print(authToken);
      final response = await http.get(
        Uri.parse('http://dharmarajjena.pythonanywhere.com/api/company/'),
        headers: {
          'Token': authToken,
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        //print(token);

        setState(() {
          final List<dynamic> data = json.decode(response.body);
          final List<BusinessFormData> businesses = data.map((item) {
            return BusinessFormData.fromJson(item);
          }).toList();

          submittedBusinesses = businesses;
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Screen'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to the Form Screen and get the submitted data
          // final newBusiness =
          await Navigator.pushNamed(context, BuisnessFormScreen.routeName,
              arguments: widget.authToken);

          _fetchData();

          /* if (newBusiness != null && newBusiness is BusinessFormData) {
            // Add the submitted business to the list
            // Refresh the data list
          }*/
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: submittedBusinesses.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(submittedBusinesses[index].companyName),
            // You can customize the tile appearance here
          );
        },
      ),
    );
  }
}
