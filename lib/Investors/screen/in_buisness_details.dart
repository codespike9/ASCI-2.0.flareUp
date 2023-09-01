import 'package:flutter/material.dart';
import '../models/in_buisness_model.dart';

class BusinessDetailsScreen extends StatefulWidget {
  const BusinessDetailsScreen(this.business, {super.key});
  final BusinessModel business;
  static const String routeName = '/investor-buisness-details2';

  @override
  _BusinessDetailsScreenState createState() => _BusinessDetailsScreenState();
}

class _BusinessDetailsScreenState extends State<BusinessDetailsScreen> {
  double equityToBuy = 0.0;

  double calculateInvestmentAmount() {
    return (widget.business.valuationGoal / 100) * equityToBuy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.business.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              widget.business.imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    widget.business.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.business.category.toString().split('.').last,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Valuation: ${widget.business.valuationGoal}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 140, 255),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.business.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 10),
                  Text(
                    'Investment Amount: ${calculateInvestmentAmount().toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(229, 56, 169, 60),
                      foregroundColor: Colors.white, // Set background color
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 28),
                    ),
                    child: const Text('Invest'),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
