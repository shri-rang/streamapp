import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../style/theme.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor:
            //isDark! ?
            CustomTheme.primaryColorDark,
        //: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: lightpurple),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
