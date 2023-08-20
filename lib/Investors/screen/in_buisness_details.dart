import 'package:flutter/material.dart';
import '../../models/in_buisness_model.dart';

class BusinessDetailsScreen extends StatelessWidget {
  
  const BusinessDetailsScreen(this.business, {super.key});
  final BusinessModel business;
  static const String routeName = '/investor-buisness-details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(business.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            business.imageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Text(
            business.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            business.category.toString().split('.').last,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Valuation: ${business.valuationGoal}',
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 0, 140, 255),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            business.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
