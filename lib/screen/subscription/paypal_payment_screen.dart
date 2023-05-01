import 'package:flutter/material.dart';
import 'package:oxoo/server/repository.dart';
import 'package:oxoo/service/payment_service.dart';
import '../../constants.dart';
import '../../models/all_package_model.dart';
import '../../models/configuration.dart';
import '../../service/authentication_service.dart';
import '../../utils/loadingIndicator.dart';
import 'my_subscription_screen.dart';

class PayPalPaymentScreen extends StatefulWidget {
  const PayPalPaymentScreen(
      {super.key,
      required this.paymentConfig,
      required this.package,
      required this.authService});
  final PaymentConfig paymentConfig;
  final AuthService authService;
  final Package package;

  @override
  State<PayPalPaymentScreen> createState() => _PayPalPaymentScreenState();
}

class _PayPalPaymentScreenState extends State<PayPalPaymentScreen> {
  bool isError = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    makePayment();
  }

  void makePayment() async {
    await Future.delayed(Duration(seconds: 2));
    PaymentService().payWithPaypal(
        amount: double.parse(widget.package.price ?? "0.0"),
        paymentConfig: widget.paymentConfig,
        authService: widget.authService,
        context: context,
        onSuccess: onSuccess,
        onError: onError,
        onCancel: onCancel);
  }

  void onSuccess(Map params) async {
    await Repository()
        .saveChargeData(
            planID: widget.package.planId,
            userId: widget.authService.getUser()!.userId,
            paidAmount: widget.package.price,
            paymentMethod: "PayPal",
            paymentInfo: "")
        .then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MySubscriptionScreen(),
      ));
    });
  }

  void onError(error) {
    printLog("Payment Failed. Code: $error");
    var snackBar = SnackBar(
      content: Text(error.toString()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    isError = true;
    errorMessage = "${error.toString()}\n Please try again later.";
    setState(() {});
    Navigator.of(context).pop();
  }

  void onCancel(params) {
    printLog("Payment Failed. Code: $params");

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("PayPal Payment"),
        ),
        body: Center(
          child: isError
              ? Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                )
              : spinkit,
        ));
  }
}
