class InvestorBusiness {
  final int id;
  final dynamic user;
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
  final dynamic raisingAmount;
  final dynamic equity;
  final dynamic valuation;
  final dynamic quantityAvailable;
  final bool valid;
  final dynamic image;
  final int category;

  InvestorBusiness({
    required this.id,
    required this.user,
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
    required this.raisingAmount,
    required this.equity,
    required this.valuation,
    required this.quantityAvailable,
    required this.valid,
    required this.image,
    required this.category,
  });

  factory InvestorBusiness.fromJson(Map<String, dynamic> json) {
    return InvestorBusiness(
      user: json['user'],
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
      raisingAmount: json['raising_amount'],
      equity: json['equity'],
      valuation: json['valuation'],
      quantityAvailable: json['quantity_available'],
      valid: json['valid'],
      image: json['image'],
      category: json['category'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
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
      'raising_amount': raisingAmount,
      'equity': equity,
      'valuation': valuation,
      'quantity_available': quantityAvailable,
      'valid': valid,
      'image': image,
      'category': category,
      'id': id,
    };
  }
}
