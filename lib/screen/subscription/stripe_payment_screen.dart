import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oxoo/screen/subscription/choose_plan_screen.dart';
import 'package:oxoo/service/payment_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants.dart';
import '../../models/all_package_model.dart';
import '../../models/configuration.dart';
import '../../server/repository.dart';
import '../../service/authentication_service.dart';
import '../../utils/loadingIndicator.dart';
import 'my_subscription_screen.dart';

class StripePaymentScreen extends StatefulWidget {
  StripePaymentScreen(
      {Key? key,
      required this.paymentConfig,
      required this.package,
      required this.authService})
      : super(key: key);

  final PaymentConfig paymentConfig;
  final AuthService authService;
  final Package package;

  @override
  State<StripePaymentScreen> createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  bool isError = false;
  String errorMessage = "";
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    makePayment();
    super.initState();
  }

  void makePayment() async {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    // await Future.delayed(Duration(seconds: 2));
    // PaymentService().payWithStripe(
    //     amount: double.parse(this.widget.package.price!),
    //     paymentConfig: widget.paymentConfig,
    //     authService: widget.authService,
    //     context: context,
    //     onSuccess: onSuccess,
    //     onError: onError,
    //     onCancel: onCancel);
  }

  void onSuccess(Map params) async {
    await Repository()
        .saveChargeData(
            planID: widget.package.planId,
            userId: widget.authService.getUser()!.userId,
            paidAmount: widget.package.price,
            paymentMethod: "Stripe",
            paymentInfo: "")
        .then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MySubscriptionScreen(),
      ));
    });
  }

  void onError(error) {
    printLog("Stripe Payment Failed. Code: $error");
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
    printLog("Stripe Payment Canceled. Code: $params");

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stripe Payment"),
        ),
        body: FutureBuilder<String>(
            future: Repository().createStripeSessionId(
                widget.package.price!, widget.paymentConfig.stripeSecretKey),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return WebView(
                  initialUrl: snapshot.data,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                  onProgress: (int progress) {
                    print('WebView is loading (progress : $progress%)');
                  },
                  javascriptChannels: <JavascriptChannel>{
                    _toasterJavascriptChannel(context),
                  },
                  navigationDelegate: (NavigationRequest request) {
                    if (request.url.startsWith('https://www.youtube.com/')) {
                      print('blocking navigation to $request}');
                      return NavigationDecision.prevent;
                    }
                    print('allowing navigation to $request');
                    if (request.url
                        .startsWith("https://checkout.stripe.dev/success")) {
                      printLog("stripe payment successfully");
                      //save payment data
                      savePaymentData();
                    } else if (request.url
                        .startsWith("https://checkout.stripe.dev/cancel")) {
                      //payment failed
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Payment unsuccessful.")),
                      );
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ChoosePlanScreen(),
                      ));
                    }
                    return NavigationDecision.navigate;
                  },
                  onPageStarted: (String url) {
                    print('Page started loading: $url');
                  },
                  onPageFinished: (String url) {
                    print('Page finished loading: $url');
                  },
                  gestureNavigationEnabled: true,
                  backgroundColor: const Color(0x00000000),
                );
              }
              return Center(
                child: isError
                    ? Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                      )
                    : spinkit,
              );
            }));
  }

  void savePaymentData() async {
    await Repository()
        .saveChargeData(
            planID: widget.package.planId,
            userId: widget.authService.getUser()!.userId,
            paidAmount: widget.package.price,
            paymentMethod: "Stripe",
            paymentInfo: "Payment success")
        .then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MySubscriptionScreen(),
      ));
    });
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
