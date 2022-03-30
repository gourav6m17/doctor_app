import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:my_doctor_app/constant/constant.dart';
import 'package:my_doctor_app/models/drModel.dart';
import 'package:my_doctor_app/pages/doctor/doctor_time_slot.dart';
import 'package:page_transition/page_transition.dart';

enum BookType { oldApp, newApp }

class DoctorList extends StatefulWidget {
  DrModel drObj;
  var doctorList;
  List<DrModel> drList = [];
  var selectedCity, typeOfDoctor;
  //DoctorList({this.drObj});

  DoctorList(
      {this.drObj, this.doctorList, this.selectedCity, this.typeOfDoctor});

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  var selectedAppType;
  var newAppoint = BookType.newApp;
  LatLng pos;

  FirebaseFirestore dbs = FirebaseFirestore.instance;
  //var DataType;
  var dataType;
  Map<String, dynamic> data = Map<String, dynamic>();
  List<DrModel> drModelList = [];
  DrModel drObj;

  @override
  void initState() {
    dbs
        .collection("doctors")
        .where('city', isEqualTo: widget.selectedCity)
        .where('doctorTypeList', arrayContains: {'type': widget.doctorList})
        .get()
        .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((element) {
            setState(() {
              data = element.data();
              drObj = new DrModel.fromJson(data);
              drModelList.add(drObj);
              GeoPoint geo = data['geoCo'];
              pos = LatLng(geo.latitude, geo.longitude);

              print("data===============$data");
            });
          });
        });

    print("===============${widget.doctorList}");

    //data.drModelList = data.values.toList();
    super.initState();
  }

  // final doctorList = [
  //   {
  //     'name': 'Ronan Peiterson',
  //     'image': 'assets/doctor/doctor-1.png',
  //     'exp': '8',
  //     'rating': '4.9',
  //     'review': '135'
  //   },
  //   {
  //     'name': 'Brayden Trump',
  //     'image': 'assets/doctor/doctor-2.png',
  //     'exp': '10',
  //     'rating': '4.7',
  //     'review': '235'
  //   },
  //   {
  //     'name': 'Apollonia Ellison',
  //     'image': 'assets/doctor/doctor-3.png',
  //     'exp': '7',
  //     'rating': '4.8',
  //     'review': '70'
  //   },
  //   {
  //     'name': 'Beatriz Watson',
  //     'image': 'assets/doctor/doctor-4.png',
  //     'exp': '5',
  //     'rating': '5.0',
  //     'review': '50'
  //   },
  //   {
  //     'name': 'Diego Williams',
  //     'image': 'assets/doctor/doctor-5.png',
  //     'exp': '15',
  //     'rating': '4.9',
  //     'review': '512'
  //   },
  //   {
  //     'name': 'Shira Gates',
  //     'image': 'assets/doctor/doctor-6.png',
  //     'exp': '4',
  //     'rating': '4.4',
  //     'review': '15'
  //   },
  //   {
  //     'name': 'Antonio Warner',
  //     'image': 'assets/doctor/doctor-7.png',
  //     'exp': '7',
  //     'rating': '4.6',
  //     'review': '99'
  //   },
  //   {
  //     'name': 'Linnea Bezos',
  //     'image': 'assets/doctor/doctor-8.png',
  //     'exp': '2',
  //     'rating': '4.5',
  //     'review': '9'
  //   }
  // ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        titleSpacing: 0.0,
        elevation: 0.0,
        title: Text(
          widget.doctorList,
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
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(65.0),
        //   child: Container(
        //     color: whiteColor,
        //     height: 65.0,
        //     padding: EdgeInsets.only(
        //       left: fixPadding * 2.0,
        //       right: fixPadding * 2.0,
        //       top: fixPadding,
        //       bottom: fixPadding,
        //     ),
        //     alignment: Alignment.center,
        //     child: Container(
        //       height: 55.0,
        //       padding: EdgeInsets.all(fixPadding),
        //       alignment: Alignment.center,
        //       decoration: BoxDecoration(
        //         color: whiteColor,
        //         borderRadius: BorderRadius.circular(8.0),
        //         border:
        //             Border.all(width: 1.0, color: greyColor.withOpacity(0.6)),
        //       ),
        //       child: TextField(
        //         decoration: InputDecoration(
        //           hintText: 'Search ${widget.doctorList}',
        //           hintStyle: greyNormalTextStyle,
        //           prefixIcon: Icon(Icons.search),
        //           border: InputBorder.none,
        //           contentPadding: EdgeInsets.only(
        //               top: fixPadding * 0.78, bottom: fixPadding * 0.78),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
      body: drModelList.isNotEmpty
          ? Container(
              child: ListView.builder(
                itemCount: drModelList.length,
                itemBuilder: (context, index) {
                  //final item = doctorList[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                    border: Border.all(
                                        width: 0.3, color: primaryColor),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0,
                                        color: Colors.grey[300],
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          drModelList[index].drImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                widthSpace,
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dr. ${drModelList[index].drName}',
                                        style: blackNormalBoldTextStyle,
                                      ),
                                      SizedBox(height: 7.0),
                                      Text(
                                        widget.doctorList,
                                        style: greyNormalTextStyle,
                                      ),
                                      SizedBox(height: 7.0),
                                      Text(
                                        '${drModelList[index].experience} Years Experience',
                                        style: primaryColorNormalTextStyle,
                                      ),
                                      SizedBox(height: 7.0),
                                      Text(
                                        drModelList[index].drAddress,
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(height: 7.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.star,
                                              color: Colors.lime, size: 20.0),
                                          SizedBox(width: 5.0),
                                          Text(
                                            drModelList[index].rating,
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
                                        MapsLauncher.launchCoordinates(
                                          pos.latitude,
                                          pos.longitude,
                                        );
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
                                          doctorImage:
                                              drModelList[index].drImage,
                                          doctorName: drModelList[index].drName,
                                          doctorType: widget.doctorList,
                                          experience:
                                              drModelList[index].experience,
                                          drObj: drModelList[index],
                                          pos: pos,
                                          selectedAppType: selectedAppType,
                                          typeOfDoctor: widget.typeOfDoctor,
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
                                          doctorImage:
                                              drModelList[index].drImage,
                                          doctorName: drModelList[index].drName,
                                          doctorType: widget.doctorList,
                                          experience:
                                              drModelList[index].experience,
                                          drObj: drModelList[index],
                                          pos: pos,
                                          selectedAppType: selectedAppType,
                                          typeOfDoctor: widget.typeOfDoctor,
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
              ),
            )
          : Container(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Text(
                      "Opps! Here is no Doctor.",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Image(
                      image: AssetImage("assets/empty_img.png"),
                    ),
                  ],
                ),
              ),
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
