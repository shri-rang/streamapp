import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oxoo/pages/CoontinuePage.dart';
import 'package:oxoo/utils/loadingIndicator.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../bloc/auth/phone_auth/auth_repo.dart';
import '../../service/authentication_service.dart';
import '../landing_screen.dart';

class otpScreen extends StatefulWidget {
  const otpScreen({super.key});

  @override
  State<otpScreen> createState() => _otpScreenState();
}

class _otpScreenState extends State<otpScreen> {
  TextEditingController otpVerifyCnt = new TextEditingController();
   bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
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
                title: 
                 isLoading ? 
                  LoadingIndicator() :
                Text("SUBMIT",
                    style: TextStyle(
                        fontFamily: 'Sans Serif',
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w400)),
                //"SUBMIT",
                width: double.infinity,
                onTap: () async {
                  if (otpVerifyCnt.text.isNotEmpty) {
                         isLoading =true;
                         setState(() {
                           
                         });
                     await  AuthRepo.submitOtp(context, otpVerifyCnt.text);
                          isLoading = false;
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) {
                    //     return LandingScreen();
                    //   },
                    // ));

                    // authService.updateUser(AuthRepo.userServerData!);
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
