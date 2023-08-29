import 'package:flutter/material.dart';
import 'package:flutter_flareup/Investors/screen/in_buisness_details.dart';
import 'package:flutter_flareup/Investors/widget/category_filters.dart';
import 'package:flutter_flareup/Investors/models/in_buisness_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.business});
  final List<BusinessModel> business;

  static const String routeName = '/investor-home-page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Set<BusinessCategory> selectedCategories = {};

  @override
  Widget build(BuildContext context) {
    List<BusinessModel> filteredBusinesses;

    if (selectedCategories.isNotEmpty) {
      filteredBusinesses = widget.business
          .where((business) => selectedCategories.contains(business.category))
          .toList();
    } else {
      filteredBusinesses = widget.business;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Listings'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromARGB(242, 193, 228, 244),
              Color.fromARGB(255, 252, 252, 252)
            ],
            center: Alignment.topLeft,
            radius: 1.5,
          ),
        ),
        child: ListView.builder(
          itemCount: filteredBusinesses.length,
          itemBuilder: (context, index) {
            final businessData = filteredBusinesses[index];
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...BusinessCategory.values.map((category) {
                    return CategoryCheckbox(
                      category: category,
                      isSelected: selectedCategories.contains(category),
                      onTap: () {
                        setState(() {
                          if (selectedCategories.contains(category)) {
                            selectedCategories.remove(category);
                          } else {
                            selectedCategories.add(category);
                          }
                        });
                      },
                    );
                  }).toList(),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}
