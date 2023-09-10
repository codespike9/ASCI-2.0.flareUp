import 'package:flutter/material.dart';

import 'package:flutter_flareup/start-Up/models/buisness_company.dart';
import 'package:flutter_flareup/start-Up/screens/buisness_form.dart';
import 'package:flutter_flareup/start-Up/screens/update_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

import '../../Start-Screen/start_screen.dart';
import 'investor_list.dart';

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
      final authToken = widget.authToken;

      final response = await http.get(
        Uri.parse('http://dharmarajjena.pythonanywhere.com/api/company/'),
        headers: {
          'Token': authToken,
        },
      );

      if (response.statusCode == 200) {
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
    String baseUrl = 'http://dharmarajjena.pythonanywhere.com';

    void _showBusinessDetails(BuildContext context, BusinessFormData business) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  baseUrl + business.image!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Business Stage: ${business.businessStage}',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Industry Category: ${business.industryCategory}',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Company Name: ${business.companyName}',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Description: ${business.description}',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final url = business.link;
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                  child: Text(
                    'Link: ${business.link}',
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      color: Colors.blue, // Make the link text blue
                      decoration:
                          TextDecoration.underline, // Underline the link
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              // Investor details Button
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvestedBuisnessList(
                        id: business.id,
                      ),
                    ),
                  );
                },
                child: const Row(
                  children: [
                    Icon(Icons.badge, color: Colors.green), // Delete Icon
                    SizedBox(width: 8.0),
                    Text('Investors', style: TextStyle(color: Colors.green)),
                  ],
                ),
              ),
              // Update Button
              TextButton(
                onPressed: () async {
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateBuisness(
                        id: business.id,
                      ),
                    ),
                  );
                  _fetchData();
                },
                child: const Row(
                  children: [
                    Icon(Icons.edit,
                        color: Color.fromARGB(255, 2, 64, 252)), // Update Icon
                    SizedBox(width: 8.0),
                    Text(
                      'Update',
                      style: TextStyle(
                        color: Color.fromARGB(255, 2, 64, 252),
                      ),
                    ),
                  ],
                ),
              ),

              //Delete Button
              TextButton(
                onPressed: () async {
                  // Close the dialog

                  // Send the delete request
                  final deleteUrl =
                      'https://dharmarajjena.pythonanywhere.com/api/deleteCompany/${business.id}';
                  final response = await http.delete(Uri.parse(deleteUrl));
                  print(business.id);
                  print(response.body);

                  if (response.statusCode == 200) {
                    // Handle successful deletion (you can show a message or update your UI)
                    print('Business deleted successfully.');
                    Navigator.of(context).pop();
                    _fetchData();
                    const snackBar = SnackBar(
                      content: Text('Buisness Deletion Succesful!!'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    );
                    if (!context.mounted) {
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    // Handle deletion failure (you can show an error message)
                    print('Failed to delete business: ${response.statusCode}');
                  }
                },
                child: const Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red), // Delete Icon
                    SizedBox(width: 8.0),
                    Text('Delete', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),

              // Close Button
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.purple),
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 112, 147, 165),
      appBar: AppBar(
        title: const Text('Business Screen'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, StartScreen.routeName);
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
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: submittedBusinesses.length,
        itemBuilder: (context, index) {
          var business = submittedBusinesses[index];

          return Card(
            elevation: 4, // Adjust the elevation value as needed
            shadowColor: Colors.black, // You can customize the shadow color
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10), // Adjust the circle radius
            ),
            child: GestureDetector(
              onTap: () {
                _showBusinessDetails(context, business);
              },
              child: ListTile(
                leading: business.image != null
                    ? Container(
                        width: 50, // Adjust the width and height as needed
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue, // You can set your desired color
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 2, // Spread radius
                              blurRadius: 5, // Blur radius
                              offset: const Offset(0, 3), // Offset
                            ),
                          ],
                        ),
                        child: Image.network(
                          baseUrl + business.image!, // Use the image URL
                          width: 30, // Adjust the image size
                          height: 30,
                          fit: BoxFit.cover, // Adjust the fit as needed
                        ),
                      )
                    : Container(
                        width: 50, // Adjust the width and height as needed
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue, // You can set your desired color
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 2, // Spread radius
                              blurRadius: 5, // Blur radius
                              offset: const Offset(0, 3), // Offset
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons
                                .business, // You can replace this with your image
                            color: Colors.white, // Icon color
                            size: 30, // Icon size
                          ),
                        ),
                      ),
                title: Text(
                  business.companyName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Business Stage: ${business.businessStage}"),
                    Text("Industry Category: ${business.industryCategory}"),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
