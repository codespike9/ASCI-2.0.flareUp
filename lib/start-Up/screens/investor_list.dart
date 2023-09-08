import 'package:flutter/material.dart';

class BuisnessList extends StatefulWidget {
  const BuisnessList({super.key, required this.id});
  final int id;
  

  @override
  State<BuisnessList> createState() => _BuisnessListState();
}

class _BuisnessListState extends State<BuisnessList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 112, 147, 165),
      
    );
  }
}
