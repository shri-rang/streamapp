import 'package:flutter/material.dart';
import 'package:oxoo/constants.dart';
import 'package:oxoo/models/all_package_model.dart';
import 'package:oxoo/server/repository.dart';
import 'package:oxoo/service/payment_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../models/configuration.dart';
import '../../service/authentication_service.dart';
import 'my_subscription_screen.dart';

class RazorpayPaymentScreen extends StatefulWidget {
  final double amount;
  final PaymentConfig paymentConfig;
  final AuthService authService;
  final Package package;
  const RazorpayPaymentScreen(
      {super.key,
      required this.amount,
      required this.paymentConfig,
      required this.package,
      required this.authService});

  @override
  State<RazorpayPaymentScreen> createState() => _RazorpayPaymentScreenState();
}

class _RazorpayPaymentScreenState extends State<RazorpayPaymentScreen> {
  @override
  void initState() {
    super.initState();

    PaymentService().payWithRazorpay(
        amount: widget.amount,
        paymentConfig: widget.paymentConfig,
        authService: widget.authService,
        onSuccess: handlePaymentSuccessResponse,
        onError: handlePaymentErrorResponse,
        onWalletSelected: handleExternalWalletSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    printLog(
        "Payment Failed. Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");

    Navigator.of(context).pop();
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    //save  payment info on server
    await Repository()
        .saveChargeData(
            planID: widget.package.planId,
            userId: widget.authService.getUser()!.userId,
            paidAmount: widget.package.price,
            paymentMethod: "RazorPay",
            paymentInfo: "")
        .then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MySubscriptionScreen(),
      ));
    });
    printLog("Payment Successful Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    printLog("razorpay: external wallet selected");
    Navigator.of(context).pop();
  }
}
