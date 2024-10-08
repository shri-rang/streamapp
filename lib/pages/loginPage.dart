import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oxoo/colors.dart';
import 'package:oxoo/pages/ChosseIntrestPage.dart';
import 'package:oxoo/pages/CoontinuePage.dart';
import 'package:oxoo/screen/landing_screen.dart';
import 'package:oxoo/widgets/home_screen/commonWidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameCnt = TextEditingController();
  TextEditingController passCnt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: orange,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // ColorFiltered(
            //   colorFilter: ColorFilter.mode(
            //       Colors.black.withOpacity(0.6), BlendMode.srcOver),
            //   child: Image.asset(
            //     "assets/optimus.jpg",
            //     height: 400,
            //     width: double.infinity,
            //     fit: BoxFit.cover,
            //     colorBlendMode: BlendMode.srcOver,
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [orange, red],
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                    ),
                    Center(
                      child: Text(
                        "Login to your",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        "account",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    textField(context, "Enter your number here", nameCnt,
                        TextInputType.number, (p0) {},
                        preffixicon: Icon(
                          Icons.call,
                          color: orange,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    textField(context, "Enter your password here", passCnt,
                        TextInputType.name, (p0) {},
                        preffixicon: Icon(
                          Icons.lock,
                          color: orange,
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                      title: Text("LOGIN",
                          style: TextStyle(
                              fontFamily: 'Sans Serif',
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),

                      //"LOGIN",
                      width: double.infinity,
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) {
                        //     return LandingScreen();
                        //   },
                        // ));
                      },
                      // screenWidth * .8,
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                color: Colors.white)
                            // style: GoogleFonts.nunito(
                            //     color: Colors.grey,
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.w500),
                            ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return LandingScreen();
                              },
                            ));
                            // Get.to(LoginInput(type: "Sign Up"));
                          },
                          child: Text("Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: grey)
                              // style: GoogleFonts.nunito(
                              //     color: Colors.white,
                              //     decoration: TextDecoration.underline,
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.w700),
                              ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
