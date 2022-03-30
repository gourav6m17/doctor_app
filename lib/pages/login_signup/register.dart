import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_doctor_app/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:my_doctor_app/pages/screens.dart';
import 'package:my_doctor_app/provider/auth_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController genderController = TextEditingController();

  var currentItemSelected;
  FirebaseStorage storage = FirebaseStorage.instance;
  var userImgUrl;

  @override
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

  File _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("Image is not added!");
      }
    });
  }

  InkWell userPhoto() {
    return InkWell(
      onTap: () {
        getImage();
      },
      child: CircleAvatar(
        radius: 55,
        //backgroundColor: primaryColor,
        child: _image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  _image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fitHeight,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50)),
                width: 100,
                height: 100,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.grey[800],
                ),
              ),
      ),
    );
  }

  Widget build(BuildContext context) {
    var items = ['Male', 'Female', 'Other'];
    FirebaseFirestore db = FirebaseFirestore.instance;
    var uid = FirebaseAuth.instance.currentUser.uid;
    Future<void> addUser() async {
      TaskSnapshot snapshot =
          await storage.ref().child("user/$uid").putFile(_image);
      if (snapshot.state == TaskState.success) {
        userImgUrl = await snapshot.ref.getDownloadURL();
        db.collection("user").doc(uid).set({
          'userImage': userImgUrl,
          'userName': userNameController.text,
          'userMobile': Provider.of<AuthProvider>(context, listen: false)
              .phoneController
              .text,
          'userEmail': emailController.text,
          'userAge': ageController.text,
          'userGender': currentItemSelected.toString(),
          'userUid': uid,
        }).then((value) {
          return Fluttertoast.showToast(
            msg: 'Infomation added successful!',
            backgroundColor: Colors.black,
            textColor: whiteColor,
          );
        }).catchError((onError) => Fluttertoast.showToast(
              msg: 'Failed to add information! $onError',
              backgroundColor: Colors.black,
              textColor: whiteColor,
            ));
      }
    }

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
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                  ),
                ),
                body: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, left: 20.0),
                      child: Text(
                        'Profile',
                        style: loginBigTextStyle,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Add your info',
                        style: whiteSmallLoginTextStyle,
                      ),
                    ),
                    Center(child: userPhoto()),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200].withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          controller: userNameController,
                          style: inputLoginTextStyle,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20.0),
                            hintText: 'Full name',
                            hintStyle: inputLoginTextStyle,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200].withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: inputLoginTextStyle,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20.0),
                            hintText: 'Email',
                            hintStyle: inputLoginTextStyle,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200].withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          controller: ageController,
                          keyboardType: TextInputType.datetime,
                          style: inputLoginTextStyle,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20.0),
                            hintText: 'Age',
                            hintStyle: inputLoginTextStyle,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200].withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: Center(
                          child: DropdownButton<dynamic>(
                            elevation: 2,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            iconSize: 35.0,
                            iconEnabledColor: Colors.black,
                            hint: Text(
                              '   Please choose a gender',
                              style: TextStyle(
                                color: whiteColor,
                              ),
                            ),
                            value: currentItemSelected,
                            onChanged: (newValueSelected) {
                              setState(() {
                                currentItemSelected = newValueSelected;
                              });
                            },
                            items: items.map((dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                child: Text(
                                  dropDownStringItem,
                                  style: TextStyle(
                                    color: blackColor,
                                  ),
                                ),
                                value: dropDownStringItem,
                              );
                            }).toList(),
                          ),
                        ),
                        // child: TextField(

                        //   controller: genderController,
                        //   style: inputLoginTextStyle,
                        //   decoration: InputDecoration(
                        //     contentPadding: EdgeInsets.only(left: 20.0),
                        //     hintText: 'Gender',
                        //     hintStyle: inputLoginTextStyle,
                        //     border: InputBorder.none,
                        //   ),
                        // ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        onTap: () {
                          if (_image == null) {
                            return _showErrorDialog(
                                context, "Please add photo!");
                          }
                          if (userNameController.text.isEmpty) {
                            return _showErrorDialog(context, "Fill your name");
                          }
                          if (emailController.text.isEmpty) {
                            return _showErrorDialog(
                                context, "Fill your email address");
                          }
                          if (ageController.text.isEmpty) {
                            return _showErrorDialog(context, "Fill your age");
                          }
                          if (currentItemSelected == null) {
                            return _showErrorDialog(
                                context, "Fill your gender");
                          }
                          addUser();
                          Navigator.push(
                              context,
                              PageTransition(
                                  duration: Duration(milliseconds: 600),
                                  type: PageTransitionType.fade,
                                  child: BottomBar()));
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
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
              onWillPop: () async {
                bool backStatus = onWillPop();
                if (backStatus) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
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
    return true;
  }
}
