class BusinessFormData {
  final int id;
  final String businessStage;
  final String industryCategory;
  final String companyName;
  final String description;
  final String link;
  final dynamic abstract;
  final dynamic lastMonthRevenue;
  final dynamic secondLastMonthRevenue;
  final dynamic thirdLastMonthRevenue;
  final dynamic lastYearRevenue;

  final dynamic equity;

  final dynamic image;
  final int category;

  BusinessFormData({
    required this.id,
    required this.businessStage,
    required this.industryCategory,
    required this.companyName,
    required this.description,
    required this.link,
    required this.abstract,
    required this.lastMonthRevenue,
    required this.secondLastMonthRevenue,
    required this.thirdLastMonthRevenue,
    required this.lastYearRevenue,
    required this.equity,
    required this.image,
    required this.category,
  });

  factory BusinessFormData.fromJson(Map<String, dynamic> json) {
    return BusinessFormData(
      id: json['id'],
      businessStage: json['business_stage'],
      industryCategory: json['industry_category'],
      companyName: json['companyName'],
      description: json['description'],
      link: json['link'],
      abstract: json['abstract'],
      lastMonthRevenue: json['last_month_revenue'],
      secondLastMonthRevenue: json['second_last_month_revenue'],
      thirdLastMonthRevenue: json['third_last_month_revenue'],
      lastYearRevenue: json['last_year_revenue'],
      equity: json['equity'],
      image: json['image'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_stage': businessStage,
      'industry_category': industryCategory,
      'companyName': companyName,
      'description': description,
      'link': link,
      'abstract': abstract,
      'last_month_revenue': lastMonthRevenue,
      'second_last_month_revenue': secondLastMonthRevenue,
      'third_last_month_revenue': thirdLastMonthRevenue,
      'last_year_revenue': lastYearRevenue,
      'equity': equity,
      'image': image,
      'category': category,
    };
  }
}
