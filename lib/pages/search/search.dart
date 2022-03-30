import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:page_transition/page_transition.dart';
import 'package:user_doctor_client/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:user_doctor_client/models/SearchModel.dart';
import 'package:user_doctor_client/models/drModel.dart';
import 'package:user_doctor_client/pages/doctor/doctor_time_slot.dart';
import 'package:user_doctor_client/widget/column_builder.dart';

enum BookType { oldApp, newApp }

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DrModel drObj;
  List<DrModel> drList = [];

  final doctorTypeList = [
    {'type': 'Home Visit', 'image': 'assets/icons/homevisit.png'},
    {'type': 'Coronavirus', 'image': 'assets/icons/coronavirus.png'},
    {'type': 'Telemedicine', 'image': 'assets/icons/telemedicine.png'},
    {'type': 'Cough and Fever', 'image': 'assets/icons/patient.png'},
    {'type': 'Homoeopath', 'image': 'assets/icons/stethoscope.png'},
    {'type': 'Gynecologist', 'image': 'assets/icons/woman.png'},
    {'type': 'Pediatrician', 'image': 'assets/icons/pediatrician.png'},
    {'type': 'Physiotherapist', 'image': 'assets/icons/physiotherapist.png'},
    {'type': 'Nutritionist', 'image': 'assets/icons/nutritionist.png'},
    {'type': 'Spine and Pain Specialist', 'image': 'assets/icons/pain.png'},
    {'type': 'Dentist', 'image': 'assets/icons/dentist.png'},
    {'type': 'Physician', 'image': 'assets/icons/Physician.png'},
    {'type': 'Eye Specialist', 'image': 'assets/icons/eyeSpecialist.png'},
    {'type': 'Orthopedics', 'image': 'assets/icons/orthopedics.png'},
    {'type': 'Neurology', 'image': 'assets/icons/Neurology.png'},
    {'type': 'Cardiologist', 'image': 'assets/icons/Cardiologist.png'},
    {'type': 'Ayurvedic', 'image': 'assets/icons/ayurvedic.png'},
    {
      'type': 'Gastroentero Logist',
      'image': 'assets/icons/gastroenterologist.png'
    },
    {'type': 'Pulmonologist', 'image': 'assets/icons/pulmonologist.png'},
    {'type': 'Cancer', 'image': 'assets/icons/ribbon.png'},
    {'type': 'Surgeon', 'image': 'assets/icons/surgeon.png'},
    {'type': 'Skin care & hair', 'image': 'assets/icons/skincarehair.png'},
    {'type': 'Urologist & Kidney', 'image': 'assets/icons/kidney.png'},
  ];

  var newAppoint = BookType.newApp;
  var docData;
  var selectedAppType;
  FirebaseFirestore db = FirebaseFirestore.instance;
  String searchValue = "";
  final recentList = [
    {'title': 'Cough & Fever'},
    {'title': 'Nutrition'}
  ];

  Stream<List<DrModel>> getSearch() {
    final stream = db
        .collection("doctor")
        .where("searchKey", isGreaterThanOrEqualTo: [searchValue]).snapshots();
    return stream.map((event) => event.docs.map((doc) {
          return DrModel.fromDocument(doc.data());
        }).toList());
  }

  /// run you code okk wait just add stream fxn in code
  final trendingList = [
    {'title': 'Homoeopath'},
    {'title': 'Gynecologist'},
    {'title': 'Pediatrician'},
    {'title': 'Physiotherapist'},
    {'title': 'Nutritionist'},
    {'title': 'Spine and Pain Specialist'},
    {'title': 'Dentist'},
    {'title': 'Cough & Fever'},
    {'title': 'Physiotherapist'},
    {'title': 'Nutritionist'},
    {'title': 'Spine and Pain Specialist'},
    {'title': 'Dentist'},
    {'title': 'Cough & Fever'}
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        title: Container(
          height: 40.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TextField(
            onChanged: (val) {
              setState(() {
                searchValue = val;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search for doctors',
              hintStyle: TextStyle(
                fontSize: 15.0,
                color: Colors.grey,
              ),
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: getSearch(),
        // (searchValue != "" && searchValue != null)
        //     ?
        // db
        //     .collection("doctor")
        //     .where("searchKey", arrayContains: searchValue)
        //     .snapshots(),
        // : db.collection("doctor").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<List<DrModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("Search any thing...."),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading...."),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              // setState(() {
              // snapshot.data.docs.forEach((element) {
              //   docData = element.data();
              // });
              // drObj = DrModel.fromDocument(docData);
              // drList.add(drObj);
              // });

              //final item = doctorList[index];
              //final snap = snapshot.data.docs[index];
              final snap = snapshot.data[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ElevatedButton(
                  //   onPressed: () {
                  //     print("===============${drObj.drName}");
                  //   },
                  //   child: Text(drList[index].drName),
                  // ),
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(50.0),
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
                                  image: NetworkImage(
                                      snapshot.data[index].drImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            widthSpace,
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dr. ${snap.drName}',
                                    // 'Dr. ${data['drName']}',
                                    style: blackNormalBoldTextStyle,
                                  ),
                                  SizedBox(height: 7.0),
                                  // Text(
                                  //   doctorList,
                                  //   style: greyNormalTextStyle,
                                  // ),
                                  SizedBox(height: 7.0),
                                  Text(
                                    '${snap.experience} Years Experience',
                                    // '${data["experience"]} Years Experience',
                                    style: primaryColorNormalTextStyle,
                                  ),
                                  SizedBox(height: 7.0),
                                  Text(
                                    snap.drAddress,
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(height: 7.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.lime, size: 20.0),
                                      SizedBox(width: 5.0),
                                      Text(
                                        snap.rating,
                                        style: blackNormalTextStyle,
                                      ),
                                      widthSpace,
                                      widthSpace,
                                      Icon(Icons.rate_review,
                                          color: Colors.grey, size: 20.0),
                                      SizedBox(width: 5.0),
                                      Text(
                                        ' Reviews',
                                        style: blackNormalTextStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              child: IconButton(
                                  icon: Icon(Icons.directions),
                                  onPressed: () {
                                    // MapsLauncher.launchCoordinates(
                                    //   pos.latitude,
                                    //   pos.longitude,
                                    // );
                                  }),
                            )
                          ],
                        ),
                        heightSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              // enableFeedback: true,
                              onTap: () {
                                //setState(() {
                                selectedAppType = newAppoint.index;
                                //});
                                print(selectedAppType);
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    duration: Duration(milliseconds: 600),
                                    type: PageTransitionType.fade,
                                    child: DoctorTimeSlot(
                                      price: snap.price,
                                      pricePayment: snap.pricePayment,
                                      drUid: snap.drUid,
                                      doctorImage: snap.drImage,
                                      doctorName: snap.drName,
                                      // doctorType: widget.doctorList,
                                      experience: snap.experience,
                                      drObj: snapshot.data[index],
                                      //pos: pos,
                                      selectedAppType: selectedAppType,
                                      // typeOfDoctor: widget.typeOfDoctor,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: (width - fixPadding * 6 + 1.4) / 2.0,
                                padding: EdgeInsets.all(fixPadding),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.07),
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      width: 0.7, color: Colors.orange),
                                ),
                                child: Text(
                                  'Book old appoitment',
                                  style: orangeButtonBoldTextStyle,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedAppType = BookType.oldApp.index;
                                });
                                print(selectedAppType);
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    duration: Duration(milliseconds: 600),
                                    type: PageTransitionType.fade,
                                    child: DoctorTimeSlot(
                                      price: snap.price,
                                      pricePayment: snap.pricePayment,
                                      drUid: snap.drUid,
                                      doctorImage: snap.drImage,
                                      doctorName: snap.drName,
                                      // doctorType: widget.doctorList,
                                      experience: snap.experience,
                                      drObj: snapshot.data[index],
                                      // pos: pos,
                                      selectedAppType: selectedAppType,
                                      // typeOfDoctor: widget.typeOfDoctor,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: (width - fixPadding * 6 + 1.4) / 2.0,
                                padding: EdgeInsets.all(fixPadding),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.07),
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      width: 0.7, color: primaryColor),
                                ),
                                child: Text(
                                  'Book New Appointment',
                                  style: primaryColorsmallBoldTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  divider(),
                ],
              );
            },
          );
        },

        // builder: (BuildContext context, AsyncSnapshot<DrModel> snapshot) {
        //   final data = snapshot.data.docs;

        //   if (snapshot.data.docs.isEmpty) {
        //     return Container();
        //   }
        //   if (snapshot.connectionState == ConnectionState.waiting) {
        //     return Center(
        //       child: Text("Loading..."),
        //     );
        //   }

        //   return ListView.builder(itemBuilder: (context, index) {
        //     return Container(
        //       child: ListView.builder(
        //         itemCount: data.length,
        //         itemBuilder: (context, index) {
        //           //final item = doctorList[index];
        //           GeoPoint pos = data[index]['geoCo'];
        //           final item = doctorTypeList[index];

        //           //print("data=====hh==========${pos}");
        //           LatLng latLng = new LatLng(pos.latitude, pos.longitude);
        //           return Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               Container(
        //                 padding: EdgeInsets.all(fixPadding * 2.0),
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Row(
        //                       mainAxisAlignment: MainAxisAlignment.start,
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Container(
        //                           width: 100.0,
        //                           height: 100.0,
        //                           decoration: BoxDecoration(
        //                             color: whiteColor,
        //                             borderRadius: BorderRadius.circular(50.0),
        //                             border: Border.all(
        //                                 width: 0.3, color: primaryColor),
        //                             boxShadow: <BoxShadow>[
        //                               BoxShadow(
        //                                 blurRadius: 1.0,
        //                                 spreadRadius: 1.0,
        //                                 color: Colors.grey[300],
        //                               ),
        //                             ],
        //                             image: DecorationImage(
        //                               image:
        //                                   NetworkImage(data[index]["drImage"]),
        //                               fit: BoxFit.cover,
        //                             ),
        //                           ),
        //                         ),
        //                         widthSpace,
        //                         Expanded(
        //                           child: Column(
        //                             mainAxisAlignment: MainAxisAlignment.start,
        //                             crossAxisAlignment:
        //                                 CrossAxisAlignment.start,
        //                             children: [
        //                               Text(
        //                                 'Dr. ${data[index]["drName"]}',
        //                                 style: blackNormalBoldTextStyle,
        //                               ),
        //                               SizedBox(height: 7.0),
        //                               Text(
        //                                 data[index]['type'],
        //                                 style: greyNormalTextStyle,
        //                               ),
        //                               SizedBox(height: 7.0),
        //                               Text(
        //                                 '${data[index]["experience"]} Years Experience',
        //                                 style: primaryColorNormalTextStyle,
        //                               ),
        //                               SizedBox(height: 7.0),
        //                               Text(
        //                                 data[index]["drAddress"],
        //                                 style: TextStyle(
        //                                   color: Colors.red,
        //                                 ),
        //                               ),
        //                               SizedBox(height: 7.0),
        //                               Row(
        //                                 mainAxisAlignment:
        //                                     MainAxisAlignment.start,
        //                                 crossAxisAlignment:
        //                                     CrossAxisAlignment.center,
        //                                 children: [
        //                                   Icon(Icons.star,
        //                                       color: Colors.lime, size: 20.0),
        //                                   SizedBox(width: 5.0),
        //                                   Text(
        //                                     data[index]["rating"],
        //                                     style: blackNormalTextStyle,
        //                                   ),
        //                                   widthSpace,
        //                                   widthSpace,
        //                                   Icon(Icons.rate_review,
        //                                       color: Colors.grey, size: 20.0),
        //                                   SizedBox(width: 5.0),
        //                                   Text(
        //                                     ' Reviews',
        //                                     style: blackNormalTextStyle,
        //                                   ),
        //                                 ],
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                         CircleAvatar(
        //                           child: IconButton(
        //                               icon: Icon(Icons.directions),
        //                               onPressed: () {
        //                                 MapsLauncher.launchCoordinates(
        //                                   pos.latitude,
        //                                   pos.longitude,
        //                                 );
        //                               }),
        //                         )
        //                       ],
        //                     ),
        //                     heightSpace,
        //                     Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       children: [
        //                         InkWell(
        //                           // enableFeedback: true,
        //                           onTap: () {
        //                             //setState(() {
        //                             selectedAppType = newAppoint.index;
        //                             //});
        //                             DrModel drObj ;
        //                             List<DrModel> drList=[];
        //                             drList.add(data);
        //                             print(selectedAppType);
        //                             Navigator.push(
        //                               context,
        //                               PageTransition(
        //                                 duration: Duration(milliseconds: 600),
        //                                 type: PageTransitionType.fade,
        //                                 child: DoctorTimeSlot(
        //                                   drUid: data[index]["drUid"],
        //                                   doctorImage: data[index]["drImage"],
        //                                   doctorName: data[index]["drName"],
        //                                   //doctorType: widget.doctorList,
        //                                   experience: data[index]["experience"],
        //                                   drObj: ,
        //                                   pos: latLng,
        //                                   selectedAppType: selectedAppType,
        //                                   //typeOfDoctor: widget.typeOfDoctor,
        //                                 ),
        //                               ),
        //                             );
        //                           },
        //                           child: Container(
        //                             width: (width - fixPadding * 6 + 1.4) / 2.0,
        //                             padding: EdgeInsets.all(fixPadding),
        //                             alignment: Alignment.center,
        //                             decoration: BoxDecoration(
        //                               color: Colors.orange.withOpacity(0.07),
        //                               borderRadius: BorderRadius.circular(8.0),
        //                               border: Border.all(
        //                                   width: 0.7, color: Colors.orange),
        //                             ),
        //                             child: Text(
        //                               'Book old appoitment',
        //                               style: orangeButtonBoldTextStyle,
        //                             ),
        //                           ),
        //                         ),
        //                         InkWell(
        //                           onTap: () {
        //                             setState(() {
        //                               selectedAppType = BookType.oldApp.index;
        //                             });
        //                             print(selectedAppType);
        //                             Navigator.push(
        //                               context,
        //                               PageTransition(
        //                                 duration: Duration(milliseconds: 600),
        //                                 type: PageTransitionType.fade,
        //                                 child: DoctorTimeSlot(
        //                                   drUid: data[index]["drUid"],
        //                                   doctorImage: data[index]["drImage"],
        //                                   doctorName: data[index]["drName"],
        //                                   // doctorType: widget.doctorList,
        //                                   experience:
        //                                       data[index]["experience"],
        //                                   drObj: drModelList[index],
        //                                   pos: latLng,
        //                                   selectedAppType: selectedAppType,
        //                                   typeOfDoctor: widget.typeOfDoctor,
        //                                 ),
        //                               ),
        //                             );
        //                           },
        //                           child: Container(
        //                             width: (width - fixPadding * 6 + 1.4) / 2.0,
        //                             padding: EdgeInsets.all(fixPadding),
        //                             alignment: Alignment.center,
        //                             decoration: BoxDecoration(
        //                               color: primaryColor.withOpacity(0.07),
        //                               borderRadius: BorderRadius.circular(8.0),
        //                               border: Border.all(
        //                                   width: 0.7, color: primaryColor),
        //                             ),
        //                             child: Text(
        //                               'Book New Appointment',
        //                               style: primaryColorsmallBoldTextStyle,
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           );
        //         },
        //       ),
        //     );
        //   });
        // },
      ),
    );
  }

  divider() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      height: 0.8,
      color: greyColor.withOpacity(0.3),
    );
  }
}
