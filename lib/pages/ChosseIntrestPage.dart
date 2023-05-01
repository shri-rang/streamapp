import 'package:flutter/material.dart';

class ChooseInterest extends StatefulWidget {
  const ChooseInterest({super.key});

  @override
  State<ChooseInterest> createState() => _ChooseInterestState();
}

class _ChooseInterestState extends State<ChooseInterest> {
  List listOfIntrest = [
    "Action",
    "Horror",
    "Adveture",
    "Drama",
    "War",
    "Crime",
    "Romance",
    "History",
    "Music",
    "Comedy",
    "Anime",
    "Television",
    "Thriller"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
