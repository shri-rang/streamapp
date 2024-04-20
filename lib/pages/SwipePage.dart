import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oxoo/colors.dart';
import 'package:oxoo/pages/CoontinuePage.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.center,
            //   end: Alignment.bottomCenter,
            //   // stops: [0.1, 0.5, 0.7, 0.9],
            //   colors: [orange, red],
            // ),
            ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            // Image.asset(
            //   "assets/LaiBharee.jpg",
            //   width: MediaQuery.of(context).size.width / 1.1,
            // ),
            SizedBox(
              height: 90,
            ),
            Center(
              child: Text(
                "Unlimited",
                style: TextStyle(
                    fontFamily: 'Sans Serif',
                    fontSize: 23.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Center(
              child: Text(
                "Movies, TV",
                style: TextStyle(
                    fontFamily: 'Sans Serif',
                    fontSize: 23.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Center(
              child: Text(
                "Shows and more",
                style: TextStyle(
                    fontFamily: 'Sans Serif',
                    fontSize: 23.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                child: Text(
                  textAlign: TextAlign.center,
                  "Watch Jalsa anywhere. Cancel at any time",
                  style: TextStyle(
                      fontFamily: 'Sans Serif',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ngrey),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: PrimaryButton(
                title: "SWIPE TO CONTINUE > > >",
                width: double.infinity,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return ContinuePage();
                    },
                  ));
                },
                // screenWidth * .8,
                height: 55,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
