import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/Investor_buisness.dart';

class BuisnessDetails extends StatefulWidget {
  const BuisnessDetails({super.key, required this.business});
  final InvestorBusiness business;
  static const String routeName = '/investor-buisness-details';

  @override
  State<BuisnessDetails> createState() => _BuisnessDetailsState();
}

class _BuisnessDetailsState extends State<BuisnessDetails> {
  double equityToBuy = 0.0;

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
            // Display the image at the top
            Image.asset(
              'assets/images/dummyimage.jpg', // Replace with your image path
              height: 200, // Adjust the height as needed
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 10,
                    padding:
                        const EdgeInsets.all(16.0), // Add padding for spacing
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(184, 201, 240, 236),
                          Color.fromARGB(219, 255, 255, 255)
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Company Name: ${widget.business.companyName}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
                          'Equity: ${widget.business.equity}',
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
                          Color.fromARGB(184, 201, 240, 236),
                          Color.fromARGB(219, 255, 255, 255)
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
                    padding:
                        const EdgeInsets.all(16.0), // Add padding for spacing
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(184, 201, 240, 236),
                          Color.fromARGB(219, 255, 255, 255)
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
                      children: [
                        InkWell(
                          onTap: () {
                            _launchURL(widget
                                .business.link); // Open the URL when tapped
                          },
                          child: Text(
                            ' ${widget.business.link}',
                            style: const TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              color: Colors.blue, // Make it look like a link
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        InkWell(
                          onTap: () {
                            _launchPDF(widget
                                .business.abstract); // Open the PDF when tapped
                          },
                          child: Text(
                            ' ${widget.business.abstract}',
                            style: const TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              color: Colors.blue, // Make it look like a link
                            ),
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
                          Color.fromARGB(184, 201, 240, 236),
                          Color.fromARGB(219, 255, 255, 255)
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
                      children: [
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
                        const SizedBox(height: 12),
                        Text(
                          'Quantity Available: ${widget.business.quantityAvailable}',
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
                          // Unfocus the text field when tapping on the background
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
                            border:
                                InputBorder.none, // Remove the default border
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
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              equityToBuy = double.tryParse(value) ?? 0.0;
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
          ],
        ),
      ),
    );
  }
}
