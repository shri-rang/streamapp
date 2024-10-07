import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/auth/phone_auth/phone_auth_bloc.dart';
import '../../bloc/auth/phone_auth/phone_auth_event.dart';
import '../../style/theme.dart';
import '../../utils/button_widget.dart';
import '../../utils/edit_text_utils.dart';
import '../pages/CoontinuePage.dart';
import '../strings.dart';
import '../utils/validators.dart';

// ignore: must_be_immutable
class NumberInput extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _phoneTextController = TextEditingController();
  String? _selectedCountryCode = AppContent.selectedCountryCode;
  final bool? isDark;
  NumberInput({this.isDark});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          const EdgeInsets.only(top: 60, bottom: 16.0, left: 16.0, right: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // SizedBox(
          //   height: 170,
          // ),
          Center(
            child: Image.asset(
              "assets/yl.png",
              width: 300,
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Sign to your account",
              style: TextStyle(
                  fontFamily: 'Sans Serif',
                  color: Colors.white,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // Center(
          //   child: Text(
          //     "account",
          //     style: TextStyle(
          //         fontFamily: 'Sans Serif',
          //         color: Colors.white,
          //         fontSize: 30.sp,
          //         fontWeight: FontWeight.bold),
          //   ),
          // ),
          SizedBox(
            height: 40,
          ),

//          SizedBox(height: 50.0),
          Form(
            key: _formKey,
            child: EditTextUtils().getCustomEditTextField(
                maxLength: 10,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                lableText: "Enter your moblie no here",
                hintValue: AppContent.emailAddress,
                prefixWidget: Icon(
                  Icons.phone,
                  color: Colors.white.withOpacity(0.5),
                ),
                keyboardType: TextInputType.phone,
                style:
                    isDark! ? CustomTheme.authTitleGrey : CustomTheme.authTitle,
                underLineInputBorderColor: isDark!
                    ? CustomTheme.grey_transparent2
                    : CustomTheme.primaryColor,
                controller: _phoneTextController,
                validator: (value) {
                  return validatePhone(value);
                }),
          ),
          // Form(
          //     key: _formKey,
          //     child: EditTextUtils().getCustomEditTextField(
          //       hintValue: AppContent.phonAuthHintValue,
          //       controller: _phoneTextController,
          //       prefixWidget: countryCde(),
          //       style: isDark!
          //           ? CustomTheme.textFieldTitlePrimaryWhite
          //           : CustomTheme.textFieldTitlePrimaryColored,
          //       keyboardType: TextInputType.number,
          //     )),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 30),
          //   child: GestureDetector(
          //       onTap: () {
          //         if (_formKey.currentState!.validate()) {
          //           /*print(_selectedCountryCode);*/
          //           BlocProvider.of<PhoneAuthBloc>(context).add(SendOtpEvent(
          //               phoNo: "+91" + _phoneTextController.value.text));
          //         }
          //       },
          //       child: HelpMe()
          //           .submitButton(screenWidth, AppContent.continueText)),
          // ),
          SizedBox(height: 20),
          PrimaryButton(
            title: "LOGIN",
            width: double.infinity,
            onTap: () {
              if (_formKey.currentState!.validate()) {
                /*print(_selectedCountryCode);*/
                BlocProvider.of<PhoneAuthBloc>(context)
                    .add(SendOtpEvent(phoNo: _phoneTextController.value.text));
              }
            },

            // screenWidth * .8,
            height: 50,
          ),
          // Text(
          //   AppContent.byTappingContinue,
          //   style: isDark!
          //       ? CustomTheme.bodyText2White
          //       : CustomTheme.coloredBodyText2,
          // )
        ],
      ),
    );
  }

  Widget countryCde() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 4.0),
      child: CountryCodePicker(
        textStyle: isDark!
            ? CustomTheme.textFieldTitlePrimaryWhite
            : CustomTheme.textFieldTitlePrimaryColored,
        //authTitle,
        onChanged: (value) {
          _selectedCountryCode = value.dialCode;
        },
        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
        initialSelection: AppContent.initialCountrySelection,
        favorite: AppContent.favouriteCountryCode,
        // optional. Shows only country name and flag
        showCountryOnly: false,
        // optional. Shows only country name and flag when popup is closed.
        showOnlyCountryWhenClosed: false,
        // optional. aligns the flag and the Text left
        alignLeft: false,
      ),
    );
  }
}
