import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:user_doctor_client/constant/constant.dart';
import 'package:user_doctor_client/pages/login_signup/otp.dart';
import 'package:user_doctor_client/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<ScaffoldState>();

  DateTime currentBackPressTime;
  String phoneNumber;
  String phoneIsoCode;

  String countryCode = "+91";
  String initialCountry = 'IN';
  // PhoneNumber number = PhoneNumber(isoCode: 'IN');
  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error Occured'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK!'),
          )
        ],
      ),
    );
  }

  verifyPhone(BuildContext context) {
    try {
      Provider.of<AuthProvider>(context, listen: false)
          .verifyPhone(
              countryCode,
              countryCode +
                  Provider.of<AuthProvider>(context, listen: false)
                      .phoneController
                      .text
                      .toString())
          .then((value) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OTPScreen(),
        ));
      }).catchError((e) {
        String errorMsg = 'Cant Authenticate you, Try Again Later';
        if (Provider.of<AuthProvider>(context, listen: false)
                .phoneController
                .text
                .length <
            10) {
          String errorMsg = "Please enter mobile number";
          _showErrorDialog(context, errorMsg);
        } else if (e.toString().contains(
            'We have blocked all requests from this device due to unusual activity. Try again later.')) {
          errorMsg = 'Please wait as you have used limited number request';
        }
        _showErrorDialog(context, errorMsg);
      });
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/doctor_bg.jpg'), fit: BoxFit.cover),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.3, 0.5, 0.7, 0.9],
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.55),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(1.0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: WillPopScope(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Form(
                  key: _formKey,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, left: 20.0),
                        child: Text(
                          'Welcome back',
                          style: loginBigTextStyle,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Login in your account',
                          style: whiteSmallLoginTextStyle,
                        ),
                      ),
                      SizedBox(height: 70.0),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200].withOpacity(0.3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: InternationalPhoneNumberInput(
                            textStyle: inputLoginTextStyle,
                            selectorTextStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                            textFieldController: Provider.of<AuthProvider>(
                                    context,
                                    listen: false)
                                .phoneController,
                            inputBorder: InputBorder.none,
                            inputDecoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20.0),
                              hintText: 'Phone Number',
                              hintStyle: inputLoginTextStyle,
                              border: InputBorder.none,
                            ),
                            onInputChanged: (PhoneNumber value) {},
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Padding(
                        padding: EdgeInsets.only(right: 20.0, left: 20.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30.0),
                          onTap: () {
                            if (Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .phoneController
                                    .text
                                    .length <
                                10) {
                              _showErrorDialog(
                                  context, "Please enter mobile number");
                              return;
                            }
                            verifyPhone(context);
                            // Navigator.push(
                            //     context,
                            //     PageTransition(
                            //         duration: Duration(milliseconds: 600),
                            //         type: PageTransitionType.fade,
                            //         child: OTPScreen()));
                          },
                          child: Container(
                            height: 50.0,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.bottomRight,
                                stops: [0.1, 0.5, 0.9],
                                colors: [
                                  Colors.blue[300].withOpacity(0.8),
                                  Colors.blue[500].withOpacity(0.8),
                                  Colors.blue[800].withOpacity(0.8),
                                ],
                              ),
                            ),
                            child: Text(
                              'Continue',
                              style: inputLoginTextStyle,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'We\'ll send OTP for Verification',
                        textAlign: TextAlign.center,
                        style: whiteSmallLoginTextStyle,
                      ),
                      SizedBox(height: 30.0),
                      // InkWell(
                      //   onTap: () {},
                      //   child: Padding(
                      //     padding: EdgeInsets.all(20.0),
                      //     child: Container(
                      //       padding: EdgeInsets.all(15.0),
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(30.0),
                      //         color: Color(0xFF3B5998),
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: <Widget>[
                      //           Image.asset(
                      //             'assets/facebook.png',
                      //             height: 25.0,
                      //             fit: BoxFit.fitHeight,
                      //           ),
                      //           SizedBox(width: 10.0),
                      //           Text(
                      //             'Log in with Facebook',
                      //             style: whiteSmallLoginTextStyle,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // InkWell(
                      //   onTap: () {},
                      //   child: Padding(
                      //     padding: EdgeInsets.all(20.0),
                      //     child: Container(
                      //       padding: EdgeInsets.all(15.0),
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(30.0),
                      //         color: Colors.white,
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: <Widget>[
                      //           Image.asset(
                      //             'assets/google.png',
                      //             height: 25.0,
                      //             fit: BoxFit.fitHeight,
                      //           ),
                      //           SizedBox(width: 10.0),
                      //           Text(
                      //             'Log in with Google',
                      //             style: blackSmallLoginTextStyle,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              onWillPop: () async {
                bool backStatus = onWillPop();
                if (backStatus) {
                  exit(0);
                }
                return false;
              },
            ),
          ),
        ],
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }
}
