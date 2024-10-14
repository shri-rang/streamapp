import 'package:flutter/material.dart';

class Policy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildContent(
                "This Privacy Policy (“Privacy Policy”) applies to Yellow Site/App platforms and other related Site/s or App/s, mobile applications and other online features each a “Site/s or App/s.” "
                "This Privacy Policy describes how and when we collect, process, use, and share your information when you use our services/platforms, including our mobile applications and websites (the \"Services\"). "
                "This Privacy Policy should be read in conjunction with the Terms of Use available on the “Site/s or App/s.” Personal Information/Data defined below of a user/s is collected if the user/s registers with the Site/s or App/s, "
                "accesses the Site/s or App/s, takes any action on the Site/s or App/s, or uses or accesses the Services as defined in the Terms of Use. "
                "The terms ‘Personal Information’ and ‘Sensitive Personal Information or Information’ shall have the meaning ascribed to it under the Indian Information Technology Act, 2000."),
            buildSectionTitle("1. WHAT DO WE DO WITH YOUR INFORMATION?"),
            buildContent(
                "When you subscribe for any of our Services or register with us, we collect the personal information that you give us, such as your name, address, and email address. "
                "When you browse our packages/Services, we also automatically receive your computer’s internet protocol (IP) address in order to provide us with information that helps us learn about your browser and operating system. "
                "With your permission, we may send you emails about our store, new products, and other updates."),
            buildContent(
                "We use Personal Information to facilitate and improve our Services and communicate with you following existing regulations, while data integrity, accuracy, relevancy, and legally justified processing are ensured. "
                "The data we collect depends on the context of your interactions with us, the choices you make, including your privacy settings, and the products and features listed below (collectively “Personal Information” or “Personal Data”)."),
            buildContent(
                "The general data we collect can include SDK/API/JS code version, browser, Internet service provider, IP address, platform, timestamp, application identifier, application version, application distribution channel, independent device identifier, "
                "Android ad master identifier, network card (MAC) address, and international mobile device identification code (IMEI), equipment model, terminal manufacturer, terminal device operating system version, session start/stop time, location, language, "
                "time zone, and network state (WiFi, etc.)."),
            buildContent(
                "In addition to profile information, you may also tell us your exact location if you choose to enable your computer or mobile device to send us location information. "
                "We may use and store information about your location to manage content copyright and exploitation restrictions applicable to your location and to improve and customize the Services. "
                "We do not store the data for more than a period of 1 year."),
            buildContent(
                "We do not collect the 'Personal Information' which can identify you or another person. We may collect non-personal identification information about Users whenever they interact with our apps. "
                "Non-personal identification information may include the type of your phone, apps, and other technical information about Users' means of connection to our apps, such as the versions of phone model and other similar information."),
            buildSectionTitle("2. SENSITIVE PERSONAL DATA AND INFORMATION:"),
            buildContent(
                "We will never ask you, and you must never provide sensitive personal details and information. We will never ask you and you must never provide Sensitive Personal Data or Information to Us or to any person/entity representing Us. "
                "Any disclosure of Sensitive Personal Data or Information shall be at your sole risk and without our liability (including its directors, key managerial personnel, officers, and employees) in whatsoever manner."),
            buildContent(
                "You understand, acknowledge, and agree that we or any other person acting on behalf of us shall not in any manner be responsible for the authenticity of the Personal Information or Sensitive Personal Data or Information provided by you to us."),
            buildContent(
                "You must note that any information that is freely available or accessible in the public domain shall not be regarded as Personal Information or Sensitive Personal Data or Information for the purposes of this Privacy Policy, and we shall not be obliged to take any measures to protect the same since the same is freely available in the public domain. "
                "Please further note that identity theft and the practice currently known as 'phishing' are of great concern to us. "
                "We do not and will not, at any time, request your credit card information/debit card information/financial pin numbers and passwords."),
            buildSectionTitle("3. CONSENT:"),
            buildContent(
                "The moment you provide us with personal information to complete a transaction, verify your credit card, we imply that you consent to our collecting it and using it for that specific legitimate reason only."),
            buildSectionTitle("4. DISCLOSURE:"),
            buildContent(
                "We may disclose your personal information if we are required by law to do so or if you violate our Terms of Use."),
            buildSectionTitle("5. THIRD-PARTY SERVICES:"),
            buildContent(
                "In general, the third-party providers used by us will only collect, use, and disclose your information to the extent necessary to allow them to perform the services they provide to us. "
                "However, certain third-party service providers, such as payment gateways and other payment transaction processors, have their own privacy policies in respect to the information we are required to provide to them for your purchase-related transactions."),
            buildContent(
                "For these providers, we recommend that you read their privacy policies so you can understand the manner in which your personal information will be handled by these providers. "
                "Once you leave our store’s website or are redirected to a third-party website or application, you are no longer governed by this Privacy Policy or our website’s Terms of Service."),
            buildSectionTitle("6. LIMITED LIABILITY:"),
            buildContent(
                "Security of your Personal Information is of paramount importance for us, and we want the same to be as safe as possible while using and accessing our Services. "
                "To this extent, we have implemented reasonable technical safeguards to protect your Personal Information. "
                "Whilst we will take all the reasonable steps to protect your Personal Information against potential risks and exposures, there is no absolute security in the online/internet sphere as known to the public."),
            buildContent(
                "Therefore, you must not disclose any information on our Services that is Sensitive Personal Data or Information. You understand that the transmission of information over the internet is not completely secure and there are risks associated with it. "
                "Although we strive to protect your personal information, we cannot guarantee the security of the same while it is being transmitted to our Services and any transmission is at your own risk."),
            buildSectionTitle("7. LINKS:"),
            buildContent(
                "When you click on links on our website for subscription, they may direct you away from our site. "
                "We are not responsible for the privacy practices of other sites and we encourage you to read their privacy statements."),
            buildSectionTitle("8. SECURITY:"),
            buildContent(
                "To protect your personal information, we take reasonable precautions and follow industry best practices to make sure it is not inappropriately lost, misused, accessed, disclosed, altered, or destroyed."),
            buildSectionTitle("9. COOKIES:"),
            buildContent(
                "We use cookies to maintain session of user/s. It is not used to personally identify you on other websites."),
            buildSectionTitle("10. AGE OF CONSENT:"),
            buildContent(
                "By using this site for 18+ content/tab, you represent that you are at least the age of majority in your state or province of residence, or that you are the age of majority in your state or province of residence and you have given us your consent to allow any of your minor dependents to use this site."),
            buildSectionTitle("11. CHANGES TO THIS PRIVACY POLICY:"),
            buildContent(
                "We reserve the right to modify this privacy policy at any time, so please review it frequently. Changes and clarifications will take effect immediately upon their posting on the website. "
                "If our APP is acquired or merged with another company, your information may be transferred to the new owners so that we may continue to provide services to you."),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
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
