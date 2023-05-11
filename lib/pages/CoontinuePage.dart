import 'package:flutter/material.dart';
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
      backgroundColor: Color.fromARGB(255, 41, 37, 37).withOpacity(0.9),
      body: Stack(
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
                  height: 250,
                ),
                Text(
                  "Let's you in",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.white),
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return LandingScreen();
                      },
                    ));
                  },
                  child: radiusContainerWithIcon(
                      "Continue with Whatsapp", "assets/whatapp.png", context),
                ),
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
                  child: radiusContainerWithIcon("Continue with Whatsapp",
                      "assets/google_logo.png", context),
                ),
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
                  child: radiusContainerWithIcon("Continue with Whatsapp",
                      "assets/apple_logo.png", context),
                ),
                SizedBox(
                  height: 40,
                ),
                or(context),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ));
                    // Get.to(LoginInput(type: "Sign Up"));
                  },
                  child: PrimaryButton(
                    title: "SIGN IN WITH PASSWORD",
                    width: double.infinity,
                    height: 69,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white),
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
                      child: Text(
                        "Sign up",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.purple),
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
    );
  }

  Widget radiusContainerWithIcon(
      String title, String img, BuildContext context) {
    return Container(
      height: 69,
      padding: EdgeInsets.only(left: 40),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            img,
            height: 40,
            width: 40,
            // fit: BoxFit.fill,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white),
          )
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
      required this.height})
      : super(key: key);
  String title;
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(210, 32, 97, 1),
          Color.fromRGBO(159, 18, 210, 1),
        ]),
      ),
      child: Center(
          child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: Colors.white),
        // style: GoogleFonts.nunito(
        //     fontWeight: FontWeight.w700, color: Colors.white),
      )),
    );
  }
}
