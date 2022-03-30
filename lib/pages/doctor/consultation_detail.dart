import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_doctor_app/constant/constant.dart';
import 'package:my_doctor_app/models/drModel.dart';
import 'package:my_doctor_app/pages/doctor/doctor_profile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:image_picker/image_picker.dart';

import '../bottom_bar.dart';

class ConsultationDetail extends StatefulWidget {
  final String doctorName,
      doctorType,
      doctorImage,
      doctorExp,
      time,
      date,
      price,
      typeOfDoctor;
  final DrModel drObj;
  final LatLng pos;
  final int selectedAppType;

  const ConsultationDetail(
      {Key key,
      @required this.doctorName,
      @required this.doctorType,
      @required this.doctorImage,
      @required this.doctorExp,
      @required this.time,
      @required this.date,
      @required this.price,
      @required this.selectedAppType,
      @required this.drObj,
      @required this.pos,
      @required this.typeOfDoctor})
      : super(key: key);

  @override
  _ConsultationDetailState createState() => _ConsultationDetailState();
}

class _ConsultationDetailState extends State<ConsultationDetail> {
  TextEditingController patientNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  String uid = FirebaseAuth.instance.currentUser.uid;
  var currentItemSelected;

  String imgUrl;
  var items = ['Male', 'Female', 'Other'];
  String typeofPatient;
  oldOrNew() {
    if (widget.selectedAppType == 1) {
      typeofPatient = "old appointment";
    } else {
      typeofPatient = "new appointment";
    }
  }

