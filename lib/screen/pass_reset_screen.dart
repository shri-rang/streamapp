import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oxoo/colors.dart';
import 'package:oxoo/pages/CoontinuePage.dart';
import '../../models/password_reset_model.dart';
import 'package:hive/hive.dart';
import '../../constants.dart';
import '../../style/theme.dart';
import '../../utils/button_widget.dart';
import '../../utils/edit_text_utils.dart';
import '../../utils/validators.dart';
import '../server/repository.dart';
import '../strings.dart';
import '../utils/loadingIndicator.dart';

class ResetPassword extends StatefulWidget {
  static final String route = '/ResetPassword';
  ResetPassword({Key? key}) : super(key: key);
  @override
  _ResetPasswordState createState() => new _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController resetPassEmailController = new TextEditingController();
  late bool isDark;
  bool isLoading = false;
  var appModeBox = Hive.box('appModeBox');

  @override
  void initState() {
    super.initState();
    isDark = appModeBox.get('isDark') ?? false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    printLog("_ResetPasswordState");
    return new Scaffold(
        // backgroundColor: orange,
        key: _scaffoldKey,
        // appBar: AppBar(
        //   elevation: 1.0,
        //   backgroundColor: isDark ? CustomTheme.primaryColor : CustomTheme.primaryColor,
        //   title: Text(AppContent.resetPassword),
        // ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          // height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.center,
            //   end: Alignment.bottomCenter,
            //   // stops: [0.1, 0.5, 0.7, 0.9],
            //   colors: [orange, red],
            // ),
          ),
          // color: isDark ? CustomTheme.whiteColor : CustomTheme.whiteColor,
          child: SingleChildScrollView(
              child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  // Container(
                  //   height: MediaQuery.of(context).size.height / 2.2,
                  //   decoration: BoxDecoration(
                  //       color: isDark
                  //           ? CustomTheme.primaryColor
                  //           : CustomTheme.primaryColor),
                  // ),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Container(
                          // margin: EdgeInsets.only(
                          //     bottom: 30.0, left: 10.0, right: 10.0),
                          // decoration: new BoxDecoration(
                          //   borderRadius:
                          //       BorderRadius.all(Radius.circular(10.0)),
                          //   boxShadow: CustomTheme.boxShadow,
                          //   color: isDark ? Colors.white : Colors.white,
                          // ),
                          // height: 310,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 250.0),
                              Text(AppContent.resetPassword,
                                  style: TextStyle(
                                       fontFamily: 'Sans Serif',
                                      color: Colors.white,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold)
                                  // CustomTheme.authTitle,
                                  ),
                              SizedBox(height: 25.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      EditTextUtils().getCustomEditTextField(
                                          hintValue: AppContent.emailAddress,
                                          lableText:
                                              "Enter your reset password here",
                                          prefixWidget: Icon(
                                            Icons.lock,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: resetPassEmailController,
                                          style: isDark
                                              ? CustomTheme.authTitle
                                              : CustomTheme.authTitle,
                                          underLineInputBorderColor: isDark
                                              ? CustomTheme.primaryColor
                                              : CustomTheme.primaryColor,
                                          validator: (value) {
                                            return validateEmail(value);
                                          }),
                                      SizedBox(height: 20),
                                      Text(
                                        AppContent.resetNote,
                                        style: TextStyle(
                                           fontFamily: 'Sans Serif',
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          // color: Colors.amber
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              HelpMe().space(10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: PrimaryButton(
                                  title: "Reset Password",
                                  width: double.infinity,
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      isLoading = true;
                                      PasswordResetModel? passwordResetModel =
                                          await Repository().passwordReset(
                                              userEmail:
                                                  resetPassEmailController
                                                      .text);
                                      if (passwordResetModel != null)
                                        showShortToast(
                                            passwordResetModel.message!);
                                      isLoading = false;
                                    }
                                  },
                                  // screenWidth * .8,
                                  height: 50,
                                ),
                              ),
                              // ButtonTheme(
                              //   minWidth: 320.0,
                              //   child: ElevatedButton(
                              //     style: ElevatedButton.styleFrom(
                              //       backgroundColor: CustomTheme.primaryColor,
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(20.0),
                              //       ),
                              //     ),
                              //     onPressed: () async {
                              //       if (_formKey.currentState!.validate()) {
                              //         isLoading = true;
                              //         PasswordResetModel? passwordResetModel =
                              //             await Repository().passwordReset(
                              //                 userEmail:
                              //                     resetPassEmailController
                              //                         .text);
                              //         if (passwordResetModel != null)
                              //           showShortToast(
                              //               passwordResetModel.message!);
                              //         isLoading = false;
                              //       }
                              //     },
                              //     child: Padding(
                              //       padding: const EdgeInsets.symmetric(
                              //           vertical: 15.0, horizontal: 20.0),
                              //       child: Text(
                              //         AppContent.send,
                              //         style: TextStyle(color: Colors.white),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                height: 8.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (isLoading) Center(child: spinkit),
            ],
          )),
        ));
  }
}
