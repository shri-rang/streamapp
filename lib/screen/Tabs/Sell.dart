import 'package:flutter/material.dart';
import 'package:oxoo/screen/Tabs/Buy.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Text(
                "Create an account to buy and sell 24K gold!",
                style: textStyle.copyWith(fontSize: 21),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            PrimaryButtonT(
              title: "Sell Now",
              width: 130,
              onTap: () {},
              // screenWidth * .8,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
