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
      backgroundColor: orange,
      body: Column(
        children: [
          Image.asset(
            "assets/lai.png",
            width: MediaQuery.of(context).size.width / 1.1,
          ),
          SizedBox(
            height: 90,
          ),
          Center(
            child: Text(
              "Unlimited",
              style: TextStyle(
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
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Center(
            child: Text(
              "Watch lai Bhari anywhere. Cancel at any time",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
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
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
