import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oxoo/colors.dart';
import 'package:oxoo/screen/auth/signIn_screen.dart';
import 'package:oxoo/screen/auth/sign_up_screen.dart';
import 'package:oxoo/screen/landing_screen.dart';
import 'package:oxoo/widgets/home_screen/commonWidget.dart';
import 'package:provider/provider.dart';

import '../bloc/auth/firebase_auth/firebase_auth_bloc.dart';
import '../bloc/auth/firebase_auth/firebase_auth_event.dart';
import '../bloc/auth/firebase_auth/firebase_auth_state.dart';
import '../models/user_model.dart';
import '../screen/phon_auth_screen.dart';
import '../service/authentication_service.dart';
import '../utils/loadingIndicator.dart';

// import 'loginPage.dart';

class ContinuePage extends StatefulWidget {
  const ContinuePage({super.key});

  @override
  State<ContinuePage> createState() => _ContinuePageState();
}

class _ContinuePageState extends State<ContinuePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  AuthService? authService;
  bool isLoading = false;
  late bool _isLogged;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseAuthBloc = BlocProvider.of<FirebaseAuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    authService = Provider.of<AuthService>(context);
    _isLogged = authService!.getUser() != null ? true : false;
    return _isLogged
        ? LandingScreen()
        : Scaffold(
            // backgroundColor: orange,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  // ColorFiltered(
                  //   colorFilter: ColorFilter.mode(
                  //       Colors.black.withOpacity(0.6), BlendMode.srcOver),
                  //   child: Image.asset(
                  //     "assets/posterbg.jpg",
                  //     height: 450,
                  //     fit: BoxFit.cover,
                  //     colorBlendMode: BlendMode.srcOver,
                  //   ),
                  // ),
                  Container(
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          SizedBox(
                            height:
                                // 240

                                MediaQuery.of(context).size.height / 2.8,
                          ),
                          Text(
                            "Let's you in",
                            style: TextStyle(
                                fontFamily: 'Sans Serif',
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) {
                          //         return LandingScreen();
                          //       },
                          //     ));
                          //   },
                          //   child: radiusContainerWithIcon("Continue with Whatsapp",
                          //       "assets/whatapp.png", context),
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          radiusContainerWithIcon(
                              "Continue with Google",
                              "assets/google_logo.png",
                              context,
                              _signInWithGoogle),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // if (isLoading) spinkit,
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // // GestureDetector(
                          // //   onTap: () {
                          // //     Navigator.of(context).push(MaterialPageRoute(
                          // //       builder: (context) {
                          // //         return LandingScreen();
                          // //       },
                          // //     ));
                          // //   },
                          // //   child: radiusContainerWithIcon("Continue with Whatsapp",
                          // //       "assets/apple_logo.png", context),
                          // // ),
                          // SizedBox(
                          //   height: 40,
                          // ),
                          // or(context),
                          SizedBox(
                            height: 40,
                          ),
                          PrimaryButton(
                            title: "SIGN IN WITH PASSWORD",
                            width: double.infinity,
                            height: 53,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return LoginPage();
                                },
                              ));
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?",
                                  style: TextStyle(
                                      fontFamily: 'Sans Serif',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp,
                                      color: Colors.white)
                                  // style: GoogleFonts.nunito(
                                  //     color: Colors.grey,
                                  //     fontSize: 18,
                                  //     fontWeight: FontWeight.w500),
                                  ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, SignUpScreen.route);
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //   builder: (context) {
                                  //     return LandingScreen();
                                  //   },
                                  // ));
                                  // Get.to(LoginInput(type: "Sign Up"));
                                },
                                child: Text("Sign up",
                                    style: TextStyle(
                                        fontFamily: 'Sans Serif',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.sp,
                                        color: purple)
                                    // style: GoogleFonts.nunito(
                                    //     color: Colors.white,
                                    //     decoration: TextDecoration.underline,
                                    //     fontSize: 18,
                                    //     fontWeight: FontWeight.w700),
                                    ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Future _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await (_googleSignIn.signIn());
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final User user = (await _auth.signInWithCredential(credential)).user!;
    if (user.email != null && user.email != "") {
      assert(user.email != null);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return LandingScreen();
        },
      ));
    }
    assert(user.displayName != null);
    assert(!user.isAnonymous);

    final User currentUser = _auth.currentUser!;
    assert(user.uid == currentUser.uid);
    return user;
  }

  Widget radiusContainerWithIcon(
    String title,
    String img,
    BuildContext context,
    Function? function,
  ) {
    return BlocListener<FirebaseAuthBloc, FirebaseAuthState>(
        listener: (context, state) {
      if (state is FirebaseAuthStateCompleted) {
        AuthUser? user = state.getUser;
        if (user == null) {
          firebaseAuthBloc.add(FirebaseAuthFailed);
        } else {
          print(user.toJson().toString());
          authService!.updateUser(user);
          isLoading = false;
          if (authService!.getUser() != null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LandingScreen()),
                (Route<dynamic> route) => false);
          }
        }
      } else if (state is FirebaseAuthFailedState) {
        firebaseAuthBloc.add(FirebaseAuthNotStarted());
      }
    }, child: BlocBuilder<FirebaseAuthBloc, FirebaseAuthState>(
            builder: (context, state) {
      return InkWell(
        onTap: () async {
          setState(() {
            isLoading = true;
          });
          User fbUser = await function!();
          firebaseAuthBloc.add(FirebaseAuthStarted());
          firebaseAuthBloc.add(FirebaseAuthCompleting(
            uid: fbUser.uid,
            email: fbUser.email,
            phone: fbUser.phoneNumber,
          ));
        },
        child: Container(
          height: 55,
          padding: EdgeInsets.only(left: 40),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: lgrey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                img,
                height: 30,
                width: 30,
                // fit: BoxFit.fill,
              ),
              SizedBox(
                width: 15,
              ),
              Text(title,
                  style: TextStyle(
                      fontFamily: 'Sans Serif',
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: Colors.white))
              // smallTexttwo(
              //   title,
              //   context,
              // ),
            ],
          ),
        ),
      );
    }));
  }
}

class PrimaryButton extends StatelessWidget {
  PrimaryButton(
      {Key? key,
      required this.title,
      required this.width,
      required this.height,
      required this.onTap})
      : super(key: key);
  String title;
  double width;
  double height;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          // color: grey,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [
                // Color(0xffA82324),
                lightpurple,
                purple
              ]),
        ),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // <-- Radius
              ),
            ),
            onPressed: onTap,
            child: Text(title,
                style: TextStyle(
                    fontFamily: 'Sans Serif',
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w400)
                // style:
                // GoogleFonts.araboto(
                //     fontWeight: FontWeight.w700, color: Colors.white),
                ))
        //  Center(
        //     child: Text(title,
        //         style: TextStyle(
        //             fontSize: 15.sp,
        //             color: Colors.white,
        //             fontWeight: FontWeight.w400)
        //         // style: GoogleFonts.nunito(
        //         //     fontWeight: FontWeight.w700, color: Colors.white),
        //         )
        //         ),
        );
  }
}
