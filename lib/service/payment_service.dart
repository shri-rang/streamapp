import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:oxoo/config.dart';
import 'package:oxoo/server/repository.dart';
import 'package:oxoo/service/authentication_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../models/configuration.dart';
import '../strings.dart';
import 'package:stripe_checkout/stripe_checkout.dart';

class PaymentService {
  void payWithStripe(
      {required double amount,
      required PaymentConfig paymentConfig,
      required AuthService authService,
      required BuildContext context,
      required Function onSuccess,
      required Function onError,
      required Function onCancel}) async {
    final String sessionId = await Repository().createStripeSessionId(
        amount.toString(), paymentConfig.stripeSecretKey);

    final result = await redirectToCheckout(
      context: context,
      sessionId: sessionId,
      publishableKey: paymentConfig.stripePublishableKey,
      successUrl: 'https://checkout.stripe.dev/success',
      canceledUrl: 'https://checkout.stripe.dev/cancel',
    );
    final text = result.when(
        success: () => onSuccess,
        canceled: () => onCancel,
        error: (e) => onError);
  }

  void payWithPaypal({
    required double amount,
    required PaymentConfig paymentConfig,
    required AuthService authService,
    required BuildContext context,
    required Function onSuccess,
    required Function onError,
    required Function onCancel,
  }) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => UsePaypal(
          onSuccess: onSuccess,
          onError: onError,
          onCancel: onCancel,
          returnURL: Config.termsPolicyUrl,
          cancelURL: Config.termsPolicyUrl,
          transactions: [
            {
              "amount": {
                "total": amount,
                "currency": "USD",
                "details": {
                  "subtotal": amount,
                  "shipping": '0',
                  "shipping_discount": 0
                }
              },
              "description": "Purchase Subscription Plan",
              "item_list": {
                "items": [
                  {
                    "name": AppContent.appName,
                    "quantity": 1,
                    "price": amount,
                    "currency": "USD"
                  }
                ],

                // shipping address is not required though
                "shipping_address": {
                  "recipient_name": authService.getUser()!.name ?? "",
                  "line1": "",
                  "line2": "",
                  "city": "",
                  "country_code": "US",
                  "postal_code": "",
                  "phone": "+00000000",
                  "state": ""
                },
              }
            }
          ],
          note: "Contact us for any questions on your order.",
          clientId: paymentConfig.paypalClientId,
          secretKey: Config.paypalSecretKey),
    ));
  }

  void payWithRazorpay({
    required double amount,
    required PaymentConfig paymentConfig,
    required AuthService authService,
    required Function onSuccess,
    required Function onError,
    required Function onWalletSelected,
  }) async {
    Razorpay razorpay = Razorpay();
    var options = {
      'key': paymentConfig.razorpayKeyId,
      'amount': _convertCurrency(amount, paymentConfig.razorpayInrExchangeRate,
          paymentConfig.currency),
      'currency': "INR",
      'name': AppContent.appName,
      'description': 'Subscription Plan',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      // 'prefill': {
      //   'contact': '8888888888',
      //   'email': 'test@razorpay.com'
      // },
      'external': {
        'wallets': ['paytm']
      }
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onError);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onWalletSelected);
    razorpay.open(options);
  }

  double _convertCurrency(double amount, String rate, String currency) {
    if (currency != "INR") {
      double temp = amount * double.parse(rate);
      return temp * 100;
    } else {
      return amount * 100;
    }
  }
}
