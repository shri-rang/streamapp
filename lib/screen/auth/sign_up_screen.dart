import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxoo/pages/CoontinuePage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import '../../colors.dart';
import '../../constants.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../bloc/auth/registration_bloc.dart';
import '../../bloc/auth/registration_event.dart';
import '../../bloc/auth/registration_state.dart';
import '../../models/user_model.dart';
import '../../screen/landing_screen.dart';
import '../../service/authentication_service.dart';
import '../../style/theme.dart';
import '../../utils/edit_text_utils.dart';
import '../../utils/validators.dart';
import '../../strings.dart';

class SignUpScreen extends StatefulWidget {
  static final String route = '/SignUpScreen';
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _signUpFormkey = GlobalKey<FormState>();
  TextEditingController loginNameController = new TextEditingController();
  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();
  late bool _isRegistered;
  late Bloc bloc;
  Bloc? firebaseAuthBloc;
  bool isMandatoryLogin = false;
  bool isLoading = false;
  late bool isDark;
  var appModeBox = Hive.box('appModeBox');

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<RegistrationBloc>(context);
    isDark = appModeBox.get('isDark') ?? false;
    isDark = false;
    _isRegistered = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    printLog("_SignUpScreenState");
    final authService = Provider.of<AuthService>(context);

    ///read user data from phone(flutter hive box)
    _isRegistered = authService.getUser() != null ? true : false;
    return new Scaffold(
      key: _scaffoldKey,
      body:
          _isRegistered ? LandingScreen() : _renderRegisterWidget(authService),
    );
  }

  Widget _renderRegisterWidget(authService) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationStateCompleted) {
          isLoading = false;
          AuthUser? user = state.getUser;
          if (user == null) {
            print("user is null");
            bloc.add(RegistrationFailed());
          } else {
            authService.updateUser(user);
            //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LandingScreen()), (Route<dynamic> route) => false);
          }
          if (authService.getUser() != null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LandingScreen()),
                (Route<dynamic> route) => false);
          }
        }
      },
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          return Scaffold(
            // backgroundColor: orange,
            // appBar: AppBar(
            //   elevation: 1.0,
            //   backgroundColor: isDark ? CustomTheme.darkGrey : CustomTheme.primaryColor,
            //   title: Text(AppContent.backToLogin),
            // ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              //  height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment.center,
                  //   end: Alignment.bottomCenter,
                  //   // stops: [0.1, 0.5, 0.7, 0.9],
                  //   colors: [orange, red],
                  // ),
                  ),
              child: SingleChildScrollView(
                  child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 23.0),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 240,
                                    ),
                                    Center(
                                      child: Text(
                                        "SIGN UP",
                                        style: TextStyle(
                                            fontFamily: 'Sans Serif',
                                            color: purple,
                                            fontSize: 30.sp,
                                            // color: Colors.white,
                                            // fontSize: 28,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                      ),
                                      child: Form(
                                        key: _signUpFormkey,
                                        child: Column(
                                          children: <Widget>[
                                            EditTextUtils()
                                                .getCustomEditTextField(
                                                    inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                          RegExp("[0-9a-zA-Z]"))
                                                ],
                                                    lableText:
                                                        "Enter your name here",
                                                    prefixWidget: Icon(
                                                      Icons.person,
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                    ),
                                                    hintValue:
                                                        AppContent.fullName,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    controller:
                                                        loginNameController,
                                                    style: isDark
                                                        ? CustomTheme
                                                            .authTitleGrey
                                                        : CustomTheme.authTitle,
                                                    // underLineInputBorderColor:
                                                    //     isDark
                                                    //         ? CustomTheme
                                                    //             .grey_transparent2
                                                    //         : CustomTheme
                                                    //             .primaryColor,
                                                    validator: (value) {
                                                      return validateNotEmpty(
                                                          value);
                                                    }),
                                            SizedBox(height: 10),
                                            EditTextUtils()
                                                .getCustomEditTextField(
                                                    maxLength: 10,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    lableText:
                                                        "Enter your moblie no here",
                                                    hintValue:
                                                        AppContent.emailAddress,
                                                    prefixWidget: Icon(
                                                      Icons.phone,
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                    ),
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    style: isDark
                                                        ? CustomTheme
                                                            .authTitleGrey
                                                        : CustomTheme.authTitle,
                                                    underLineInputBorderColor:
                                                        isDark
                                                            ? CustomTheme
                                                                .grey_transparent2
                                                            : CustomTheme
                                                                .primaryColor,
                                                    controller:
                                                        loginEmailController,
                                                    validator: (value) {
                                                      // return
                                                      // validateEmail(
                                                      //     value);
                                                    }),
                                            SizedBox(height: 10),
                                            // EditTextUtils()
                                            //     .getCustomEditTextField(
                                            //         lableText:
                                            //             "Enter your password here",
                                            //         prefixWidget: Icon(
                                            //           Icons.lock,
                                            //           color: Colors.white
                                            //               .withOpacity(0.5),
                                            //         ),
                                            //         hintValue:
                                            //             AppContent.password,
                                            //         keyboardType:
                                            //             TextInputType.text,
                                            //         style: isDark
                                            //             ? CustomTheme
                                            //                 .authTitleGrey
                                            //             : CustomTheme.authTitle,
                                            //         underLineInputBorderColor:
                                            //             isDark
                                            //                 ? CustomTheme
                                            //                     .grey_transparent2
                                            //                 : CustomTheme
                                            //                     .primaryColor,
                                            //         controller:
                                            //             loginPasswordController,
                                            //         obscureValue: true,
                                            //         validator: (value) {
                                            //           return validateMinLength(
                                            //               value);
                                            //         }),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                      ),
                                      child: PrimaryButton(
                                        title: "SIGN UP",
                                        width: double.infinity,
                                        onTap: () {
                                          if (_signUpFormkey.currentState!
                                              .validate()) {
                                            // isLoading = true;
                                            // AuthUser user = AuthUser(
                                            //     name: loginNameController.text,
                                            //     email:
                                            //         loginEmailController.text);
                                            // // Registration started bloc
                                            // bloc.add(RegistrationStarted());
                                            // bloc.add(RegistrationCompleting(
                                            //     user: user,
                                            //     password:
                                            //         loginPasswordController
                                            //             .text));
                                            _displayTextInputDialog(context);
                                          }
                                        },
                                        // screenWidth * .8,
                                        height: 50,
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //     horizontal: 20.0,
                                    //   ),
                                    //   child: ElevatedButton(
                                    //     style: ElevatedButton.styleFrom(
                                    //       backgroundColor:
                                    //           CustomTheme.primaryColor,
                                    //       shape: RoundedRectangleBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(20.0),
                                    //       ),
                                    //     ),
                                    //     onPressed: () {
                                    //       if (_signUpFormkey.currentState!
                                    //           .validate()) {
                                    //         isLoading = true;
                                    //         AuthUser user = AuthUser(
                                    //             name:
                                    //                 loginNameController.text,
                                    //             email: loginEmailController
                                    //                 .text);
                                    //         // Registration started bloc
                                    //         bloc.add(RegistrationStarted());
                                    //         bloc.add(RegistrationCompleting(
                                    //             user: user,
                                    //             password:
                                    //                 loginPasswordController
                                    //                     .text));
                                    //       }
                                    //     },
                                    //     child: Container(
                                    //       width: MediaQuery.of(context)
                                    //           .size
                                    //           .width,
                                    //       child: Padding(
                                    //         padding:
                                    //             const EdgeInsets.symmetric(
                                    //           horizontal: 20.0,
                                    //           vertical: 15.0,
                                    //         ),
                                    //         child: Center(
                                    //           child: Text(
                                    //             AppContent.register,
                                    //             style: CustomTheme
                                    //                 .authTitleWhite,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(height: 10.0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (isLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              )),
            ),
          );
        },
      ),
    );
  }

  Future<PersistentBottomSheetController> _displayTextInputDialog(
      BuildContext context) async {
    return showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            decoration: BoxDecoration(
                color: Color(0xff212121),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Enter OTP Here',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.cancel))
                    ],
                  ),
                  Divider(
                    color: purple.withOpacity(0.6),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Pinput(
                    length: 6,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: PrimaryButton(
                      title: "Submit",
                      width: double.infinity,
                      onTap: () {
                        if (_signUpFormkey.currentState!.validate()) {}
                      },
                      // screenWidth * .8,
                      height: 50,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
//     Column(children: [
//              Text('TextField in Dialog'),
//               TextField(
//               onChanged: (value) {},
//               decoration: InputDecoration(hintText: "Text Field in Dialog"),)
//           ],)