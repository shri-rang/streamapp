import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../config.dart';
import '../../strings.dart';
import '../../style/theme.dart';

class Terms extends StatelessWidget {
  static final String route = "Terms";
  String _url = Config.termsPolicyUrl;
  bool isLoading = true;
  static bool isDark = Hive.box('appModeBox').get('isDark') ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(AppContent.terms_conditions),
            backgroundColor: CustomTheme.amber_800
            //  isDark ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
            ),
        body: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildContent(
                    "The following Terms of Use (“Terms of Use” or “Terms and Conditions”, “Agreement”) "
                    "apply to all users of Yellow and its associated websites, portals, domains, subdomains, "
                    "mobile versions, any associated applications and services (collectively, the “Site”), "
                    "which is operated by Apex Multimedia Solutions (“Company,” “us” or “we”).\n\n"
                    "Before Using The Site, Kindly Read The Following Terms And Conditions Carefully As "
                    "They Effect Your Rights, By Registering With The Site Or By Availing Our Services, "
                    "You Hereby Acknowledge That You Have Read, Understood, And Agree To Be Bound By The "
                    "Following Terms Of Use, Privacy Policy And Any Other Policy As Mentioned Herewith And "
                    "Any Future Modifications That Might Take Place. If At Any Time You Do Not Agree To These "
                    "Terms Of Use, Kindly Terminate Your Use Of The Site Immediately."),
                buildSectionTitle("1. ACCEPTANCE OF TERMS"),
                buildContent(
                    "Yellow is a Subscription-based Video on Demand Platform that offers a wide variety of "
                    "audio-visual contents, including but not limited to web series, short films, trailer clips, "
                    "and various other content of different genres from horror, suspense thriller, drama, comedy "
                    "and many more. Use of the Services (including access to the Content, Live Streaming Services, "
                    "Chat with celebrities) is subject to compliance with the Terms of Use and our Privacy Policy. "
                    "Please read the Privacy Policy carefully for information relating to Company’s collection, use "
                    "and disclosure of your personal information. Company reserves the right, at our discretion, to "
                    "modify, alter, add or remove clauses of these Terms at any time for any reason, and would update "
                    "the same in our policies. All changes shall be effective immediately. Kindly check the Terms of use/Policies "
                    "periodically for the latest update. Your use of the Site after the posting of changes shall constitute "
                    "your binding acceptance of such changes. Be sure to review this Agreement periodically to ensure your "
                    "familiarity with the most current version. Please note that these Terms of Use apply to all users of "
                    "Yellow APP and website may contain links to third party websites that are not owned or controlled by us. "
                    "We have no control over, and assume no responsibility for the content, privacy policies, or practices of "
                    "any third-party websites. In addition, we will not and cannot censor or edit the content of any third-party website. "
                    "By using the Website, you expressly relieve us from any and all liability arising from your use of any third-party content. "
                    "Accordingly, we encourage you to be aware when you visit or leave the Yellow APP and/or Website to read the terms and conditions "
                    "and privacy policy of each other content/website that you visit."),
                buildContent(
                    "Terms for using and/or viewing videos/text/images on the Yellow APP and on its website and any software, products, "
                    "and services offered or contained through this App or website are provided on an 'as is' basis and on an 'as available' "
                    "basis. Yellow makes no representations or warranties of any kind with respect to its contents, software or such products "
                    "and services, and disclaim all such representation and warranties, including, without limitation, warranties of merchantability "
                    "and fitness for a particular purpose, non-infringement of third party rights, error-free or uninterrupted service, accuracy, "
                    "availability, reliability, security, currency, and completeness arising from or relating to its content, software, tools, tips, product or services. "
                    "This Agreement/Terms of Use sets forth the legally binding Terms of Your Use of our APP / website and its services located at URL https://www.yellowapp.in/ and Yellow APP."),
                buildContent(
                    "You must access and use the Services only if You can form a binding contract with Us and are not a person barred from receiving "
                    "services under the laws of India or other applicable jurisdiction. If You are accepting these Terms of Use and using the Services "
                    "on behalf of a company, organization, government, or other legal entity, you represent and warrant that You are authorized to do so. "
                    "You may use the Services only in compliance with our terms of use, Age Suitability Terms, Privacy Policy, all applicable local, state, national, and international laws, rules and regulations."),
                buildSectionTitle("2. OWNERSHIP AND PROPRIETARY RIGHTS"),
                buildContent(
                    "The site and APP including all content graphics, design, visual interfaces, audio, video, digital content, proprietary information, "
                    "all copyrights, patents, trademarks, service marks, trade names and all other intellectual property rights therein are owned by Yellow "
                    "and/or its licensors or group companies and are protected by applicable Indian and international copyright and other intellectual property laws. "
                    "You acknowledge, understand and agree that you shall not have, nor be entitled to claim, any rights in and to the website/ application content/ "
                    "services and/or any portion thereof. You agree not to copy, reproduce, duplicate, stream, capture, print, archive, upload, download, publish, "
                    "broadcast, sell, resell, edit, modify, manipulate, translate, decompile, disassemble, reverse engineer or exploit for any purposes the content or "
                    "any portion of website/ application, including, without limitation, the content and the marks, except as authorized by these terms of use or as "
                    "otherwise authorized in writing by YELLOW."),
                buildContent(
                    "In addition, you are strictly prohibited from creating derivative works, or materials that otherwise are derived from or based on in any way the content and the marks, "
                    "including montages, mash-ups and similar videos, wallpaper, desktop themes, e-cards, greeting cards, and merchandise, except as authorized by these terms of use or as "
                    "otherwise authorized in writing by YELLOW. You must abide by all copyright notices, information, and restrictions contained in or associated with any content. "
                    "You must not remove, alter, interfere with, or circumvent any copyright, trademark, or other proprietary notices marked on the content or any digital rights "
                    "management mechanism, device or other content protection or access control measure (including, without limitation, geo-filtering and/or encryption) associated with the content. "
                    "You hereby agree that all intellectual property rights, title, and interest in the user-generated content published or generated on website/application by you shall vest with YELLOW."),
                buildSectionTitle("3. CONSENT"),
                buildContent(
                    "By using and/or visiting the APP or website, (collectively, including all content available through the Yellow domain name), you signify your assent to both these terms and conditions (Terms of Use) and the terms and conditions of Yellow Policy, "
                    "which are published, and which are available on this website for reference. In addition, when using particular services provided by us such as viewing any clips, or participating in any contests, you shall be subject to any additional guidelines or rules applicable to such services. "
                    "Kindly print these terms of use or save a copy of these terms of service for your records. If you do not agree to any of these terms, then kindly do not use our website/ cease to use our services with immediate effects."),
                buildSectionTitle("4. AGE RESTRICTION"),
                buildContent(
                    "You must be at least 7 years of age to use this website / portal or any services contained herein (expect for 18+ content). By using this Website, You represent and warrant that your age is in compliance with the above mentioned age restrictions and may legally agree to these terms of use of services. "
                    "The Company assumes no responsibility or liability for any misrepresentation of your age."),
                buildSectionTitle("5. PERMISSION TO USE"),
                buildContent(
                    "We hereby grant you permission to use the APP/Website as set forth in this Terms of Use, provided that: (i) your use of the APP/ Website as permitted for entertainment purpose is solely for your personal, non-commercial, legal, ethical and non-vindictive, non-discriminatory and non-racial use; "
                    "(ii) you will not copy or distribute any part of the APP/Website in any medium without prior written authorization from us; "
                    "(iii) you will not alter or modify any part of the APP/Website other than as may be reasonably necessary to use the APP/Website for its intended purpose, subject to restrictions by us at any time either prior to or after the use, without assigning any reasons whatsoever; "
                    "(iv) you will otherwise comply with all the terms and conditions of these Terms of Use. (v) Our service and any content viewed through the service are for your personal and non-commercial use only and may not be shared with individuals beyond your household. "
                    "(vi) During your membership we grant you a limited, non-exclusive, non-transferable right to access our service and view our content. (vii) Except for the foregoing, no right, title or interest shall be transferred to you. "
                    "You agree not to use the service for public performances. You further agree not to use our packages for any illegal or unauthorized purpose nor may you, in the use of the Service, violate any laws in your jurisdiction including but not limited to copyright laws. "
                    "You must not transmit any worms or viruses or any code of a destructive nature. A breach or violation of any of the Terms will result in immediate termination of your Services and further actions and remedies as provided in law. "
                    "We shall have the discretion to make certain or all Content that is a part of the Subscription available to You on either one or limited number of end user device concurrently."),
                buildSectionTitle("6. CREATION OF ACCOUNT"),
                buildContent(
                    "In order to access some features of the APP/Website, you will have to create a Google account. Your Gmail ID would be your user ID while using our APP/web portal/website on all the devices. You may never use another’s account without consent or permission. "
                    "When creating your account, you must provide accurate and complete information. The data you provide is deemed to be considered as true and correct. "
                    "You are solely responsible for the activity that occurs on your account, and you must keep your account password secure. You must notify us immediately of any breach of security or unauthorized use of your account. "
                    "Although we will not be liable for your losses caused by any unauthorized use of your account, you may be liable for the losses and claims of Yellow or others due to such unauthorized use. "
                    "You agree not to use or launch any automated system, including without limitation, “robots, spiders, offline readers,” etc., that accesses the APP/Website in a manner that sends more request messages to our servers in a given period of time than a human can reasonably produce in the same period by using a conventional online web browser. "
                    "Notwithstanding the foregoing, we grant the operators of public search engines permission to use spiders to copy materials from the site for the sole purpose of creating publicly available searchable indices of the materials, but not caches or archives of such materials. "
                    "We reserve the right to revoke these exceptions either generally or in specific cases. You agree not to collect or harvest any personally identifiable information, including account names, from the APP/Website, nor to use the communication systems provided by the APP/Website for any commercial solicitation purposes. "
                    "You agree not to solicit, for commercial purposes, any users of the APP/Website with respect to their User Submissions."),
                buildSectionTitle("7. SUBSCRIPTION AND MEMBERSHIP FEES"),
                buildContent(
                    "Yellow offers some services for free from time to time on the web portals, but there are different plans and packages to access the service and become member that suit and cater your need. "
                    "You have to subscribe and become member by selecting a suitable package. All of our packages are excluding GST. Kindly check your plan/package and price before proceeding for paying or making any payments. "
                    "Yellow reserves the right to change the terms of subscription, including pricing and packages from time to time. "
                    "Our policies and subscription plans are user-friendly and if you wish to just watch a single episode, we provide you with the option to pay and watch that particular Episode. "
                    "Our Subscription plans are very affordable. The Subscription Fee will be billed as per Your selected Payment Method (defined hereunder) for the subscription plan/package selected by You "
                    "and on each subsequent renewal automatically (as per the subscription plan/package chosen by You) unless and until You cancel the Service, or the Service is otherwise suspended or discontinued pursuant to this Terms of Use. "
                    "It may take a few days for Your payment made to Us to be reflected in Your 'Account' section. "
                    "'Payment Method' shall mean all the approved methods as available to the Users to process and facilitate the payment of the Subscription Fee for accessing the Subscription Services. "
                    "You shall be governed by the Terms of Use and Privacy Policy of the third-party payment gateways/service providers, engaged to process and facilitate the payment of the Subscription Fee for accessing the Subscription Services."),
                buildContent(
                    "You are responsible for the accuracy and authenticity of the information provided by You, including the bank account number/credit card details and any other information requested by the payment gateway service provider during the subscription process. "
                    "We further clarify that We do not receive or collect any of Your financial information including bank account number, credit card and/or debit card number, one-time-password sent by Your bank, passwords, bank customer IDs etc., "
                    "and will not be responsible for misuse of such information by anyone. You agree and acknowledge that We shall not be liable and in no way be held responsible for any losses whatsoever, "
                    "whether direct, indirect, incidental or consequential, including without limitation any losses due to delay in processing of payment instruction or any credit card/debit card/banking fraud. "
                    "You can file any complaint related to payment processing by writing to the third-party payment gateway/payment processing service provider, on the email provided by them."),
                buildSectionTitle("8. CANCELLATION AND REFUNDS"),
                buildContent(
                    "Payments are non-refundable. Kindly check the package that suits you best and then make the payment. The package that you select cannot be altered or modified. "
                    "We request you to carefully select the plan and make the payment. After the payment is through, the package/plan selected cannot be altered. "
                    "If you cancel or modify your subscription, or if your account is otherwise terminated under these Terms, you will not receive a refund/credit, including for partially used periods of Service. "
                    "We do not provide price protection or refunds in the event of a price drop or promotional offering. Yellow however may review the circumstances on a case-to-case basis but the decision would be of Yellow sole and absolute discretion."),
                buildContent(
                    "We, being the service providers for contents available through SITE or APP, where you are expected to view packages of your choice after being paid for subscription; unfortunately, all fees to Yellow for such services are non-refundable. "
                    "In case because of any technical glitch at the time of online transaction the transaction does not occur, the amount in process of transfer by default goes back into your bank account, automatically through Payment Gateway. "
                    "Any and all payments made under the Terms of Use are non-refundable, and we do not provide refunds or credits for any partial-month subscription periods for any and all reason. "
                    "Except if You have reason to believe that Your Account details have been obtained by another without consent. In such an event, you should immediately contact the third-party payment gateway/payment processing service provider (on the email provided by them) for resolution."),
                buildSectionTitle("9. AVAILABILITY & QUALITY"),
                buildContent(
                    "The availability of content(s) to view through Website/Application will change from time to time at the sole discretion of Us. "
                    "The quality of the display of the streaming video may vary from computer to computer, and device to device, and may be affected by a variety of factors, "
                    "such as your location, the bandwidth available through and/or speed of your internet connection, and/or quality of user’s hardware. "
                    "You are responsible for all internet access charges. Please check with your internet provider for information on possible internet data usage charges."),
                buildSectionTitle("10. LIMITATION OF LIABILITY"),
                buildContent(
                    "In no event shall Yellow or its officers, directors, employees, or agents, be liable to you for any direct, indirect, incidental, special, punitive, or consequential damages whatsoever resulting from any (i) errors, mistakes, or inaccuracies of content, "
                    "(ii) personal injury or property damage, of any nature whatsoever, resulting from your access to and use of our APP/website, "
                    "(iii) any unauthorized access to or use of our secure servers and/or any and all personal information and/or financial information stored therein, "
                    "(iv) any interruption or cessation of transmission to or from our APP/Website, (iv) any bugs, viruses, Trojan horses, or the like, which may be transmitted to or through our APP/Website by any third party, and/or "
                    "(v) any errors or omissions in any content or for any loss or damage of any kind incurred as a result of your use of any content posted, emailed, transmitted, or otherwise made available via our APP/Website, whether based on warranty, contract, tort, or any other legal theory, and whether or not the company/owner of our APP/Website is advised of the possibility of such damages. "
                    "The foregoing limitation of liability shall apply to the fullest extent permitted by law in the applicable jurisdiction. "
                    "You specifically acknowledge that we shall not be liable for user submissions, content or the defamatory, offensive, or illegal conduct of any third party and that the risk of harm or damage from the foregoing rests entirely with you. "
                    "The APP/Website is controlled and offered by us from its facilities in India. We make no representations that the APP/Website is appropriate or available for use in other locations. "
                    "Those who access or use the APP/Website from other jurisdictions do so at their own volition and are responsible for compliance with local law."),
                buildSectionTitle("11. INDEMNITY"),
                buildContent(
                    "You agree to defend, indemnify and hold harmless Yellow, its parent company, subsidiary company, associate, affiliates, partners, corporation, officers, directors, employees and agents, from and against any and all claims, damages, obligations, losses, liabilities, costs or debt, and expenses (including but not limited to attorney’s fees) arising from: "
                    "(i) your use of and access to us (ii) your violation of any term of these Terms of Service; "
                    "(iii) your violation of any third party right, including without limitation any copyright, property, or privacy right; or "
                    "(iv) any claim that one of your User Submissions caused damage to a third party. "
                    "This defense and indemnification obligation will survive these Terms of Use and your use of our APP/Website."),
                buildSectionTitle("12. WAIVER"),
                buildContent(
                    "A provision of these Terms of Use may be waived only by a written instrument executed by the party entitled to the benefit of such provision. "
                    "The failure of Company to exercise or enforce any right or provision of these Terms and Conditions will not constitute a waiver of such right or provision."),
                buildSectionTitle("13. SEVERABILITY"),
                buildContent(
                    "If any provision of these Terms shall be unlawful, void, or for any reason unenforceable, then that provision shall be deemed severable from these Terms and shall not affect the validity and enforceability of any remaining provisions."),
                buildSectionTitle("14. ASSIGNMENT"),
                buildContent(
                    "These Terms of Service, and any rights and licenses granted hereunder, may not be transferred or assigned by you, but may be assigned by us without restriction."),
                buildSectionTitle("15. GOVERNING LAWS AND JURISDICTION"),
                buildContent(
                    "You agree that: (i) Yellow shall be deemed solely based in India; and (ii) Yellow Website and the Yellow APP shall be deemed a passive Website / APP that does not give rise to personal jurisdiction either specific or general, in jurisdictions other than Mumbai, India. "
                    "The internal substantive laws of India, without respect to its conflict of laws principles, shall govern these Terms of Use. "
                    "Any claim or dispute between you and Sol that arises in whole or in part from the Yellow APP or Website shall be decided exclusively by an arbitrator decided by Us under its procedures and will be decided as per the provisions of the Indian Arbitration and Conciliation Act of 1996, which will be held in Mumbai. "
                    "The Courts located in Mumbai; India will have exclusive jurisdiction over any decisions of the arbitrator. "
                    "These Terms of Services/Use, together with the Privacy Policy at the Yellow APP and Website and any other legal notices published by Sol on their APP/Website, shall constitute the entire agreement between you and Yellow concerning the APP/Website. "
                    "You agree that any cause of action arising out of or related to our app/website must commence within one (1) year after the cause of action accrues. Otherwise, such a cause of action is permanently barred. "
                    "We reserve the right to amend these Terms of Use at any time and without notice, and it is your responsibility to review these Terms of Service for any changes."),
              ],
            ),
          ),
        )
        //   WebView(
        //   initialUrl: _url,
        // ),
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
    // final String personalInformation =
    //     "When you register an account, we may collect personal information such as your name, email address, date of birth, and payment information.";
    // final String usageInformation =
    //     "We may collect information about how you interact with our app, including the content you view, the features you use, and your interactions with other users.";
    // final String deviceInformation =
    //     "We may collect information about the device you use to access our app, including the device type, operating system, and unique device identifiers.";
    // final String howWeUseInformation =
    //     "We use your information to provide you with access to our OTT app and its features, personalize your experience, and improve our services.";
  }
}
