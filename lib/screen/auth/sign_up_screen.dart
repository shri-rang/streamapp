import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxoo/pages/CoontinuePage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oxoo/screen/home_screen.dart';
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
  TextEditingController otpVerifyCnt = new TextEditingController();
  late bool _isRegistered;
  late Bloc bloc;
  Bloc? firebaseAuthBloc;
  bool isMandatoryLogin = false;
  bool isLoading = false;
  late bool isDark;
  var appModeBox = Hive.box('appModeBox');
  String smsCode = "";
  FirebaseAuth auth = FirebaseAuth.instance;

  String verificationId = "";
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
                                        onTap: () async {
                                          print(isCodeSent);
                                          if (_signUpFormkey.currentState!
                                              .validate()) {
                                            await _phoneAuth(
                                                    loginEmailController.text)
                                                .then((value) {
                                              // isCodeSent
                                              // ?

                                              _displayTextInputDialog(context);
                                            });

                                            // is Loading = true;
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
                                            //   _displayTextInputDialog(context);
                                          }
                                        },
                                        // screenWidth * .8,
                                        height: 50,
                                      ),
                                    ),
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

  alertDailog(
    BuildContext context,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            // title: Text('Welcome'),
            content: Container(
              height: 100,
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        color: orange,
                        backgroundColor: purple,
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  // bool isVerify = false;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<void> verify(String otp) async {
    alertDailog(context);
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);

    signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);
      //    auth.
      if (authCredential.user != null) {
        appModeBox.put("uid", authCredential);
        print("signnnnnnn${appModeBox.get("uid")} ");
        await firebaseFirestore
            .collection('users')
            .doc(authCredential!.user!.uid)!
            .update({
          // 'userId': 'shri',
          'name': loginNameController.text,
        });
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => LandingScreen(
                      userCredential: authCredential,
                    )),
            (Route<dynamic> route) => false);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      print("catch $e");
    }
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
                    controller: otpVerifyCnt,
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
                        if (otpVerifyCnt.text.isNotEmpty) {
                          verify(otpVerifyCnt.text);
                        }
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

  bool isCodeSent = false;
  Future<void> _phoneAuth(String phoneNumber) async {
    String error = '';
    // if (kIsWeb) {
    //   final confirmationResult =
    //       await auth.signInWithPhoneNumber(phoneController.text);
    //   final smsCode = await getSmsCodeFromUser(context);

    //   if (smsCode != null) {
    //     await confirmationResult.confirm(smsCode);
    //   }
    // }
    // else {
    alertDailog(context);
    await auth.verifyPhoneNumber(
      phoneNumber: "+91$phoneNumber",
      verificationCompleted: (auth) {
        return print("objectttttt$auth");
      },
      verificationFailed: (e) {
        setState(() {
          error = '${e.message}';
        });
        Navigator.of(context).pop();
      },
      codeSent: (String verificationId, int? resendToken) async {
        print("verfication id $verificationId");
        this.verificationId = verificationId;

        Navigator.of(context).pop();

        setState(() {});
        // final smsCodee = smsCode;

        // if (smsCodee != null) {
        //   // Create a PhoneAuthCredential with the code
        //   final credential = PhoneAuthProvider.credential(
        //     verificationId: verificationId,
        //     smsCode: smsCodee,
        //   );

        //   try {
        //     // Sign the user in (or link) with the credential
        //     await auth.signInWithCredential(credential);
        //   } on FirebaseAuthException catch (e) {
        //     setState(() {
        //       error = e.message ?? '';
        //     });
        //   }
        // }
      },
      codeAutoRetrievalTimeout: (e) {
        setState(() {
          error = e;
        });
        Navigator.of(context).pop();
      },
    );
  }
}



 

// }





//     Column(children: [
//              Text('TextField in Dialog'),
//               TextField(
//               onChanged: (value) {},
//               decoration: InputDecoration(hintText: "Text Field in Dialog"),)
//           ],)
