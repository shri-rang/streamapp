import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth/phone_auth/phone_auth_bloc.dart';
import '../../bloc/auth/phone_auth/phone_auth_event.dart';
import '../../style/theme.dart';
import '../../utils/button_widget.dart';
import 'package:pinput/pinput.dart';
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
    return ConstrainedBox(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 48.0, bottom: 16.0, left: 16.0, right: 16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                AppContent.enterTheCodeSent,
                style: CustomTheme.coloredBodyText1,
              ),
            ),
            SizedBox(height: 30),
            Pinput(
              length: 6,
              onSubmitted: (String value) {
                inputPin = value;
              },
              controller: _pinPutController,
              focusNode: _pinPutFocusNode,
              submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: _pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(5.0),
              )),
              focusedPinTheme: defaultPinTheme,
              followingPinTheme: defaultPinTheme.copyDecorationWith(
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ],
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
              ),
            ),
            HelpMe().space(30.0),
            GestureDetector(
                onTap: () {
                  BlocProvider.of<PhoneAuthBloc>(context)
                      .add(VerifyOtpEvent(otp: inputPin));
                },
                child: HelpMe().submitButton(142, AppContent.submit)),
          ],
        ),
      ),
      constraints: BoxConstraints.tight(Size.fromHeight(300)),
    );
  }
}
