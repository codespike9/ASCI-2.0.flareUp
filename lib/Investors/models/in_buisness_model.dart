import 'package:uuid/uuid.dart';

var uuid = const Uuid();

enum BusinessCategory {
  technologyConsulting,
  eCommerce,
  healthcare,
  finance,
  hospitality,
  manufacturing,
  other,
}

class BusinessModel {
  final String id;
  final String name;
  final BusinessCategory category; // Using the enum here
  final int equityPercentage;
  final String dilatationStrategy;
  final int valuationGoal;
  final String description;
  final String imageUrl;

  BusinessModel({
    required this.name,
    required this.category,
    required this.equityPercentage,
    required this.dilatationStrategy,
    required this.valuationGoal,
    required this.description,
    required this.imageUrl,
  }) : id = uuid.v4();
}
