import 'package:flutter/material.dart';
import '../../style/theme.dart';
import 'package:hive/hive.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../config.dart';
import '../strings.dart';

// ignore: must_be_immutable
class TermsPolices extends StatelessWidget {
  static final String route = "TermsPolices";
  String _url = Config.termsPolicyUrl;
  bool isLoading = true;
  static bool isDark = Hive.box('appModeBox').get('isDark') ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppContent.termsPolicy),
          backgroundColor:
              isDark ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
        ),
        body: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you use our app.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Information We Collect:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '- Personal Information: ${personalInformation}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  '- Usage Information: ${usageInformation}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  '- Device Information: ${deviceInformation}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'How We Use Your Information:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${howWeUseInformation}',
                  style: TextStyle(fontSize: 16),
                ),
                // Add more sections as needed...

                SizedBox(height: 20),
                Text(
                  'Changes to this Privacy Policy:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.',
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
