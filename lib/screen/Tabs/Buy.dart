import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oxoo/colors.dart';
import 'package:oxoo/pages/CoontinuePage.dart';
import 'package:oxoo/style/theme.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  String buyIn = "buyinR";
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.primaryColorDark ,
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    buyInWidget("buyinR", "Buy In Rupee"),
                    buyInWidget("buyinGm", "Buy In Grams"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      // labelText: "Enter Email",
                      fillColor: Colors.white,
                      prefix: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          "₹",
                          style: textStyle,
                        ),
                      ),
                      suffix: Text(
                        "= 0.3245",
                        style: textStyle,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                      // focusedBorder: OutlineInputBorder(

                      //   borderRadius: BorderRadius.circular(25.0),
                      //   borderSide: BorderSide(

                      //     color: Colors.blue,
                      //   ),
                      // ),
                      // enabledBorder: OutlineInputBorder(

                      //   // borderRadius: BorderRadius.circular(25.0),
                      //   borderSide: BorderSide(
                      //     color: Colors.blue,
                      //     width: 2.0,
                      //   ),
                      // ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                PrimaryButtonT(
                  title: "Buy Gold",
                  width: 130,
                  onTap: () {},
                  // screenWidth * .8,
                  height: 50,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buyInWidget(String buy, String title) {
    return Row(
      children: [
        Radio(
          value: buy,
          groupValue: buyIn,
          onChanged: (value) {
            buyIn = value!;
            setState(() {});
          },
        ),
        Text(
          title,
          style: textStyle,
          //"Buy In Rupee"
        )
      ],
    );
  }
}

TextStyle textStyle = TextStyle(
    fontFamily: 'Sans Serif',
    fontSize: 15.sp,
    color: Colors.white,
    fontWeight: FontWeight.bold);

class PrimaryButtonT extends StatelessWidget {
  PrimaryButtonT(
      {Key? key,
      required this.title,
      required this.width,
      required this.height,
      required this.onTap})
      : super(key: key);
  String title;
  double width;
  double height;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          // color: grey,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [
                // Color(0xffA82324),
                lightpurple,
                purple
              ]),
        ),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // <-- Radius
              ),
            ),
            onPressed: onTap,
            child: Text(title,
                style: TextStyle(
                    fontFamily: 'Sans Serif',
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w400)
                // style:
                // GoogleFonts.araboto(
                //     fontWeight: FontWeight.w700, color: Colors.white),
                ))
        //  Center(
        //     child: Text(title,
        //         style: TextStyle(
        //             fontSize: 15.sp,
        //             color: Colors.white,
        //             fontWeight: FontWeight.w400)
        //         // style: GoogleFonts.nunito(
        //         //     fontWeight: FontWeight.w700, color: Colors.white),
        //         )
        //         ),
        );
  }
}
