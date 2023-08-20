import 'package:flutter/material.dart';

class YourInvestmentPage extends StatefulWidget {
  const YourInvestmentPage({super.key});
  static const String routeName = '/investor-your_investment-page';

  @override
  State<YourInvestmentPage> createState() => _YourInvestmentPageState();
}

class _YourInvestmentPageState extends State<YourInvestmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromARGB(255, 156, 209, 234), Colors.white]),
              
        ),
        child: const Center(child: Text('Home-Page'),),
      ),
    );
  }
}
