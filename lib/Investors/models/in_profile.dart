class InvestorProfile {
  final String userName;
  final String investedCompanyName;
  final String paymentid;
  final double pricePaid;
  final String equityInvested;

  InvestorProfile({
    required this.userName,
    required this.investedCompanyName,
    required this.paymentid,
    required this.pricePaid,
    required this.equityInvested,
  });

  // JSON serialization: Convert object to a Map
  Map<String, dynamic> toJson() {
    return {
      'user': userName,
      'company': investedCompanyName,
      'payment_id': paymentid,
      'price_paid': pricePaid,
      'equity_purchased': equityInvested,
    };
  }

  // JSON deserialization: Create an object from a Map
  factory InvestorProfile.fromJson(Map<String, dynamic> json) {
    return InvestorProfile(
      investedCompanyName: json['company'],
      paymentid: json['payment_id'],
      pricePaid: json['price_paid'].toDouble(),
      equityInvested: json['equity_purchased'],
      userName: json['user'],
    );
  }
}
