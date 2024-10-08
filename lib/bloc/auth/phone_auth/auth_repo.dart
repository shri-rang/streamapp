
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user_model.dart';
import '../../../screen/auth/otp_screen.dart';
import '../../../screen/landing_screen.dart';
import '../../../server/repository.dart';
import '../../../service/authentication_service.dart';

class AuthRepo {
  static String verId = "";
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static Repository? repository;
 static AuthUser? userServerData;
   
  static Future<void> verifyPhoneNumber(  BuildContext context, String number,  Function value ) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+91$number',
      verificationCompleted: (PhoneAuthCredential credential) {
        signInWithPhoneNumber(
            context, credential.verificationId!, credential.smsCode!);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        verId = verificationId;
        print("verficationId $verId");
        Navigator.push(context, MaterialPageRoute(builder: (ctx){
          return const otpScreen();
        }));
        print("code sent");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    ).then((e)=> value(false)
    
     );
    
    ;
  }

  static void logoutApp(BuildContext context) async {
    await _firebaseAuth.signOut();
    // ignore: use_build_context_synchronously
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (ctx) => const LoginPage(),
    //   ),
    // );
  }

  static Future<void>  submitOtp(BuildContext context, String otp) async{
     try {
      await  signInWithPhoneNumber(context, verId, otp);
       
     } catch (e) {
         print('Error signing in with phone number: $e');
     }
   
  }

  static Future<void> signInWithPhoneNumber(
      BuildContext context, String verificationId, String smsCode) async {
    try {
       print("sms $smsCode");
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      print(userCredential.user!.phoneNumber);
       print("uid ${userCredential.user!.uid}");
   userServerData =     await  repository!.getFirebaseAuthUser(
        uid: userCredential.user!.uid,
        email: "",
        phone:userCredential.user!.phoneNumber,
      );
            print("uid ${userServerData}");
     // authService.updateUser(user);
      print("Login successful");

      // TODO: Navigate to home page
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return  LandingScreen();
      }));
    } catch (e) {
      print('Error signing in with phone number: $e');
    }
  }
}