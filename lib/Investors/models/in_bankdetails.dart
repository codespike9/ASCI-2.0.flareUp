class InvestorBankDetails {
  final String ifsc;
  final String accno;

  InvestorBankDetails({required this.accno, required this.ifsc});

  Map<String, dynamic> toJson() {
    return {
      'IFSC_code': ifsc,
      'ACC_no': accno,
    };
  }

  // JSON deserialization: Create an object from a Map
  factory InvestorBankDetails.fromJson(Map<String, dynamic> json) {
    return InvestorBankDetails(
      ifsc: json['IFSC_code'],
      accno: json['ACC_no'],
    );
  }
}
