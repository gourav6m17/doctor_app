import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  UserCredential user;
  var userInDb;
  User currentUser;

  String verificationId;
  final TextEditingController phoneController = TextEditingController();

  Future<void> verifyPhone(String countryCode, String mobile) async {
    var mobileToSend = mobile;
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
    };

    try {
      await _firebaseAuth.verifyPhoneNumber(
          timeout: const Duration(milliseconds: 10000),
          phoneNumber: mobileToSend,
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            //userSnapshot then where uid=_firebaseAuth.currentUser.
            print(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException exceptio) {
            if (exceptio.code == 'invalid-phone-number') {
              print('The provided phone number is not valid.');
            }
          },
          codeSent: smsOTPSent,
          codeAutoRetrievalTimeout: (String verId) {
            this.verificationId = verId;
          });
    } catch (e) {}
  }

  Future<void> verifyOTP(String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      user = await _firebaseAuth.signInWithCredential(credential);
      currentUser = _firebaseAuth.currentUser;
      print(user);
      // if (user.additionalUserInfo.isNewUser) {
      //   return Navigator.pushReplacement(BuildContext context, MaterialPageRoute);
      // }

      if (currentUser.uid != "") {
        print(currentUser.uid);
      }
      // db
      //     .collection("user")
      //     .where("uid", isEqualTo: currentUser.uid)
      //     .get()
      //     .then((value) => value.docs.forEach((element) {
      //           userInDb = element.data().isNotEmpty;
      //         }));
    } catch (e) {
      throw e;
    }
  }

  showError(error) {
    throw error.toString();
  }
}
