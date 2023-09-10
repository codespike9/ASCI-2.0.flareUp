import 'package:flutter/material.dart';

class InvestedBuisnessList extends StatefulWidget {
  const InvestedBuisnessList({super.key, required this.id});
  final int id;

  @override
  State<InvestedBuisnessList> createState() => _InvestedBuisnessListState();
}

class _InvestedBuisnessListState extends State<InvestedBuisnessList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 112, 147, 165),
                  Colors.white12,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 0, // You can adjust the left position as needed
            right: 0, // You can adjust the right position as needed
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0), // Add horizontal padding
              child: Container(
                color:
                    Colors.white, // Set the background color of the container
                padding: const EdgeInsets.all(16.0), // Add internal padding
                child: const Text(
                  'Invested Investor List',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 175,
            left: 15,
            right: 15,
            bottom: 0,
            child: Container(
              height: 300,
              width: 250,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 254, 255, 255),
                    Colors.white12,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 100,
            right: 100,
            child: GestureDetector(
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://www.kindpng.com/picc/m/497-4973038_profile-picture-circle-png-transparent-png.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
