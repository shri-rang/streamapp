import 'package:flutter/material.dart';
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
      backgroundColor: Color.fromARGB(255, 41, 37, 37).withOpacity(0.9),
      body: Stack(
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
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                ),
                Text(
                  "Login to your \n   account",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.white),
                ),
                SizedBox(
                  height: 40,
                ),
                textField(context, "Enter your number here", nameCnt,
                    TextInputType.number, (p0) {},
                    preffixicon: Icon(
                      Icons.call,
                      color: Colors.pink,
                    )),
                SizedBox(
                  height: 20,
                ),
                textField(context, "Enter your password here", passCnt,
                    TextInputType.name, (p0) {},
                    preffixicon: Icon(
                      Icons.lock,
                      color: Colors.pink,
                    )),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ChooseInterest();
                      },
                    ));
                    // Get.to(LoginInput(type: "Sign Up"));
                  },
                  child: PrimaryButton(
                    title: "LOGIN",
                    width: double.infinity,
                    // screenWidth * .8,
                    height: 69,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
