import 'package:flutter/material.dart';
import 'package:flutter_flareup/Investors/screen/in_buisness_details.dart';
import 'package:flutter_flareup/models/in_buisness_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.business});
  final List<BusinessModel> business;

  static const String routeName = '/investor-home-page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromARGB(255, 191, 224, 239),
              Color.fromARGB(255, 224, 224, 224)
            ],
            center: Alignment.topLeft,
            radius: 2.4,
          ),
        ),
        child: ListView.builder(
          itemCount: widget.business.length,
          itemBuilder: (context, index) {
            final businessData = widget.business[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  BusinessDetailsScreen.routeName,
                  arguments: businessData,
                );
              },
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(3)),
                      child: Image.network(
                        businessData.imageUrl,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            businessData.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            businessData.category.toString().split('.').last,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Valuation: ${businessData.valuationGoal}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 0, 140, 255),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
