import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/auth/phone_auth/phone_auth_bloc.dart';
import '../../bloc/auth/phone_auth/phone_auth_event.dart';
import '../../style/theme.dart';
import '../../utils/button_widget.dart';
import 'package:pinput/pinput.dart';
import '../pages/CoontinuePage.dart';
import '../strings.dart';

// ignore: must_be_immutable
class OtpInput extends StatelessWidget {
  String? inputPin;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.grey.withOpacity(0.5)),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  final defaultPinTheme = PinTheme(
    width: 60,
    height: 64,
    textStyle: TextStyle(
      fontFamily: 'NunitoSans',
      fontWeight: FontWeight.w500,
      color: Colors.red,
      fontSize: 18,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.withOpacity(0.5)),
      borderRadius: BorderRadius.circular(15.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Center(
            child: Image.asset(
              "assets/yl.png",
              width: 300,
              // height: 100,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Verification",
              style: TextStyle(
                  fontFamily: 'Sans Serif',
                  color: Colors.white,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 25,
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
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Pinput(
            controller: _pinPutController,
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
              title: Text("Reset Password",
                  style: TextStyle(
                      fontFamily: 'Sans Serif',
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400)),

              // "SUBMIT",
              width: double.infinity,
              onTap: () {
                if (_pinPutController.text.isNotEmpty) {
                  BlocProvider.of<PhoneAuthBloc>(context)
                      .add(VerifyOtpEvent(otp: _pinPutController.text));
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) {
                  //     return LandingScreen();
                  //   },
                  // ));
                }
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) {
                //     return LandingScreen();
                //   },
                // ));
              },
              // screenWidth * .8,
              height: 50,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          // InkWell(
          //     onTap: () {
          //       //  Navigator.pushNamed(context, ResetPassword.route);
          //     },
          //     child: Center(
          //       child: Text(
          //         "Resend OTP",
          //         style: TextStyle(
          //             fontFamily: 'Sans Serif',
          //             color: Colors.amber,
          //             fontSize: 18.sp,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              AppContent.enterTheCodeSent,
              style: CustomTheme.coloredBodyText1,
            ),
          ),
          // SizedBox(height: 30),
          // Pinput(
          //   length: 6,
          //   onSubmitted: (String value) {
          //     inputPin = value;
          //   },
          //   controller: _pinPutController,
          //   focusNode: _pinPutFocusNode,
          //   submittedPinTheme: defaultPinTheme.copyWith(
          //       decoration: _pinPutDecoration.copyWith(
          //     borderRadius: BorderRadius.circular(5.0),
          //   )),
          //   focusedPinTheme: defaultPinTheme,
          //   followingPinTheme: defaultPinTheme.copyDecorationWith(
          //     borderRadius: BorderRadius.circular(5.0),
          //     boxShadow: [
          //       BoxShadow(
          //           color: Colors.grey.withOpacity(0.5),
          //           spreadRadius: 2,
          //           blurRadius: 7,
          //           offset: Offset(0, 3))
          //     ],
          //     border: Border.all(color: Colors.grey.withOpacity(0.5)),
          //   ),
          // ),
          // HelpMe().space(30.0),
          // GestureDetector(
          //     onTap: () {
          //       BlocProvider.of<PhoneAuthBloc>(context)
          //           .add(VerifyOtpEvent(otp: _pinPutController.text));
          //     },
          //     child: HelpMe().submitButton(142, AppContent.submit)),
        ],
      ),
    );
  }
}
