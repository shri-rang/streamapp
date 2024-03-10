import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../colors.dart';
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
                    height: 30,
                  ),
                  Container(
                    // padding: EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: purple.withOpacity(0.8),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      tileColor: Color(0xff212121),
                      leading: SvgPicture.asset("assets/gold/gold.svg",
                          // colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                          semanticsLabel: 'A red up arrow'),
                      title: Text(
                        "Get Delivary",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    // padding: EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: purple.withOpacity(0.8),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      tileColor: Color(0xff212121),
                      leading: SvgPicture.asset("assets/gold/jewellery.svg",
                          // color: purple,
                          // colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                          semanticsLabel: 'A red up arrow'),
                      title: Text(
                        "Reedem as Jewellery",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  headerContainer(DocumentSnapshot<Map<String, dynamic>>? data) {
    print("some adta ${data!['amount']}");
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: purple.withOpacity(0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          colunm("Available balance :", "₹ ${data!['amount']}"),
          // colunm("Current Amount :", "₹ 6000 "),
        ],
      ),
    );
  }

  Widget colunm(String title, subtitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(6),
            // color: purple,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(
              //   height: 25,
              // ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
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
                    color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
