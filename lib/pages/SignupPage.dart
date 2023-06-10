import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:oxoo/colors.dart';
import 'package:oxoo/pages/CoontinuePage.dart';
import 'package:oxoo/widgets/home_screen/commonWidget.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  TextEditingController nameCnt = TextEditingController();
  TextEditingController passCnt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          textField(context, "Enter your name here", nameCnt,
              TextInputType.number, (p0) {},
              preffixicon: Icon(
                Icons.call,
                color: orange,
              )),
          SizedBox(
            height: 20,
          ),
          textField(context, "Enter your email here", nameCnt,
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
            title: "SIGN UP",
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
        ],
      ),
    );
  }
}
