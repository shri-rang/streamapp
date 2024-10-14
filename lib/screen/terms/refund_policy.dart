import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../config.dart';
import '../../strings.dart';
import '../../style/theme.dart';

class Refund extends StatelessWidget {
  static final String route = "Refund";
  String _url = Config.termsPolicyUrl;
  bool isLoading = true;
  static bool isDark = Hive.box('appModeBox').get('isDark') ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(AppContent.refund),
            backgroundColor: CustomTheme.amber_800
            //    isDark ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
            ),
        body: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildContent(
                    "The Subscription Fees paid are non-refundable irrespective of whether the Service has been availed and/or consumed or not. "
                    "In the event of any fraudulent transaction, we may refund the Subscription Fee during the Subscription Term post successful verification and confirmation from third-party payment gateways/service providers, "
                    "engaged to process and facilitate the payment of the Subscription Fee."),
                buildContent(
                    "Any and all payments made under the User Agreement are non-refundable, and we do not provide refunds or credits for any partial-month subscription periods for any and all reasons except if you have reason to believe that your account details have been obtained by another without consent. "
                    "In such an event, you should immediately contact the third-party payment gateway/payment processing service provider for resolution."),
              ],
            ),
          ),
        )
        //   WebView(
        //   initialUrl: _url,
        // ),
        );
  }

  Widget buildContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
