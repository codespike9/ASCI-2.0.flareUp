import 'package:flutter/material.dart';
import 'package:flutter_flareup/start-Up/models/buisness_company.dart';
import 'package:flutter_flareup/start-Up/screens/buisness_form.dart';

class BuisnessScreen extends StatefulWidget {
  const BuisnessScreen({super.key});
  static const String routeName = '/buisness-startup-screen';
  @override
  State<BuisnessScreen> createState() => _BuisnessScreenState();
}

class _BuisnessScreenState extends State<BuisnessScreen> {
  List<BusinessFormData> submittedBusinesses = [];
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
          final newBusiness =
              await Navigator.pushNamed(context, BuisnessFormScreen.routeName);

          if (newBusiness != null && newBusiness is BusinessFormData) {
            // Add the submitted business to the list
            setState(() {
              submittedBusinesses.add(newBusiness);
            });
          }
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
