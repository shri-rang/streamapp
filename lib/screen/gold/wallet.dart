import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../style/theme.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
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
          "Wallet",
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