  addAppointmentData() async {
    oldOrNew();

    switch (typeofPatient) {
      case "old appointment":
        TaskSnapshot snapshot = await storage
            .ref()
            .child(
                "appointmentSlip/${patientNameController.text}+${mobileController.text}")
            .putFile(_image);
        if (snapshot.state == TaskState.success) {
          imgUrl = await snapshot.ref.getDownloadURL();
          db.collection("appointments").add({
            "user_uid": uid,
            'drName': widget.doctorName,
            'typeofDoctor': widget.typeOfDoctor,
            'date': widget.date,
            "drAdress": widget.drObj.drAddress,
            'time': widget.time,
            'price': widget.price,
            // 'posDr': (widget.pos == null) ? "" : widget.pos,
            'typeofPatient': typeofPatient.toString(),
            'patientname': patientNameController.text,
            'age': ageController.text,
            'mobileNo': mobileController.text,
            'address': addressController.text,
            'slipImg': imgUrl.toString(),
            'status': "confirmed"
          });
          final snackBar =
              SnackBar(content: Text("Your request is received! ✅"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        break;
      default:
        db.collection("appointments").add({
          "user_uid": uid,
          'drName': widget.doctorName,
          'typeofDoctor':
              widget.typeOfDoctor, //cough and fever, homopath or etc.
          'date': widget.date,
          "drAdress": widget.drObj.drAddress,
          'time': widget.time,
          'price': widget.price,
          // 'posDr': (widget.pos == null) ? "" : widget.pos,
          'typeofPatient': typeofPatient.toString(), //old or new
          'patientname': patientNameController.text,
          'age': ageController.text,
          'mobileNo': mobileController.text,
          'address': addressController.text, // text address
          'status': "confirmed",
          'gender': currentItemSelected.toString(),
        });
    }

    // try {
    // if (widget.selectedAppType == 1) {
    //   if (snapshot.state == TaskState.success) {
    //     imgUrl = await snapshot.ref.getDownloadURL();
    //     db.collection("appointments").doc(uid).set({
    //       'drName': widget.doctorName,
    //       'typeofDoctor': widget.typeOfDoctor,
    //       'date': widget.date,
    //       "drAdress": widget.drObj.location,
    //       'time': widget.time,
    //       'price': widget.price,
    //       // 'posDr': widget.pos,
    //       'typeofPatient': typeofPatient.toString(),
    //       'patientname': patientNameController.text,
    //       'age': ageController.text,
    //       'mobileNo': mobileController.text,
    //       'address': addressController.text,
    //       'slipImg': imgUrl.toString(),
    //     });
    //     final snackBar = SnackBar(content: Text("Your request is received! ✅"));
    //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //   }
    // } else{
    //   db.collection("appointments").doc(uid).set({
    //     'drName': widget.doctorName,
    //     'typeofDoctor': widget.typeOfDoctor,
    //     'date': widget.date,
    //     "drAdress": widget.drObj.location,
    //     'time': widget.time,
    //     'price': widget.price,
    //     // 'posDr': widget.pos,
    //     'typeofPatient': typeofPatient.toString(),
    //     'patientname': patientNameController.text,
    //     'age': ageController.text,
    //     'mobileNo': mobileController.text,
    //     'address': addressController.text,
    //   });
    // }
    // } catch (e) {
    //   final snackBar = SnackBar(content: Text("Something went Wrong!"));
    //   ScaffoldMessenger.of(context).showSnackBar(e + snackBar);
    // }
  }

  successOrderDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            height: 170.0,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 70.0,
                  width: 70.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.0),
                    border: Border.all(color: primaryColor, width: 1.0),
                  ),
                  child: Icon(
                    Icons.check,
                    size: 40.0,
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Success!",
                  style: greySmallBoldTextStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomBar()),
        );
      });
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
  // final patientList = [
  //   {'name': 'Allison Perry', 'image': 'assets/user/user_3.jpg'},
  //   {'name': 'John Smith', 'image': ''}
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        titleSpacing: 0.0,
        elevation: 0.0,
        title: Text(
          'Consultation Detail',
          style: appBarTitleTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        width: double.infinity,
        height: 70.0,
        padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        alignment: Alignment.center,
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: () {
            if (widget.selectedAppType == 1) {
              if (_image == null) {
                return _showErrorDialog(context, "Please attach old receipt!");
              }
            }
            if (currentItemSelected == null) {
              return _showErrorDialog(context, "Please select your gender!");
            }
            if (patientNameController.text.isEmpty) {
              return _showErrorDialog(context, "Enter your name");
            }
            if (ageController.text.isEmpty) {
              return _showErrorDialog(context, "Enter your age");
            }
            if (mobileController.text.length < 10) {
              return _showErrorDialog(
                  context, "Enter your correct mobile number");
            }
            if (addressController.text.isEmpty) {
              return _showErrorDialog(context, "Enter your address");
            }

            successOrderDialog();
            addAppointmentData();

            // Navigator.push(
            //     context,
            //     PageTransition(
            //         type: PageTransitionType.rightToLeft,
            //         duration: Duration(milliseconds: 600),
            //         child: Payment()));
          },
          child: Container(
            width: double.infinity,
            height: 50.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: primaryColor,
            ),
            child: Text(
              "Confirm",
              // 'Confirm & Pay',
              style: whiteColorButtonTextStyle,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 1.0,
            child: Container(
              color: whiteColor,
              padding:
                  EdgeInsets.only(top: fixPadding * 2.0, bottom: fixPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: widget.doctorImage,
                          child: Container(
                            width: 76.0,
                            height: 76.0,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(38.0),
                              border:
                                  Border.all(width: 0.3, color: primaryColor),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                  color: Colors.grey[300],
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(widget.doctorImage),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                        widthSpace,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Dr. ${widget.doctorName}',
                                      style: blackNormalBoldTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Wrap(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  duration: Duration(
                                                      milliseconds: 600),
                                                  type: PageTransitionType.fade,
                                                  child: DoctorProfile(
                                                    doctorImage:
                                                        widget.doctorImage,
                                                    doctorName:
                                                        widget.doctorName,
                                                    doctorType:
                                                        widget.doctorType,
                                                    experience:
                                                        widget.doctorExp,
                                                    pos: widget.pos,
                                                    address:
                                                        widget.drObj.drAddress,
                                                    about: widget.drObj.about,
                                                  )));
                                        },
                                        child: Text(
                                          'View Profile',
                                          style: primaryColorsmallBoldTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                widget.doctorType,
                                style: greyNormalTextStyle,
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                '${widget.doctorExp} Years Experience',
                                style: primaryColorNormalTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  heightSpace,
                  Container(
                    width: double.infinity,
                    height: 0.7,
                    color: greyColor.withOpacity(0.4),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: fixPadding,
                        right: fixPadding * 2.0,
                        left: fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.selectedAppType == 1
                            ? Text(
                                "\u{20B9} 0",
                              )
                            : Text(
                                "\u{20B9} ${widget.price}",
                              ),
                        widthSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.date_range,
                              size: 18.0,
                              color: greyColor,
                            ),
                            widthSpace,
                            Text(
                              widget.date,
                              style: blackNormalTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 18.0,
                              color: greyColor,
                            ),
                            widthSpace,
                            Text(
                              widget.time,
                              style: blackNormalTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                (widget.selectedAppType == 1) ? oldReceipt() : Container(),

                // Appointment for Start
                appointmentFor(),
                // Appointment for End
                genderSelect(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  genderSelect() {
    return Padding(
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
                color: blackColor,
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
    );
  }

  InkWell oldReceipt() {
    return InkWell(
      onTap: () {
        getImage();
      },
      child: CircleAvatar(
        radius: 55,
        backgroundColor: primaryColor,
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

  appointmentFor() {
    return Container(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Appointment for?',
            style: blackBigBoldTextStyle,
          ),
          heightSpace,
          heightSpace,
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200].withOpacity(0.8),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: TextField(
                keyboardType: TextInputType.name,
                controller: patientNameController,
                style: blackSmallLoginTextStyle,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  hintText: 'Patient name',
                  hintStyle: blackSmallLoginTextStyle,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          heightSpace,
          heightSpace,
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200].withOpacity(0.8),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                maxLength: 3,
                controller: ageController,
                style: blackSmallLoginTextStyle,
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 20.0),
                  hintText: 'Age',
                  hintStyle: blackSmallLoginTextStyle,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          heightSpace,
          heightSpace,
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200].withOpacity(0.8),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: TextField(
                maxLength: 10,
                controller: mobileController,
                keyboardType: TextInputType.phone,
                style: blackSmallLoginTextStyle,
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 20.0),
                  hintText: 'Mobile number',
                  hintStyle: blackSmallLoginTextStyle,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          heightSpace,
          heightSpace,
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200].withOpacity(0.8),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: TextField(
                keyboardType: TextInputType.streetAddress,
                controller: addressController,
                style: blackSmallLoginTextStyle,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  hintText: 'Address',
                  hintStyle: blackSmallLoginTextStyle,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          // ColumnBuilder(
          //   itemCount: patientList.length,
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   mainAxisSize: MainAxisSize.max,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   itemBuilder: (context, index) {
          //     final item = patientList[index];
          //     return Container(
          //       margin: (index == 0)
          //           ? EdgeInsets.only(top: 0.0)
          //           : EdgeInsets.only(top: fixPadding * 2.0),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           (item['image'] != '')
          //               ? Container(
          //                   width: 70.0,
          //                   height: 70.0,
          //                   decoration: BoxDecoration(
          //                     color: whiteColor,
          //                     borderRadius: BorderRadius.circular(35.0),
          //                     boxShadow: <BoxShadow>[
          //                       BoxShadow(
          //                         blurRadius: 1.0,
          //                         spreadRadius: 1.0,
          //                         color: Colors.grey[300],
          //                       ),
          //                     ],
          //                     image: DecorationImage(
          //                         image: AssetImage(item['image']),
          //                         fit: BoxFit.cover),
          //                   ),
          //                 )
          //               : Container(
          //                   width: 70.0,
          //                   height: 70.0,
          //                   alignment: Alignment.center,
          //                   decoration: BoxDecoration(
          //                     color: Colors.grey[100],
          //                     borderRadius: BorderRadius.circular(35.0),
          //                     boxShadow: <BoxShadow>[
          //                       BoxShadow(
          //                         blurRadius: 1.0,
          //                         spreadRadius: 1.0,
          //                         color: Colors.grey[300],
          //                       ),
          //                     ],
          //                   ),
          //                   child: Icon(
          //                     Icons.person,
          //                     size: 30.0,
          //                     color: greyColor,
          //                   ),
          //                 ),
          //           widthSpace,
          //           widthSpace,
          //           Expanded(
          //             child: Text(
          //               item['name'],
          //               style: blackNormalBoldTextStyle,
          //             ),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
          // heightSpace,
          // heightSpace,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Icon(
          //       Icons.add,
          //       size: 25.0,
          //       color: primaryColor,
          //     ),
          //     widthSpace,
          //     Text(
          //       'Add Patient',
          //       style: primaryColorNormalBoldTextStyle,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
