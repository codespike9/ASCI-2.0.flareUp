class InvestorInvested {
  final String name;
  final String email;
  final String ifscCode;
  final String accountNumber;
  final String equity;

  InvestorInvested({
    required this.name,
    required this.email,
    required this.ifscCode,
    required this.accountNumber,
    required this.equity,
  });

  factory InvestorInvested.fromJson(Map<String, dynamic> json) {
    return InvestorInvested(
      name: json['Investor'] as String,
      email: json['Investor_email_id'] as String,
      ifscCode: json['IFSC_code'] as String,
      accountNumber: json['ACC_no'] as String,
      equity: json['equity'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Investor': name,
      'Investor_email_id': email,
      'IFSC_code': ifscCode,
      'ACC_no': accountNumber,
      'equity': equity,
    };
  }
}
