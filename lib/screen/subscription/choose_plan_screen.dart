import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:oxoo/models/all_package_model.dart';
import 'package:oxoo/server/repository.dart';
import 'package:oxoo/strings.dart';
import 'package:oxoo/style/theme.dart';
import 'package:oxoo/utils/button_widget.dart';
import 'package:oxoo/utils/loadingIndicator.dart';
import 'package:oxoo/widgets/movie/paid_controll_dialog.dart';

class ChoosePlanScreen extends StatefulWidget {
  const ChoosePlanScreen({super.key});

  @override
  State<ChoosePlanScreen> createState() => _ChoosePlanScreenState();
}

class _ChoosePlanScreenState extends State<ChoosePlanScreen> {
  var appModeBox = Hive.box('appModeBox');
  bool isDark = true;
  int? selectedIndex;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    isDark = appModeBox.get('isDark') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        backgroundColor:
            isDark ? CustomTheme.colorAccentDark : CustomTheme.whiteColor,
        appBar: AppBar(
          backgroundColor: CustomTheme.primaryColor,
          title: Text(AppContent.chooseAPlan),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<AllPackageModel?>(
              future: Repository().getAllPackageData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  var data = snapshot.data;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              AppContent.planIntro,
                              textAlign: TextAlign.center,
                              style: isDark
                                  ? CustomTheme.bodyText2White.copyWith(
                                      fontWeight: FontWeight.normal, fontSize: 12)
                                  : CustomTheme.bodyText2.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12),
                            ),
                            HelpMe().space(10),
                            if (data!.package != null)
                             ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.package!.length,
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        selectedIndex = index;
                                        setState(() {});
                                        PaidControllDialog().showPaymentDialog(
                                            _scaffoldKey.currentContext!,
                                            isDark,
                                            double.parse(
                                                data.package![index].price!),
                                            data.package![index]);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(3),
                                        height: 194,
                                        width: 350,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: selectedIndex == index
                                                    ? 2
                                                    : 0,
                                                color: selectedIndex == index
                                                    ? CustomTheme.primaryColor
                                                    : Colors.transparent),
                                            color: CustomTheme.darkGrey),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              data.package![index].name ?? "",
                                              style: CustomTheme.bodyText2White
                                                  .copyWith(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      color: CustomTheme
                                                          .primaryColor),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                FittedBox(
                                                  child: Text(
                                                    "\₹${data.package![index].price}",
                                                    textAlign: TextAlign.center,
                                                    style: CustomTheme
                                                        .bodyText1White
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                  ),
                                                ),
                                                FittedBox(
                                                  child: Text(
                                                    "   /  ${data.package![index].day} days",
                                                    textAlign: TextAlign.center,
                                                    style: CustomTheme
                                                        .bodyText1White
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            HelpMe().space(5),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 20),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 10,
                                                    width: 10,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: CustomTheme
                                                            .primaryColor),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "No Ads",
                                                    style: CustomTheme
                                                        .bodyText1BoldWhite
                                                        .copyWith(
                                                            fontSize: 13,
                                                            color: isDark
                                                                ? Colors.white
                                                                : Colors.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 20),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 10,
                                                    width: 10,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: CustomTheme
                                                            .primaryColor),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "Unlimited screens",
                                                    style: CustomTheme
                                                        .bodyText1BoldWhite
                                                        .copyWith(
                                                            fontSize: 13,
                                                            color: isDark
                                                                ? Colors.white
                                                                : Colors.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 20),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 10,
                                                    width: 10,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: CustomTheme
                                                            .primaryColor),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "Download Access",
                                                    style: CustomTheme
                                                        .bodyText1BoldWhite
                                                        .copyWith(
                                                            fontSize: 13,
                                                            color: isDark
                                                                ? Colors.white
                                                                : Colors.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 20),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 10,
                                                    width: 10,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: CustomTheme
                                                            .primaryColor),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "All premium movies and series",
                                                    style: CustomTheme
                                                        .bodyText1BoldWhite
                                                        .copyWith(
                                                            fontSize: 13,
                                                            color: isDark
                                                                ? Colors.white
                                                                : Colors.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 20),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 10,
                                                    width: 10,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: CustomTheme
                                                            .primaryColor),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "All premium live TV channels",
                                                    style: CustomTheme
                                                        .bodyText1BoldWhite
                                                        .copyWith(
                                                            fontSize: 13,
                                                            color: isDark
                                                                ? Colors.white
                                                                : Colors.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                            HelpMe().space(5),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                    
                            
                            HelpMe().space(40),
                      
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return LoadingIndicator();
                }
              }),
        ));
  }
}
