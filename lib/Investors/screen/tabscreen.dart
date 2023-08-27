import 'package:flutter/material.dart';
import 'package:flutter_flareup/Investors/pages/blog_page.dart';
import 'package:flutter_flareup/Investors/pages/home_page.dart';
import 'package:flutter_flareup/Investors/pages/your_investment.dart';
import 'package:flutter_flareup/data/in_business_data.dart';

class InvestorTabScreen extends StatefulWidget {
  const InvestorTabScreen({super.key});
  static const String routeName = '/investor-tab-screen';

  @override
  State<InvestorTabScreen> createState() => _InvestorTabScreenState();
}

class _InvestorTabScreenState extends State<InvestorTabScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(
      business: dummyBusinessData,
    ),
    const BlogPage(),
    const YourInvestmentPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.layers),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt),
            label: 'Blog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: 'Y-Invest',
          ),
        ],
      ),
    );
  }
}
