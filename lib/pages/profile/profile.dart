import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_doctor_app/constant/constant.dart';
import 'package:my_doctor_app/models/UserModel.dart';
import 'package:my_doctor_app/pages/screens.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  var uid = FirebaseAuth.instance.currentUser.uid;
  UserModel userObj;
  List<UserModel> userList = [];
  Map<String, dynamic> data = Map<String, dynamic>();
  String salphnNo = "+918226963037";
  Future<void> _launched;

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future<UserModel> getUserDetail() async {
    final documentSnapshot = await db.collection("user").doc(uid).get();
    data = documentSnapshot.data();
    userObj = UserModel.fromJson(data);
    userList.add(userObj);
    return userObj;
  }

  Future<void> _logout() async {
    try {
      // signout code
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  logoutDialogue() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "You sure want to logout?",
                      style: blackHeadingTextStyle,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: (width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'Cancel',
                              style: blackColorButtonTextStyle,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _logout();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Container(
                            width: (width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'Log out',
                              style: whiteColorButtonTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(80.0),
      //   child: Container(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         AppBar(
      //           backgroundColor: whiteColor,
      //           elevation: 1.0,
      //           automaticallyImplyLeading: false,
      //           title: Row(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               widthSpace,
      //             ],
      //           ),
      //           actions: [
      //             Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               crossAxisAlignment: CrossAxisAlignment.end,
      //               children: [
      //                 InkWell(
      //                   onTap: () {
      //                     Navigator.push(
      //                         context,
      //                         PageTransition(
      //                             duration: Duration(milliseconds: 500),
      //                             type: PageTransitionType.rightToLeft,
      //                             child: EditProfile()));
      //                   },
      //                   child: Container(
      //                     padding: EdgeInsets.only(right: 15.0),
      //                     child: Text(
      //                       'Edit Profile',
      //                       style: primaryColorsmallBoldTextStyle,
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             )
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: FutureBuilder<UserModel>(
        future: getUserDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text("Please Wait"),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            return ListView(
              children: [
                heightSpace,
                heightSpace,
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23.0),
                          border: Border.all(width: 0.2, color: greyColor),
                          image: DecorationImage(
                            image: (snapshot.data.userImage == null)
                                ? AssetImage("assets/user/user_1.jpg")
                                : NetworkImage(snapshot.data.userImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      heightSpace,
                      Text(
                        snapshot.data.userName ?? "user",
                        style: appBarTitleTextStyle,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(fixPadding * 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account Info',
                        style: blackHeadingTextStyle,
                      ),
                      heightSpace,
                      heightSpace,
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  duration: Duration(milliseconds: 500),
                                  type: PageTransitionType.rightToLeft,
                                  child: EditProfile(
                                    email: snapshot.data.userEmail,
                                    name: snapshot.data.userName,
                                    age: snapshot.data.userAge,
                                    image: snapshot.data.userImage,
                                  )));
                        },
                        child: listItem(
                            primaryColor, Icons.person, 'Edit Profile'),
                      ),
                      heightSpace,
                      //listItem(Colors.red, Icons.assignment, 'My History'),
                    ],
                  ),
                ),
                divider(),
                Container(
                  padding: EdgeInsets.all(fixPadding * 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About App',
                        style: blackHeadingTextStyle,
                      ),
                      heightSpace,
                      heightSpace,
                      //listItem(Colors.orange, Icons.local_offer, 'Coupon Codes'),
                      heightSpace,
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  duration: Duration(milliseconds: 500),
                                  type: PageTransitionType.rightToLeft,
                                  child: AboutUs()));
                        },
                        child:
                            listItem(primaryColor, Icons.touch_app, 'About Us'),
                      ),
                      heightSpace,
                      //listItem(Colors.green, Icons.star_border, 'Rate Us'),
                      heightSpace,
                      InkWell(
                        onTap: () {
                          setState(() {
                            _launched = _makePhoneCall("tel:$salphnNo");
                          });
                        },
                        child: listItem(Colors.red, Icons.help_outline, 'Help'),
                      )
                    ],
                  ),
                ),
                divider(),
                Container(
                  padding: EdgeInsets.all(fixPadding * 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => logoutDialogue(),
                        child:
                            listItem(Colors.teal, Icons.exit_to_app, 'Logout'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return CircularProgressIndicator();
          //  ListView(
          //   children: [
          //     heightSpace,
          //     heightSpace,
          //     Center(
          //       child: Column(
          //         children: [
          //           Container(
          //             width: 100.0,
          //             height: 100.0,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(23.0),
          //               border: Border.all(width: 0.2, color: greyColor),
          //               image: DecorationImage(
          //                 image: (snapshot.data.image == null)
          //                     ? AssetImage("assets/user/user_1.jpg")
          //                     : NetworkImage(snapshot.data.image),
          //                 fit: BoxFit.cover,
          //               ),
          //             ),
          //           ),
          //           heightSpace,
          //           Text(
          //             snapshot.data.name,
          //             style: appBarTitleTextStyle,
          //           ),
          //         ],
          //       ),
          //     ),
          //     Container(
          //       padding: EdgeInsets.all(fixPadding * 2.0),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'Account Info',
          //             style: blackHeadingTextStyle,
          //           ),
          //           heightSpace,
          //           heightSpace,
          //           InkWell(
          //             onTap: () {
          //               Navigator.push(
          //                   context,
          //                   PageTransition(
          //                       duration: Duration(milliseconds: 500),
          //                       type: PageTransitionType.rightToLeft,
          //                       child: EditProfile(
          //                         email: snapshot.data.email,
          //                         name: snapshot.data.name,
          //                         age: snapshot.data.age,
          //                         image: snapshot.data.image,
          //                       )));
          //             },
          //             child:
          //                 listItem(primaryColor, Icons.person, 'Edit Profile'),
          //           ),
          //           heightSpace,
          //           //listItem(Colors.red, Icons.assignment, 'My History'),
          //         ],
          //       ),
          //     ),
          //     divider(),
          //     Container(
          //       padding: EdgeInsets.all(fixPadding * 2.0),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'About App',
          //             style: blackHeadingTextStyle,
          //           ),
          //           heightSpace,
          //           heightSpace,
          //           //listItem(Colors.orange, Icons.local_offer, 'Coupon Codes'),
          //           heightSpace,
          //           InkWell(
          //             onTap: () {
          //               Navigator.push(
          //                   context,
          //                   PageTransition(
          //                       duration: Duration(milliseconds: 500),
          //                       type: PageTransitionType.rightToLeft,
          //                       child: AboutUs()));
          //             },
          //             child:
          //                 listItem(primaryColor, Icons.touch_app, 'About Us'),
          //           ),
          //           heightSpace,
          //           //listItem(Colors.green, Icons.star_border, 'Rate Us'),
          //           heightSpace,
          //           InkWell(
          //             onTap: () {
          //               setState(() {
          //                 _launched = _makePhoneCall("tel:$salphnNo");
          //               });
          //             },
          //             child: listItem(Colors.red, Icons.help_outline, 'Help'),
          //           )
          //         ],
          //       ),
          //     ),
          //     divider(),
          //     Container(
          //       padding: EdgeInsets.all(fixPadding * 2.0),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           InkWell(
          //             onTap: () => logoutDialogue(),
          //             child: listItem(Colors.teal, Icons.exit_to_app, 'Logout'),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // );
        },
      ),
    );
  }

  divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      width: MediaQuery.of(context).size.width - fixPadding * 4.0,
      height: 1.0,
      color: Colors.grey[200],
    );
  }

  listItem(color, icon, title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(width: 0.3, color: color),
                  color: color.withOpacity(0.15),
                ),
                child: Icon(
                  icon,
                  size: 22.0,
                  color: color,
                ),
              ),
              widthSpace,
              Expanded(
                child: Text(
                  title,
                  style: blackNormalBoldTextStyle,
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: blackColor,
          size: 14.0,
        ),
      ],
    );
  }
}
