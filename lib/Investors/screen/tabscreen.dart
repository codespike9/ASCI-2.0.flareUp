import 'package:flutter/material.dart';
import 'package:flutter_flareup/Investors/pages/blog_page.dart';
//import 'package:flutter_flareup/Investors/pages/home_page.dart';
import 'package:flutter_flareup/Investors/pages/profile_page.dart';
//import 'package:flutter_flareup/Investors/data/in_business_data.dart';
import 'package:flutter_flareup/Investors/screen/in_buisness_list.dart';

class InvestorTabScreen extends StatefulWidget {
  const InvestorTabScreen({super.key, required this.authToken});
  final String authToken;
  static const String routeName = '/investor-tab-screen';

  @override
  State<InvestorTabScreen> createState() => _InvestorTabScreenState();
}

class _InvestorTabScreenState extends State<InvestorTabScreen> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    // Assign the list of pages to the existing _pages variable
    _pages = [
      BuisnessList(authToken: widget.authToken),
      const BlogPage(),
      const YourInvestmentPage(),
    ];
  }

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
            icon: Icon(Icons.business_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt),
            label: 'Blog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
