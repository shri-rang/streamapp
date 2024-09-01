import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oxoo/pages/CoontinuePage.dart';
import 'package:pinput/pinput.dart';

import '../landing_screen.dart';

class otpScreen extends StatefulWidget {
  const otpScreen({super.key});

  @override
  State<otpScreen> createState() => _otpScreenState();
}

class _otpScreenState extends State<otpScreen> {
  TextEditingController otpVerifyCnt = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Image.asset(
                "assets/yl.png",
                width: 300,
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
                title: "SUBMIT",
                width: double.infinity,
                onTap: () {
                  if (otpVerifyCnt.text.isNotEmpty) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return LandingScreen();
                      },
                    ));
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
            InkWell(
                onTap: () {
                  //  Navigator.pushNamed(context, ResetPassword.route);
                },
                child: Center(
                  child: Text(
                    "Resend OTP",
                    style: TextStyle(
                        fontFamily: 'Sans Serif',
                        color: Colors.amber,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
