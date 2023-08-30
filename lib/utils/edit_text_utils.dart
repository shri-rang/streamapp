import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../style/theme.dart';
import '../colors.dart';

class EditTextUtils {
  TextFormField getCustomEditTextField(
      {String hintValue = "",
      TextEditingController? controller,
      EdgeInsetsGeometry contentPadding =
          const EdgeInsets.symmetric(vertical: 20),
      Widget? prefixWidget,
      Widget? suffixWidget,
      TextStyle? style,
      Function? validator,
      bool obscureValue = false,
      int maxLines = 1,
      String? lableText,
      Color underLineInputBorderColor = CustomTheme.grey_transparent2,
      TextInputType? keyboardType}) {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
        fontSize: 17.sp,
        // fontFamily: 'Gill Sans MT Condensed',
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      controller: controller,

      decoration: InputDecoration(
        suffixIcon: suffixWidget,
        prefixIcon: prefixWidget,
        filled: true,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(width: 2, color: Colors.white),
        ),
        fillColor: Color.fromRGBO(39, 40, 41, 1),
        suffixIconConstraints: BoxConstraints(minWidth: 2, minHeight: 10),
        prefixStyle: TextStyle(
          color: Colors.white,
        ),
        // labelText: lableText,

        hintStyle: TextStyle(
            // fontFamily: 'Gill Sans MT Condensed',
            color: Colors.white.withOpacity(0.4),
            fontSize: 17.sp,
            fontWeight: FontWeight.bold),
        hintText: lableText,

        // labelStyle: Theme.of(context)
        //     .textTheme
        //     .headline6!
        //     .copyWith(color: Colors.white.withOpacity(0.4)),
        // border: Border.all()
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // prefixText: "+91",
        // disabledBorder: InputBorder.none,
        // border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              BorderSide(width: 2, color: Color.fromRGBO(255, 235, 200, 1)),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(width: 2, color: grey),
        ),

        // errorBorder: InputBorder.none,

        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //     // width: 3,
        //     color: Color.fromARGB(255, 172, 24, 24),
        //   ), //<-- SEE HERE
        // ),
        // errorBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //     // width: 3,
        //     color: Colors.red,
        //   ), //<-- SEE HERE
        // ),
        // border: OutlineInputBorder(
        //   borderSide: BorderSide(
        //     // width: 3,
        //     color: Color.fromARGB(255, 189, 36, 36),
        //   ), //<-- SEE HERE

        // ),
      ),
      // InputDecoration(
      //   prefixIcon: prefixWidget,
      //   suffixIcon: suffixWidget,
      //   contentPadding:contentPadding,
      //   focusedBorder: UnderlineInputBorder(
      //     borderSide: BorderSide(color: underLineInputBorderColor),
      //   ),
      //   border: UnderlineInputBorder(
      //     borderSide: BorderSide(color: underLineInputBorderColor),
      //   ),
      //   enabledBorder: UnderlineInputBorder(
      //     borderSide: BorderSide(color: underLineInputBorderColor),
      //   ),
      //   hintText: hintValue,
      //   hintStyle: style,
      // ),
      // style: style,
      validator: validator as String? Function(String?)?,
      obscureText: obscureValue,
    );
  }
}
