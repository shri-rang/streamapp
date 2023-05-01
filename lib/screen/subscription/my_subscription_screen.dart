import 'package:flutter/material.dart';
import 'package:oxoo/models/active_subscription.dart';
import 'package:oxoo/screen/subscription/choose_plan_screen.dart';
import 'package:oxoo/server/repository.dart';
import '../../screen/subscription/premium_subscription_screen.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../models/user_model.dart';
import '../../service/authentication_service.dart';
import '../../strings.dart';
import '../../style/theme.dart';
import '../../utils/button_widget.dart';
import '../../constants.dart';

class MySubscriptionScreen extends StatefulWidget {
  static final String route = "/MySubscriptionScreen";
  @override
  _MySubscriptionScreenState createState() => _MySubscriptionScreenState();
}

class _MySubscriptionScreenState extends State<MySubscriptionScreen> {
  late bool isDark;
  var appModeBox = Hive.box('appModeBox');

  @override
  initState() {
    super.initState();
    isDark = appModeBox.get('isDark') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    printLog("_MySubscriptionScreenState");
    final authService = Provider.of<AuthService>(context);
    AuthUser authUser = authService.getUser()!;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppContent.mySubsCription),
        backgroundColor:
            isDark ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
      ),
      body: authService.getUser() != null
          ? FutureBuilder<ActiveSubscription?>(
              future: Repository().getActiveSubscription(authUser.userId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null) {
                  ActiveSubscription subscription = snapshot.data!;
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    color: isDark ? CustomTheme.primaryColorDark : Colors.white,
                    child: Column(
                      children: [
                        _space(20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${AppContent.userName}${authUser.name}",
                                style: isDark
                                    ? CustomTheme.bodyText3White
                                    : CustomTheme.bodyText3,
                              ),
                              _space(4),
                              Text(
                                "${AppContent.email}${authUser.email}",
                                style: isDark
                                    ? CustomTheme.bodyText3White
                                    : CustomTheme.bodyText3,
                              ),
                              _space(4),
                              Text(
                                "Package: ${subscription.packageTitle}",
                                style: isDark
                                    ? CustomTheme.bodyText3White
                                    : CustomTheme.bodyText3,
                              ),
                              _space(4),
                              Text(
                                "Expire date: ${subscription.expireData}",
                                style: isDark
                                    ? CustomTheme.bodyText3White
                                    : CustomTheme.bodyText3,
                              ),
                            ],
                          ),
                        ),
                        _space(40),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChoosePlanScreen(),
                                  ));
                            },
                            child: HelpMe()
                                .submitButton(300, AppContent.upgradePurchase)),
                      ],
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  _space(double space) {
    return SizedBox(height: space);
  }
}
