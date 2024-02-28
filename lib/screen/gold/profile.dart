import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../style/theme.dart';

class Profile extends StatefulWidget {
  UserCredential? userCredential;
  Profile({super.key, this.userCredential});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
          "Profile",
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
                  "Please Sign in to check profile",
                  style: TextStyle(fontSize: 20),
                ))
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
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
                  //  headerContainer(),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff212121),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          subHeader("Pan card", "BCGPJ1834C"),
                          SizedBox(
                            height: 10,
                          ),
                          subHeader("Aadhar card", "720232384238"),
                          SizedBox(
                            height: 10,
                          ),
                          subHeader("State", "Maharashtra"),
                          SizedBox(
                            height: 10,
                          ),
                          subHeader("City", "Mumbai"),
                          SizedBox(
                            height: 10,
                          ),
                          subHeader("Pin code", "400086"),
                          SizedBox(
                            height: 10,
                          ),
                          subHeader("Address", "201 kaladham"),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )),
                ],
              ),
            ),
    );
  }

  Widget subHeader(String title, String subtitle) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white60,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Text(
            subtitle,
            style: TextStyle(
                fontSize: 16,
                // fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.7)),
          )
        ],
      ),
    );
  }

  headerContainer(DocumentSnapshot<Map<String, dynamic>>? data) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xff212121),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(Icons.person),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              colunm("Name :", data!['name']),
              colunm("Date of Birth :", "01/04/1998 "),
            ],
          ),
        ],
      ),
    );
  }

  Widget colunm(String title, subtitle) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 25,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white60,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
                fontSize: 16,
                // fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.7)),
          )
        ],
      ),
    );
  }

  nameRow() {}
}
