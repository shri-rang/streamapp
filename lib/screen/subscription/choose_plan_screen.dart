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

  @override
  void initState() {
    super.initState();
    isDark = appModeBox.get('isDark') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  return Column(
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
                            Container(
                              height: 70,
                              child: ListView.builder(
                                itemCount: data.package!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      PaidControllDialog().showPaymentDialog(
                                          context,
                                          isDark,
                                          double.parse(
                                              data.package![index].price!),
                                          data.package![index]);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(3),
                                      height: 70,
                                      width: 110,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: CustomTheme.darkGrey),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  "\$${data.package![index].price}",
                                                  textAlign: TextAlign.center,
                                                  style: CustomTheme
                                                      .bodyText1White
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  "   /${data.package![index].day} days",
                                                  textAlign: TextAlign.center,
                                                  style: CustomTheme
                                                      .bodyText1White
                                                      .copyWith(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          HelpMe().space(5),
                                          Text(
                                            data.package![index].name ?? "",
                                            style: CustomTheme.bodyText1White
                                                .copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: CustomTheme
                                                        .primaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          HelpMe().space(40),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CustomTheme.primaryColor),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "No Ads",
                                style: CustomTheme.bodyText2.copyWith(
                                    color:
                                        isDark ? Colors.white : Colors.black),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CustomTheme.primaryColor),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Unlimited screens",
                                style: CustomTheme.bodyText2.copyWith(
                                    color:
                                        isDark ? Colors.white : Colors.black),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CustomTheme.primaryColor),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Download Access",
                                style: CustomTheme.bodyText2.copyWith(
                                    color:
                                        isDark ? Colors.white : Colors.black),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CustomTheme.primaryColor),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "All premium movies and series",
                                style: CustomTheme.bodyText2.copyWith(
                                    color:
                                        isDark ? Colors.white : Colors.black),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CustomTheme.primaryColor),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "All premium live TV channels",
                                style: CustomTheme.bodyText2.copyWith(
                                    color:
                                        isDark ? Colors.white : Colors.black),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  );
                } else {
                  return LoadingIndicator();
                }
              }),
        ));
  }
}
