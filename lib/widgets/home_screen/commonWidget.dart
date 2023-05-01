import 'package:flutter/material.dart';

Widget or(BuildContext context) {
  return Row(
    children: [
      Container(
          width: MediaQuery.of(context).size.width / 2.3,
          child: Divider(
            color: Colors.grey,
          )),
      Text(
        "or",
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.white),
      ),
      Container(
          width: MediaQuery.of(context).size.width / 2.4,
          child: Divider(
            color: Colors.grey,
          )),
    ],
  );
}

Widget textField(
    BuildContext context,
    String lableText,
    TextEditingController controller,
    TextInputType textInputType,
    String? Function(String?)? validator,
    {Widget? suffix,
    Widget? preffixicon,
    void Function(String?)? onChange,
    void Function(String?)? onFieldSubmitted,
    void Function()? onEditingComplete}) {
  return TextFormField(
    controller: controller,
    // maxLength: 10,
    keyboardType: textInputType,
    validator: validator,
    onFieldSubmitted: onFieldSubmitted,
    onEditingComplete: onEditingComplete,
    cursorColor: Colors.black,
    cursorWidth: 1,
    style: TextStyle(color: Colors.white.withOpacity(0.4)),

    //  (value) {
    //     if (value!.isEmpty) {
    //        return " enter";
    //     }
    //     return null;
    // },
    onChanged: onChange,
    decoration: InputDecoration(
      suffixIcon: suffix,
      prefixIcon: preffixicon,
      filled: true,
      fillColor: Colors.white.withOpacity(0.2),
      suffixIconConstraints: BoxConstraints(minWidth: 2, minHeight: 10),
      prefixStyle: TextStyle(color: Colors.white),
      // labelText: lableText,

      hintStyle: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(color: Colors.white.withOpacity(0.4)),
      hintText: lableText,

      // labelStyle: Theme.of(context)
      //     .textTheme
      //     .headline6!
      //     .copyWith(color: Colors.white.withOpacity(0.4)),
      // border: Border.all()
      // floatingLabelBehavior: FloatingLabelBehavior.always,
      // prefixText: "+91",
      disabledBorder: InputBorder.none,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,

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
  );
}
