import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_doctor_app/constant/constant.dart';
import 'package:my_doctor_app/pages/screens.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  var firebaseUser;
  String status;
  Future<String> currentUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser.uid;
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => decider(),
        ),
      );
    });

    // try {
    //   currentUser().then(
    //     (userId) {
    //       setState(
    //         () {
    //           (userId == null)
    //               ? Timer(Duration(seconds: 3), () {
    //                   Navigator.of(context).pushReplacement(
    //                     MaterialPageRoute(
    //                       builder: (BuildContext context) => Login(),
    //                     ),
    //                   );
    //                 })
    //               : Timer(Duration(seconds: 3), () {
    //                   Navigator.pushReplacement(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (BuildContext context) => Login()));
    //                 });
    //         },
    //       );
    //     },
    //   );
    // } catch (e) {
    //   print(e.toString());
    // }

    print(firebaseUser);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  decider() {
    return StreamBuilder<Object>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        User user = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          Scaffold(
            backgroundColor: whiteColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: _offsetAnimation,
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        image: DecorationImage(
                          image: AssetImage('assets/icon.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (user == null) {
            return Login();
          }
          return BottomBar(
            uid: user.uid,
          );
        }

        return Scaffold(
          backgroundColor: whiteColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _offsetAnimation,
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      image: DecorationImage(
                        image: AssetImage('assets/icon.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SlideTransition(
              position: _offsetAnimation,
              child: Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  image: DecorationImage(
                    image: AssetImage('assets/icon.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
