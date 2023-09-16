import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_flareup/Investors/screen/paymentpage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/Investor_buisness.dart';
import 'package:http/http.dart' as http;

class BuisnessDetails extends StatefulWidget {
  const BuisnessDetails(
      {super.key, required this.business, required this.authToken});
  final InvestorBusiness business;
  final String authToken;
  static const String routeName = '/investor-buisness-details';

  @override
  State<BuisnessDetails> createState() => _BuisnessDetailsState();
}

class _BuisnessDetailsState extends State<BuisnessDetails> {
  double equityToBuy = 0.0;

  final TextEditingController _equityController = TextEditingController();

  void dispose() {
    _equityController.dispose();
    super.dispose();
  }

  double calculateInvestmentAmount() {
    return (widget.business.valuation / 100) * equityToBuy;
  }

  Future<void> _launchURL(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchPDF(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl, forceWebView: true);
    } else {
      throw 'Could not launch $pdfUrl';
    }
  }

  Future<void> postDataToAPI() async {
    final companyId =
        widget.business.id.toString(); // Convert company id to a string
    final equity = _equityController.text; // Get the value from the controller

    // Create the request body as a Map
    final Map<String, dynamic> requestBody = {
      'id': companyId,
      'equity': equity,
    };

    final response = await http.post(
      Uri.parse(
          'http://dharmarajjena.pythonanywhere.com/api/InvestmentSummary/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody), // Encode the request body as JSON
    );

    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      var chosenEquity = jsonData['choosen_equity'];
      var equivalentPrice = jsonData['equivalent_price'];
      var investedCompanyId = jsonData['company_id'];
      var paymentId = jsonData['payment']['id'];

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(
            choosenEquity: chosenEquity,
            equivalentPrice: equivalentPrice,
            companyId: investedCompanyId,
            paymentId: paymentId,
            authToken: widget.authToken,
          ),
        ),
      );
      // print(response.body);
      print('posted data sucesfully');
    } else {
      throw Exception('Failed to post data to the API ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImage(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 10,
                    padding:
                        const EdgeInsets.all(16.0), // Add padding for spacing
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(165, 202, 189, 229),
                          Color.fromARGB(219, 255, 255, 255),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius:
                          BorderRadius.circular(8.0), // Rounded corners
                    ),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Main Information',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Company Name: ${widget.business.companyName}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Valuation: ${widget.business.valuation}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Equity Available: ${widget.business.equity}%',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Business Stage: ${widget.business.businessStage}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Industry Category: ${widget.business.industryCategory}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: MediaQuery.of(context).size.width - 10,
                    padding:
                        const EdgeInsets.all(16.0), // Add padding for spacing
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(165, 202, 189, 229),
                          Color.fromARGB(219, 255, 255, 255),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius:
                          BorderRadius.circular(8.0), // Rounded corners
                    ),
                    child: Text(
                      'Description: ${widget.business.description}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: MediaQuery.of(context).size.width - 10,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(165, 202, 189, 229),
                          Color.fromARGB(219, 255, 255, 255),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            _launchURL(widget.business.link);
                          },
                          child: Column(
                            children: [
                              const Text(
                                'Weblink',
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      Colors.black, // Set text color to black
                                  fontWeight: FontWeight
                                      .w400, // You can set a bold font weight if needed
                                ),
                              ),
                              const SizedBox(
                                  height:
                                      4), // Add spacing between "Weblink" and the link
                              Text(
                                widget.business.link,
                                style: const TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        InkWell(
                          onTap: () {
                            _launchPDF(widget.business.abstract);
                          },
                          child: Column(
                            children: [
                              const Text(
                                'Abstract',
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      Colors.black, // Set text color to black
                                  fontWeight: FontWeight
                                      .w400, // You can set a bold font weight if needed
                                ),
                              ),
                              const SizedBox(
                                  height:
                                      4), // Add spacing between "Abstract" and the link
                              Text(
                                '${widget.business.abstract}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: MediaQuery.of(context).size.width - 10,
                    padding:
                        const EdgeInsets.all(16.0), // Add padding for spacing
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(165, 202, 189, 229),
                          Color.fromARGB(219, 255, 255, 255),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius:
                          BorderRadius.circular(8.0), // Rounded corners
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Finance Information',
                          style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Last Month Revenue: ${widget.business.lastMonthRevenue}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Second Last Month Revenue: ${widget.business.secondLastMonthRevenue}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Third Last Month Revenue: ${widget.business.thirdLastMonthRevenue}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Last Year Revenue: ${widget.business.lastYearRevenue}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Raising Amount: ${widget.business.raisingAmount}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200], // Greyish background color
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300]!, // Shadow color
                              offset:
                                  const Offset(0, 2), // Offset of the shadow
                              blurRadius: 4, // Blur radius of the shadow
                            ),
                          ],
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Equity to Buy (%)',
                            border: InputBorder.none,
                            prefixIcon:
                                Icon(Icons.pie_chart, color: Colors.blue),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text(
                                '%',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 16.0,
                            ),
                          ),
                          controller: _equityController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            final enteredValue = double.tryParse(value) ?? 0.0;
                            // if (enteredValue <= widget.business.equity) {
                            setState(() {
                              equityToBuy = enteredValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Investment Amount: ${calculateInvestmentAmount().toStringAsFixed(2)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              child: ElevatedButton(
                onPressed: () {
                  final equityenteredValue =
                      double.tryParse(widget.business.equity) ?? 0.0;
                  if (equityToBuy <= equityenteredValue) {
                    postDataToAPI();
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Invalid Equity'),
                          content: Text(
                              'Enter equity less or equal to available equity.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(229, 56, 169, 60),
                  foregroundColor: Colors.white, // Set background color
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 28),
                ),
                child: const Text('Invest'),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              child: TextButton(
                onPressed: () {
                  // Implement Learn More functionality here
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(227, 181, 179, 179),
                  foregroundColor: const Color.fromARGB(222, 2, 2, 2),
                  // Set background color
                ),
                child: const Text('Learn More'),
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
    String imageUrl =
        widget.business.image ?? '/media/cover_images/Alzeimers.jpg';
    // Use the business image URL if available, or the dummy image URL as a fallback

    String completeImageUrl = baseUrl + imageUrl;
    if (widget.business.image != null) {
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
}
