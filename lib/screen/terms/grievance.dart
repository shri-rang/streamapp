import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../config.dart';
import '../../strings.dart';
import '../../style/theme.dart';

class Grievance extends StatelessWidget {
  static final String route = "Grievance";
  String _url = Config.termsPolicyUrl;
  bool isLoading = true;
  static bool isDark = Hive.box('appModeBox').get('isDark') ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(AppContent.grievance),
            backgroundColor: CustomTheme.amber_800
            //  isDark ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
            ),
        body: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Text(
                //   'Privacy Policy',
                //   style: TextStyle(
                //     fontSize: 24,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                SizedBox(height: 10),
                Text(
                  'Grievance Officer: Mr. Manav Kamra',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Email ID: apexmultimediasolutions@gmail.com',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Contact Number: 9819666596',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Note:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.center,
                  '* It will take 24 hours after the receipt of the complaint.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.center,
                  '* They will resolve the query/complaint within 10 days from the date of complaint.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        )
        //   WebView(
        //   initialUrl: _url,
        // ),
        );
  }

  final String personalInformation =
      "When you register an account, we may collect personal information such as your name, email address, date of birth, and payment information.";
  final String usageInformation =
      "We may collect information about how you interact with our app, including the content you view, the features you use, and your interactions with other users.";
  final String deviceInformation =
      "We may collect information about the device you use to access our app, including the device type, operating system, and unique device identifiers.";
  final String howWeUseInformation =
      "We use your information to provide you with access to our OTT app and its features, personalize your experience, and improve our services.";
}
