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
  bool isToggled = false;

  void _toggleButton() {
    setState(() {
      isToggled = !isToggled;
    });
  }

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
          : SingleChildScrollView(
              child: Padding(
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
                      height: 20,
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
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // addVerticleSpace(20),
                                      const Text(
                                        "KYC Status",
                                        style: AppTextStyle.heading1,
                                      ),
                                      addVerticleSpace(10),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 50,
                                              // width: 190,
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                  bottom: BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                  right: BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              child: const Center(
                                                  child: Text(
                                                "Verify PAN",
                                                style: AppTextStyle.hyperText,
                                              )),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 50,
                                              // width: 190,
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                  bottom: BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              child: const Center(
                                                  child: Text(
                                                "Verify Aadhaar",
                                                style: AppTextStyle.hyperText,
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      addGreySpacer(15),
                                      addVerticleSpace(20),
                                      const Text(
                                        "Basic Details",
                                        style: AppTextStyle.heading1,
                                      ),
                                      addVerticleSpace(20),
                                      Row(
                                        children: [
                                          const Icon(Icons.phone),
                                          addHorizontalSpace(10),
                                          const Text(
                                            "Phone Number",
                                            style: AppTextStyle.subTitle,
                                          )
                                        ],
                                      ),
                                      addVerticleSpace(10),
                                      Text(
                                        snapshot.data![
                                            'mobileNo'], // StringManager().userPhNumber,
                                        style: AppTextStyle.heading2,
                                      ),
                                      addVerticleSpace(10),
                                      Row(
                                        children: [
                                          SizedBox(
                                              height: 28,
                                              width: 28,
                                              child: Image.asset(
                                                "assets/images/whatsapp.png",
                                                fit: BoxFit.contain,
                                              )),
                                          addHorizontalSpace(5),
                                          Expanded(
                                            child: const Text(
                                                "I would like to recive update on Whatsapp"),
                                          ),
                                          addHorizontalSpace(30),
                                          GestureDetector(
                                            onTap: _toggleButton,
                                            child: isToggled
                                                ? const Icon(
                                                    Icons.toggle_on_outlined,
                                                    size: 30,
                                                    color: Colors.cyan,
                                                  )
                                                : const Icon(
                                                    Icons.toggle_off_outlined,
                                                    size: 30,
                                                  ),
                                          ),
                                        ],
                                      ),
                                      addVerticleSpace(10),
                                      const Divider(),
                                      //email
                                      Container(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons.email_outlined),
                                                  addHorizontalSpace(10),
                                                  const Text(
                                                    "Email Address",
                                                    style:
                                                        AppTextStyle.subTitle,
                                                  ),
                                                  addHorizontalSpace(190),
                                                  const Icon(
                                                    Icons.edit,
                                                    size: 25,
                                                    color: Colors.cyan,
                                                  )
                                                ],
                                              ),
                                              addVerticleSpace(10),
                                              Text(
                                                snapshot.data!['email'],
                                                style: AppTextStyle.heading2,
                                              ),
                                              addVerticleSpace(10),
                                              const Text(
                                                "Verify Email ID",
                                                style: AppTextStyle.hyperText,
                                              ),
                                            ]),
                                      ),
                                      addVerticleSpace(10),
                                      addGreySpacer(15),
                                      addVerticleSpace(10),
                                      //Withdrawal Method
                                      Container(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 25,
                                                    width: 25,
                                                    child: Image.asset(
                                                      "assets/images/bank.png",
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  addHorizontalSpace(10),
                                                  const Text(
                                                    "Withdrawal Method",
                                                    style:
                                                        AppTextStyle.subTitle,
                                                  )
                                                ],
                                              ),
                                              addVerticleSpace(10),
                                              const Text(
                                                  "Add withdrawal account to get deposit of money at the times of selling"),
                                              addVerticleSpace(10),
                                              const Text(
                                                "How to add Withdrawal Method?",
                                                style: AppTextStyle.hyperText,
                                              ),
                                            ]),
                                      ),
                                      addVerticleSpace(10),
                                      addGreySpacer(15),
                                      addVerticleSpace(10),
                                      //pin
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                    Icons.password_outlined),
                                                addHorizontalSpace(10),
                                                const Text(
                                                  "PIN Password",
                                                  style: AppTextStyle.subTitle,
                                                ),
                                              ],
                                            ),
                                            addVerticleSpace(10),
                                            const Text(
                                                "PIN Password for your profile is set successfully"),
                                            addVerticleSpace(10),
                                            const Text(
                                              "Modify PIN",
                                              style: AppTextStyle.hyperText,
                                            ),
                                          ],
                                        ),
                                      ),
                                      addVerticleSpace(10),
                                      addGreySpacer(15),
                                      addVerticleSpace(10),
                                      //address
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: Image.asset(
                                                    "assets/images/address.png",
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                addHorizontalSpace(10),
                                                const Text(
                                                  "Addresses",
                                                  style: AppTextStyle.subTitle,
                                                ),
                                              ],
                                            ),
                                            addVerticleSpace(10),
                                            const Text(
                                                "Add your address to be able to order physical gold delivery"),
                                            addVerticleSpace(10),
                                            const Text(
                                              "Add Address",
                                              style: AppTextStyle.hyperText,
                                            ),
                                            SizedBox(
                                              height: 100,
                                            )
                                            // addVerticleSpace(20)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                        }),
                    // Container(
                    //     padding: EdgeInsets.symmetric(horizontal: 10),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(8),
                    //       color: Color(0xff212121),
                    //     ),
                    //     child: Column(
                    //       children: [
                    //         SizedBox(
                    //           height: 20,
                    //         ),
                    //         subHeader("Pan card", "BCGPJ1834C"),
                    //         SizedBox(
                    //           height: 10,
                    //         ),
                    //         subHeader("Aadhar card", "720232384238"),
                    //         SizedBox(
                    //           height: 10,
                    //         ),
                    //         subHeader("State", "Maharashtra"),
                    //         SizedBox(
                    //           height: 10,
                    //         ),
                    //         subHeader("City", "Mumbai"),
                    //         SizedBox(
                    //           height: 10,
                    //         ),
                    //         subHeader("Pin code", "400086"),
                    //         SizedBox(
                    //           height: 10,
                    //         ),
                    //         subHeader("Address", "201 kaladham"),
                    //         SizedBox(
                    //           height: 20,
                    //         ),
                    //       ],
                    //     )),
                  ],
                ),
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
      height: 80,
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
              colunm("Name :", data!['userId']),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.7)),
          )
        ],
      ),
    );
  }

  nameRow() {}
}

class AppTextStyle {
  static const TextStyle heading = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle hyperText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.cyan,
  );
  static const TextStyle heading1 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle heading2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subTitle = TextStyle(
    fontSize: 15,
    color: Color.fromARGB(255, 94, 93, 93),
  );
}

Widget addVerticleSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

Widget addGreySpacer(double height) {
  return Container(
    decoration: BoxDecoration(color: purple),
    height: height,
    width: double.infinity,
  );
}
