import 'package:flutter/material.dart';
import 'package:oxoo/constants.dart';
import 'package:oxoo/models/all_package_model.dart';
import 'package:oxoo/screen/subscription/razorpay_payment_screen.dart';
import 'package:oxoo/screen/subscription/choose_plan_screen.dart';
import 'package:oxoo/screen/subscription/paypal_payment_screen.dart';
import 'package:oxoo/screen/subscription/stripe_payment_screen.dart';
import 'package:oxoo/style/theme.dart';
import 'package:provider/provider.dart';

import '../../models/configuration.dart';
import '../../service/authentication_service.dart';
import '../../service/get_config_service.dart';
import '../../strings.dart';

class PaidControllDialog {
  void createDialog(
      BuildContext context, bool isDark, String userId, String movieId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? CustomTheme.darkGrey : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                width: MediaQuery.of(context).size.width,
                height: 260,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        AppContent.youNeedPremium,
                        style: CustomTheme.authTitle,
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomTheme.primaryColor,
                            ),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      // PremiumSubscriptionScreen(
                                      //     fromRadioScreen: true,
                                      //     fromLiveTvScreen: true,
                                      //     liveTvID: movieId,
                                      //     isPaid: "1"),

                                      ChoosePlanScreen(),
                                ),
                              );
                            },
                            child: Text(
                              AppContent.subscribeToPremium,
                              style: CustomTheme.bodyText3White,
                            ),
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomTheme.primaryColor,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(AppContent.goBack,
                                style: CustomTheme.bodyText3White),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void showPaymentDialog(
      BuildContext context, bool isDark, double amount, Package package) {
    final configService = Provider.of<GetConfigService>(context, listen: false);
    PaymentConfig? paymentConfig = configService.paymentConfig();
    final AuthService authService =
        Provider.of<AuthService>(context, listen: false);

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (builder) {
          return Container(
            // height: 300.0,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            ),
            //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        Text(
                          "Select Your Payment Method",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        InkWell(
                          onTap: () async {
                            printLog("-----razor pay payment selected");
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RazorpayPaymentScreen(
                                  amount: amount,
                                  paymentConfig: paymentConfig!,
                                  authService: authService,
                                  package: package,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Card(
                                //color: Colors.red,
                                margin: EdgeInsets.all(10),
                                elevation: 10,
                                child: Container(
                                  width: 100,
                                  height: 70,
                                  child:
                                      Image.asset("assets/images/razorpay.png"),
                                ),
                              ),
                              Text(
                                "Razorpay",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        if (paymentConfig!.paypalEnable == true)
                          InkWell(
                            onTap: () async {
                              printLog("-----paypal payment selected");
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PayPalPaymentScreen(
                                    paymentConfig: paymentConfig,
                                    authService: authService,
                                    package: package,
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Card(
                                  //color: Colors.red,
                                  margin: EdgeInsets.all(10),
                                  elevation: 10,
                                  child: Container(
                                    width: 100,
                                    height: 70,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                          "assets/images/paypal_logo.png"),
                                    ),
                                  ),
                                ),
                                Text(
                                  "PayPal",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        Divider(
                          color: Colors.grey,
                        ),
                        if (paymentConfig.stripeEnable == true)
                          InkWell(
                            onTap: () async {
                              printLog("-----stripe payment selected");
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StripePaymentScreen(
                                    paymentConfig: paymentConfig,
                                    authService: authService,
                                    package: package,
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Card(
                                  color: Colors.blue,
                                  margin: EdgeInsets.all(10),
                                  elevation: 10,
                                  child: Container(
                                    width: 100,
                                    height: 70,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                          "assets/images/stripe_logo.png"),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Stripe",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),

                        //offline
                        Divider(
                          color: Colors.grey,
                        ),
                        if (paymentConfig.stripeEnable == true)
                          InkWell(
                            onTap: () async {
                              printLog("-----stripe payment selected");
                              Navigator.of(context).pop();
                              showOffilePaymentInstructionDialog(
                                  context, paymentConfig);
                            },
                            child: Row(
                              children: [
                                Card(
                                  color: Colors.blue,
                                  margin: EdgeInsets.all(10),
                                  elevation: 10,
                                  child: Container(
                                    width: 100,
                                    height: 70,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          "Offline Payment",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Offline Payment",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        Divider(
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                )),
          );
        });
  }

  void showOffilePaymentInstructionDialog(
      BuildContext context, PaymentConfig paymentConfig) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        ),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  paymentConfig.offlinePaymentTitle,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                Divider(),
                SizedBox(height: 10),
                Text(
                  paymentConfig.offlinePaymentInstruction,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
