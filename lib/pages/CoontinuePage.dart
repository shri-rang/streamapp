import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oxoo/colors.dart';
import 'package:oxoo/screen/landing_screen.dart';
import 'package:oxoo/widgets/home_screen/commonWidget.dart';

import 'loginPage.dart';

class ContinuePage extends StatefulWidget {
  const ContinuePage({super.key});

  @override
  State<ContinuePage> createState() => _ContinuePageState();
}

class _ContinuePageState extends State<ContinuePage> {
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
            //     "assets/posterbg.jpg",
            //     height: 450,
            //     fit: BoxFit.cover,
            //     colorBlendMode: BlendMode.srcOver,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SizedBox(
                    height:
                        // 240

                        MediaQuery.of(context).size.height / 2.8,
                  ),
                  Text(
                    "Let's you in",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) {
                  //         return LandingScreen();
                  //       },
                  //     ));
                  //   },
                  //   child: radiusContainerWithIcon("Continue with Whatsapp",
                  //       "assets/whatapp.png", context),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return LandingScreen();
                        },
                      ));
                    },
                    child: radiusContainerWithIcon("Continue with Google",
                        "assets/google_logo.png", context),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) {
                  //         return LandingScreen();
                  //       },
                  //     ));
                  //   },
                  //   child: radiusContainerWithIcon("Continue with Whatsapp",
                  //       "assets/apple_logo.png", context),
                  // ),
                  SizedBox(
                    height: 40,
                  ),
                  or(context),
                  SizedBox(
                    height: 40,
                  ),
                  PrimaryButton(
                    title: "SIGN IN WITH PASSWORD",
                    width: double.infinity,
                    height: 50,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ));
                    },
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
          ],
        ),
      ),
    );
  }

  Widget radiusContainerWithIcon(
      String title, String img, BuildContext context) {
    return Container(
      height: 55,
      padding: EdgeInsets.only(left: 40),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            img,
            height: 30,
            width: 30,
            // fit: BoxFit.fill,
          ),
          SizedBox(
            width: 15,
          ),
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: Colors.white))
          // smallTexttwo(
          //   title,
          //   context,
          // ),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  PrimaryButton(
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
          color: grey,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          // gradient: LinearGradient(colors: [
          //   Color.fromRGBO(210, 32, 97, 1),
          //   Color.fromRGBO(159, 18, 210, 1),
          // ]),
        ),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // <-- Radius
              ),
            ),
            onPressed: onTap,
            child: Text(title,
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w400)
                // style: GoogleFonts.nunito(
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
