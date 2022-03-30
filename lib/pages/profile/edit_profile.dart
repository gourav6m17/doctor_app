import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_doctor_client/constant/constant.dart';

class EditProfile extends StatefulWidget {
  final String name, email, age, image;

  const EditProfile(
      {Key key,
      @required this.name,
      @required this.email,
      @required this.age,
      this.image})
      : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String name, email, age;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  var uid = FirebaseAuth.instance.currentUser.uid;
  FirebaseStorage storage = FirebaseStorage.instance;
  String UserImgUrl;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    ageController.text = widget.age;
    emailController.text = widget.email;
  }

  File _image;
  final picker = ImagePicker();
  Future getImageGallery() async {
    final pickedFileFromGallery =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFileFromGallery != null) {
        _image = File(pickedFileFromGallery.path);
      } else {
        print("Image is not added!");
      }
    });
  }

  Future getImageCamera() async {
    final pickedFileFromCamera =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFileFromCamera != null) {
        _image = File(pickedFileFromCamera.path);
      } else {
        print("Image is not added!");
      }
    });
  }

  Future<void> updateProfile() async {
    if (_image != null) {
      TaskSnapshot snapshot =
          await storage.ref().child("user/$uid+.jpg").putFile(_image);
      if (snapshot.state == TaskState.success) {
        UserImgUrl = await snapshot.ref.getDownloadURL();
      }
      try {
        db.collection("user").doc(uid).update({
          'userName': (name == null) ? widget.name : name,
          'userEmail': (email == null) ? widget.email : email,
          'userAge': (age == null) ? widget.age : age,
          'userImage': (UserImgUrl == null) ? widget.image : UserImgUrl,
        });
        final snackBar = SnackBar(content: Text("Your Profile is updated! ✅"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } catch (e) {
        print(e.toString());
      }
    } else {
      try {
        db.collection("user").doc(uid).update({
          'userName': (name == null) ? widget.name : name,
          'userEmail': (email == null) ? widget.email : email,
          'userAge': (age == null) ? widget.age : age,
          'userImage': (UserImgUrl == null) ? widget.image : UserImgUrl,
        });
        final snackBar = SnackBar(content: Text("Your Profile is updated! ✅"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    changeFullName() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Change Full Name",
                        style: blackHeadingTextStyle,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      TextFormField(
                        controller: nameController,
                        style: blackColorButtonTextStyle,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Enter Your Full Name',
                          hintStyle: greySmallTextStyle,
                        ),
                      ),
                      SizedBox(height: 20.0),
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
                              setState(() {
                                name = nameController.text;
                                Navigator.pop(context);
                              });
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
                                'Okay',
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

    // changePassword() {
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
    //                   Text(
    //                     "Change Your Password",
    //                     style: blackHeadingTextStyle,
    //                   ),
    //                   SizedBox(
    //                     height: 25.0,
    //                   ),
    //                   TextField(
    //                     obscureText: true,
    //                     style: blackColorButtonTextStyle,
    //                     decoration: InputDecoration(
    //                       hintText: 'Old Password',
    //                       hintStyle: greySmallTextStyle,
    //                     ),
    //                   ),
    //                   TextField(
    //                     obscureText: true,
    //                     style: blackColorButtonTextStyle,
    //                     decoration: InputDecoration(
    //                       hintText: 'New Password',
    //                       hintStyle: greySmallTextStyle,
    //                     ),
    //                   ),
    //                   TextField(
    //                     obscureText: true,
    //                     style: blackColorButtonTextStyle,
    //                     decoration: InputDecoration(
    //                       hintText: 'Confirm New Password',
    //                       hintStyle: greySmallTextStyle,
    //                     ),
    //                   ),
    //                   SizedBox(height: 20.0),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: <Widget>[
    //                       InkWell(
    //                         onTap: () {
    //                           Navigator.pop(context);
    //                         },
    //                         child: Container(
    //                           width: (width / 3.5),
    //                           alignment: Alignment.center,
    //                           padding: EdgeInsets.all(10.0),
    //                           decoration: BoxDecoration(
    //                             color: Colors.grey[300],
    //                             borderRadius: BorderRadius.circular(5.0),
    //                           ),
    //                           child: Text(
    //                             'Cancel',
    //                             style: blackColorButtonTextStyle,
    //                           ),
    //                         ),
    //                       ),
    //                       InkWell(
    //                         onTap: () {
    //                           Navigator.pop(context);
    //                         },
    //                         child: Container(
    //                           width: (width / 3.5),
    //                           alignment: Alignment.center,
    //                           padding: EdgeInsets.all(10.0),
    //                           decoration: BoxDecoration(
    //                             color: primaryColor,
    //                             borderRadius: BorderRadius.circular(5.0),
    //                           ),
    //                           child: Text(
    //                             'Okay',
    //                             style: whiteColorButtonTextStyle,
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   );
    // }

    // changePhoneNumber() {
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
    //                   Text(
    //                     "Change Phone Number",
    //                     style: blackHeadingTextStyle,
    //                   ),
    //                   SizedBox(
    //                     height: 25.0,
    //                   ),
    //                   TextField(
    //                     controller: phoneController,
    //                     style: blackColorButtonTextStyle,
    //                     keyboardType: TextInputType.number,
    //                     decoration: InputDecoration(
    //                       hintText: 'Enter Phone Number',
    //                       hintStyle: greySmallTextStyle,
    //                     ),
    //                   ),
    //                   SizedBox(height: 20.0),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: <Widget>[
    //                       InkWell(
    //                         onTap: () {
    //                           Navigator.pop(context);
    //                         },
    //                         child: Container(
    //                           width: (width / 3.5),
    //                           alignment: Alignment.center,
    //                           padding: EdgeInsets.all(10.0),
    //                           decoration: BoxDecoration(
    //                             color: Colors.grey[300],
    //                             borderRadius: BorderRadius.circular(5.0),
    //                           ),
    //                           child: Text(
    //                             'Cancel',
    //                             style: blackColorButtonTextStyle,
    //                           ),
    //                         ),
    //                       ),
    //                       InkWell(
    //                         onTap: () {
    //                           setState(() {
    //                             phone = phoneController.text;
    //                             Navigator.pop(context);
    //                           });
    //                         },
    //                         child: Container(
    //                           width: (width / 3.5),
    //                           alignment: Alignment.center,
    //                           padding: EdgeInsets.all(10.0),
    //                           decoration: BoxDecoration(
    //                             color: primaryColor,
    //                             borderRadius: BorderRadius.circular(5.0),
    //                           ),
    //                           child: Text(
    //                             'Okay',
    //                             style: whiteColorButtonTextStyle,
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   );
    // }

    changeEmail() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Change Email",
                        style: blackHeadingTextStyle,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      TextField(
                        controller: emailController,
                        style: blackColorButtonTextStyle,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter Your Email Address',
                          hintStyle: greySmallTextStyle,
                        ),
                      ),
                      SizedBox(height: 20.0),
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
                              child: Text('Cancel',
                                  style: blackColorButtonTextStyle),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                email = emailController.text;
                                Navigator.pop(context);
                              });
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
                                'Okay',
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

    changeAge() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Change Age",
                        style: blackHeadingTextStyle,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      TextField(
                        controller: ageController,
                        style: blackColorButtonTextStyle,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Your Age',
                          hintStyle: greySmallTextStyle,
                        ),
                      ),
                      SizedBox(height: 20.0),
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
                              child: Text('Cancel',
                                  style: blackColorButtonTextStyle),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                age = ageController.text;
                                Navigator.pop(context);
                              });
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
                                'Okay',
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

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: blackColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              updateProfile();
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(fixPadding),
              alignment: Alignment.center,
              child: Text(
                'Save',
                style: primaryColorNormalTextStyle,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Profile Image Start
              InkWell(
                onTap: _selectOptionBottomSheet,
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  margin: EdgeInsets.all(fixPadding * 4.0),
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 2.0, color: whiteColor),
                    image: DecorationImage(
                      image: _image != null
                          ? FileImage(_image)
                          : NetworkImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    height: 22.0,
                    width: 22.0,
                    margin: EdgeInsets.all(fixPadding / 2),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11.0),
                      border: Border.all(
                          width: 1.0, color: whiteColor.withOpacity(0.7)),
                      color: Colors.orange,
                    ),
                    child: Icon(Icons.add, color: whiteColor, size: 15.0),
                  ),
                ),
              ),
              // Profile Image End
              // Full Name Start
              InkWell(
                onTap: changeFullName,
                child:
                    getTile('Full Name', (name == null) ? widget.name : name),
              ),
              // Full Name End
              // Password Start
              // InkWell(
              //   onTap: changePassword,
              //   child: getTile('Password', '******'),
              // ),
              // Password End
              // Phone Start
              // InkWell(
              //   onTap: changePhoneNumber,
              //   child: getTile('Phone', phone),
              // ),
              // Phone End
              // Email Start
              InkWell(
                onTap: changeEmail,
                child: getTile('Email', (email == null) ? widget.email : email),
              ),
              // Email End
              InkWell(
                onTap: changeAge,
                child: getTile("Age", (age == null) ? widget.age : age),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getTile(String title, String value) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
          right: fixPadding, left: fixPadding, bottom: fixPadding * 1.5),
      padding: EdgeInsets.only(
        right: fixPadding,
        left: fixPadding,
        top: fixPadding * 2.0,
        bottom: fixPadding * 2.0,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 1.5,
            spreadRadius: 1.5,
            color: Colors.grey[200],
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: width - 80.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: (width - 80.0) / 2.4,
                  child: Text(
                    title,
                    style: greyNormalTextStyle,
                  ),
                ),
                Container(
                  width: (width - 80.0) / 2.0,
                  child: Text(
                    value,
                    style: blackNormalTextStyle,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16.0,
            color: Colors.grey.withOpacity(0.6),
          ),
        ],
      ),
    );
  }

  // Bottom Sheet for Select Options (Camera or Gallery) Start Here
  void _selectOptionBottomSheet() {
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: whiteColor,
            child: new Wrap(
              children: <Widget>[
                Container(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: width,
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Choose Option',
                            textAlign: TextAlign.center,
                            style: blackHeadingTextStyle,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            getImageCamera();
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.black.withOpacity(0.7),
                                  size: 18.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('Camera', style: blackSmallTextStyle),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            getImageGallery();
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.photo_album,
                                  color: Colors.black.withOpacity(0.7),
                                  size: 18.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Upload from Gallery',
                                  style: blackSmallTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
  // Bottom Sheet for Select Options (Camera or Gallery) Ends Here
}
