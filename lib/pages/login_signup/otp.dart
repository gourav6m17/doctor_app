import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_doctor_app/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:my_doctor_app/pages/screens.dart';
import 'package:my_doctor_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  var OTPcontroller = TextEditingController();
  // var secondController = TextEditingController();
  // var thirdController = TextEditingController();
  // var fourthController = TextEditingController();
  FocusNode secondFocusNode = FocusNode();
  // FocusNode thirdFocusNode = FocusNode();
  // FocusNode fourthFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // var uid = FirebaseAuth.instance.currentUser.uid;

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

    verifyOTP(BuildContext context) {
      try {
        Provider.of<AuthProvider>(context, listen: false)
            .verifyOTP(OTPcontroller.text.toString())
            .then((_) {
          if (Provider.of<AuthProvider>(context, listen: false)
              .user
              .additionalUserInfo
              .isNewUser) {
            return Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Register()));
          } else {
            return Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => BottomBar()));
          }

          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => Register(),
          //     ));
        }).catchError((e) {
          String errorMsg = 'Cant authentiate you Right now, Try again later!';
          if (e.toString().contains("ERROR_SESSION_EXPIRED")) {
            errorMsg = "Session expired, please resend OTP!";
          } else if (e.toString().contains("ERROR_INVALID_VERIFICATION_CODE")) {
            errorMsg = "You have entered wrong OTP!";
          } else if (OTPcontroller.text.isEmpty) {
            errorMsg = "Please enter OTP";
          }
          _showErrorDialog(context, errorMsg);
        });
      } catch (e) {
        _showErrorDialog(context, e.toString());
      }
    }

    // loadingDialog() {
    //   showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       // return object of type Dialog
    //       return Dialog(
    //         elevation: 0.0,
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(10.0)),
    //         child: Wrap(
    //           children: [
    //             Container(
    //               padding: EdgeInsets.all(20.0),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: <Widget>[
    //                   SpinKitRing(
    //                     color: primaryColor,
    //                     size: 40.0,
    //                     lineWidth: 1.0,
    //                   ),
    //                   SizedBox(height: 25.0),
    //                   Text(
    //                     'Please Wait..',
    //                     style: greySmallTextStyle,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   );
    //   Timer(
    //       Duration(seconds: 3),
    //       () => Navigator.push(
    //           context,
    //           PageTransition(
    //               duration: Duration(milliseconds: 600),
    //               type: PageTransitionType.fade,
    //               child: Register())));
    // }

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
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                    child: Text(
                      'Verification',
                      style: loginBigTextStyle,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Enter the OTP code from the phone we just sent you.',
                      style: whiteSmallLoginTextStyle,
                    ),
                  ),
                  SizedBox(height: 50.0),
                  // OTP Box Start
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // 1 Start
                        Container(
                          width: width * 0.8,
                          height: 50.0,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color: Colors.grey[200].withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextField(
                            maxLength: 6,
                            controller: OTPcontroller,
                            style: inputOtpTextStyle,
                            keyboardType: TextInputType.number,
                            cursorColor: whiteColor,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 16, right: 4),
                              border: InputBorder.none,
                            ),
                            // onChanged: (v) {
                            //   FocusScope.of(context)
                            //       .requestFocus(secondFocusNode);
                            // },
                            //autofocus: true,
                          ),
                        ),
                        // 1 End
                        // 2 Start
                        // Container(
                        //   width: 50.0,
                        //   height: 50.0,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey[200].withOpacity(0.3),
                        //     borderRadius: BorderRadius.circular(5.0),
                        //   ),
                        //   child: TextField(
                        //     focusNode: secondFocusNode,
                        //     controller: secondController,
                        //     style: inputOtpTextStyle,
                        //     keyboardType: TextInputType.number,
                        //     cursorColor: whiteColor,
                        //     decoration: InputDecoration(
                        //       contentPadding: EdgeInsets.all(18.0),
                        //       border: InputBorder.none,
                        //     ),
                        //     onChanged: (v) {
                        //       FocusScope.of(context)
                        //           .requestFocus(thirdFocusNode);
                        //     },
                        //   ),
                        // ),
                        // // 2 End
                        // // 3 Start
                        // Container(
                        //   width: 50.0,
                        //   height: 50.0,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey[200].withOpacity(0.3),
                        //     borderRadius: BorderRadius.circular(5.0),
                        //   ),
                        //   child: TextField(
                        //     focusNode: thirdFocusNode,
                        //     controller: thirdController,
                        //     style: inputOtpTextStyle,
                        //     keyboardType: TextInputType.number,
                        //     cursorColor: whiteColor,
                        //     decoration: InputDecoration(
                        //       contentPadding: EdgeInsets.all(18.0),
                        //       border: InputBorder.none,
                        //     ),
                        //     onChanged: (v) {
                        //       FocusScope.of(context)
                        //           .requestFocus(fourthFocusNode);
                        //     },
                        //   ),
                        // ),
                        // // 3 End
                        // // 4 Start
                        // Container(
                        //   width: 50.0,
                        //   height: 50.0,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey[200].withOpacity(0.3),
                        //     borderRadius: BorderRadius.circular(5.0),
                        //   ),
                        //   child: TextField(
                        //     focusNode: fourthFocusNode,
                        //     controller: fourthController,
                        //     style: inputOtpTextStyle,
                        //     keyboardType: TextInputType.number,
                        //     cursorColor: whiteColor,
                        //     decoration: InputDecoration(
                        //       contentPadding: EdgeInsets.all(18.0),
                        //       border: InputBorder.none,
                        //     ),
                        //     onChanged: (v) {
                        //       loadingDialog();
                        //     },
                        //   ),
                        // ),
                        // // 4 End
                      ],
                    ),
                  ),
                  // OTP Box End
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("We've send otp to your mobile Please wait"),
                        // Text(
                        //   'Didn\'t receive OTP Code!',
                        //   style: greySmallTextStyle,
                        // ),
                        SizedBox(width: 10.0),
                        // InkWell(
                        //   onTap: () {},
                        //   child: Text(
                        //     'Resend',
                        //     style: inputLoginTextStyle,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30.0),
                      onTap: () {
                        verifyOTP(context);
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         duration: Duration(milliseconds: 600),
                        //         type: PageTransitionType.fade,
                        //         child: Register()));
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
                          'Submit',
                          style: inputLoginTextStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
