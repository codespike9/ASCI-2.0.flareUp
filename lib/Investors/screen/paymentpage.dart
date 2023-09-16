//import 'package:flutter_flareup/Investors/screen/payment_succesful.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'tabscreen.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    super.key,
    required this.choosenEquity,
    required this.equivalentPrice,
    required this.companyId,
    required this.paymentId,
    required this.authToken,
  });

  final double choosenEquity;
  final double equivalentPrice;
  final int companyId;
  final String paymentId;
  final String authToken;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  void postPaymentInformation(String razorPaymentId) async {
    final authToken = widget.authToken;
    const apiUrl = 'https://dharmarajjena.pythonanywhere.com/api/pay/';

    final requestBody = {
      'equity_purchased': widget.choosenEquity,
      'payment_id': razorPaymentId,
      'price_paid': widget.equivalentPrice,
      'company': widget.companyId,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $authToken',
        },
        body: json.encode(requestBody),
      );

      print(authToken);
      print(response.body);

      if (response.statusCode == 202) {
        print('Payment information successfully posted.');

        if (!context.mounted) {
          return;
        }

        Navigator.pushReplacementNamed(context, InvestorTabScreen.routeName,
            arguments: authToken);

        // Handle success here
      } else {
        print('Failed to post payment information: ${response.statusCode}');
        // Handle failure here
      }
    } catch (error) {
      print('Error: $error');
      // Handle error here
    }
  }

  var _razorpay = Razorpay();
  String choosenEquity = '';
  String equivalentPrice = '';

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    String? razorpayPaymentId = response.paymentId;
    print('*******Payment Gateway Succesful*********');

    postPaymentInformation(razorpayPaymentId!);
    const snackBar = SnackBar(
      content: Text('Payment Successful : Thank You For Investing'),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment Gateway Falirue');
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('Payment Gateway Wallet');
    // Do something when an external wallet is selected
  }

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 205, 183, 239),
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: Container(
              height: 200,
              width: 300,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
                child: Column(
                  children: [
                    Text(
                      "INVESTMENT DETAILS",
                      style: GoogleFonts.abel(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Choosen Equity: ${widget.choosenEquity}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Equivalent Price: ${widget.equivalentPrice}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        var options = {
                          'key': 'rzp_test_84QavGB6R6hnD9',
                          'amount': widget.equivalentPrice,
                          'name': 'FlareUp',
                          'order_id': widget.paymentId,
                          'description': 'Investment Side',
                          'timeout': 90, // in seconds
                        };

                        _razorpay.open(options);
                      },
                      label: const Text(
                        'Pay Now',
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: const Icon(
                        Icons.payment,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
