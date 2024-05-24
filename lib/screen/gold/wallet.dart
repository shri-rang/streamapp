import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../colors.dart';
import '../../models/goldModel/options_model.dart';
import '../../style/theme.dart';

class Wallet extends StatefulWidget {
  UserCredential? userCredential;
  Wallet({super.key, this.userCredential});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

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
      body: widget.userCredential == null
          ? Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                ),
                Center(
                    child: Text(
                  "Please Sign in to check wallet",
                  style: TextStyle(fontSize: 20),
                ))
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilder(
                    stream: firebaseFirestore
                        .collection("users")
                        .doc(widget.userCredential!.user!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : headerContainer(snapshot.data);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    itemCount: optionList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: purple,
                              borderRadius: BorderRadius.circular(6)),
                          child: ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SvgPicture.asset(optionList[index].image!),
                            ),
                            title: Text(
                              optionList[index].name!,
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
    );
  }

  headerContainer(DocumentSnapshot<Map<String, dynamic>>? data) {
    print("some adta ${data!['amount']}");
    var inGram = int.parse(data!['amount']) / 6356.40;
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xff212121),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          colunm("Available Balance :", "₹ ${inGram.toStringAsFixed(2)} gm"),
          // colunm("Current Amount :", "₹ 6000 "),
        ],
      ),
    );
  }

  Widget colunm(String title, subtitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(
            //   height: 25,
            // ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white60,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            //  Spacer(),
            Text(
              subtitle,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.7)),
            )
          ],
        ),
      ),
    );
  }
}
