import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_doctor_client/constant/constant.dart';
import 'package:user_doctor_client/models/appointmentModel.dart';
import 'package:user_doctor_client/pages/appointment/AppointmentDetail.dart';

class Appointment extends StatefulWidget {
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  var docIdOfSelected;
  FirebaseFirestore db = FirebaseFirestore.instance;
  Map<String, dynamic> data = Map<String, dynamic>();
  List<AppointmentModel> appModelList = [];
  AppointmentModel appModel;
  var uid = FirebaseAuth.instance.currentUser.uid;
  var docId;

  @override
  void initState() {
    super.initState();
  }

  deleteAppointmentDialog(index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
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
                      "Are you sure you want to cancel this appointment?",
                      style: blackNormalTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'No',
                              style: primaryColorButtonTextStyle,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              db
                                  .collection("appointments")
                                  .doc(docIdOfSelected)
                                  .update({"status": "cancelled"});
                              // db
                              //     .collection("appointments")
                              //     .doc()
                              //     .get()
                              //     .then((DocumentSnapshot documentSnapshot) {
                              //   docId = documentSnapshot.id;
                              //   print("============$docId");
                              //   db
                              //       .collection("appointments")
                              //       .doc(docIdOfSelected)
                              //       .update({"status": "cancelled"});
                              // });
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'Yes',
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1.0,
          automaticallyImplyLeading: false,
          title: Text(
            'Appointments',
            style: appBarTitleTextStyle,
          ),
          // bottom: TabBar(
          //   tabs: [
          //     Tab(
          //       child: tabItem('Active', activeAppoinmentList.length),
          //     ),
          //     Tab(
          //       child: tabItem('Past', pastAppoinmentList.length),
          //     ),
          //     Tab(
          //       child: tabItem('Cancelled', cancelledAppoinmentList.length),
          //     ),
          //   ],
          // ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("appointments")
              .where("userUid", isEqualTo: uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error));
            }
            // if (snapshot.hasData) {
            //   var document = snapshot.data;
            //   return ListView.builder(
            //     itemCount: document.length,
            //     itemBuilder: (context, index) {
            //       return Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Container(
            //             padding: EdgeInsets.all(fixPadding * 2.0),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Container(
            //                   width: 80.0,
            //                   height: 80.0,
            //                   alignment: Alignment.center,
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(40.0),
            //                     border: (appModelList[index].status ==
            //                             "confirmed")
            //                         ? Border.all(
            //                             width: 1.0, color: Colors.green)
            //                         : Border.all(width: 1.0, color: Colors.red),
            //                     color:
            //                         (appModelList[index].status == "confirmed")
            //                             ? Colors.green[50]
            //                             : Colors.red[50],
            //                   ),
            //                   child: Text(
            //                     appModelList[index].date,
            //                     textAlign: TextAlign.center,
            //                     style:
            //                         (appModelList[index].status == "confirmed")
            //                             ? greenColorNormalTextStyle
            //                             : redColorNormalTextStyle,
            //                   ),
            //                 ),
            //                 widthSpace,
            //                 Expanded(
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.start,
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         crossAxisAlignment: CrossAxisAlignment.end,
            //                         children: [
            //                           Text(
            //                             appModelList[index].time,
            //                             style: blackHeadingTextStyle,
            //                           ),
            //                           InkWell(
            //                             onTap: () =>
            //                                 deleteAppointmentDialog(index),
            //                             child: Icon(
            //                               Icons.close,
            //                               size: 18.0,
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                       SizedBox(height: 7.0),
            //                       Text(
            //                         'Dr. ${appModelList[index].drName}',
            //                         style: blackNormalTextStyle,
            //                         overflow: TextOverflow.ellipsis,
            //                       ),
            //                       SizedBox(height: 7.0),
            //                       Text(
            //                         '${appModelList[index].typeofDoctor}',
            //                         style: primaryColorsmallTextStyle,
            //                         overflow: TextOverflow.ellipsis,
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           divider(),
            //         ],
            //       );
            //     },
            //   );

            // }
            if (snapshot.connectionState != ConnectionState.active) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var document = snapshot.data.docs;
            return ListView.builder(
              itemCount: document.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AppointmentDetail(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(fixPadding * 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 80.0,
                              height: 80.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                border: (document[index]['status'] ==
                                        "confirmed")
                                    ? Border.all(
                                        width: 1.0, color: Colors.green)
                                    : Border.all(width: 1.0, color: Colors.red),
                                color:
                                    (document[index]['status'] == "confirmed")
                                        ? Colors.green[50]
                                        : Colors.red[50],
                              ),
                              child: Text(
                                document[index]['date'],
                                textAlign: TextAlign.center,
                                style:
                                    (document[index]['status'] == "confirmed")
                                        ? greenColorNormalTextStyle
                                        : redColorNormalTextStyle,
                              ),
                            ),
                            widthSpace,
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        document[index]['time'],
                                        style: blackHeadingTextStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 7.0),
                                  Text(
                                    'Dr. ${document[index]['drName']}',
                                    style: blackNormalTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 7.0),
                                  Text(
                                    '${document[index]['typeofDoctor']}',
                                    style: primaryColorsmallTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                heightSpace,
                                heightSpace,
                                (document[index]['status'] == "confirmed")
                                    ? Container(
                                        child: Image.asset(
                                          "assets/icons/checked.png",
                                          height: 35,
                                        ),
                                      )
                                    : Container(
                                        child: Image.asset(
                                          "assets/icons/delete.png",
                                          height: 35,
                                        ),
                                      ),
                              ],
                            ),
                            widthSpace,
                            widthSpace,
                            (document[index]['status'] == "confirmed")
                                ? Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          docIdOfSelected = document[index].id;
                                          print(docIdOfSelected);
                                          deleteAppointmentDialog(index);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          size: 18.0,
                                        ),
                                      ),
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      divider(),
                    ],
                  ),
                );
              },
            );
          },
        ),
        // TabBarView(
        //   children: [
        //     activeAppointment(),
        //     pastAppointment(),
        //     cancelledAppointment(),
        //   ],
        // ),
      ),
    );
  }

  tabItem(text, number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: blackSmallTextStyle,
        ),
        SizedBox(width: 4.0),
        Container(
          width: 20.0,
          height: 20.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: primaryColor,
          ),
          child: Text(
            '$number',
            style: TextStyle(
              color: whiteColor,
              fontSize: 10.0,
            ),
          ),
        ),
      ],
    );
  }

  activeAppointment() {
    return (appModelList.length == 0)
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.date_range,
                  color: greyColor,
                  size: 70.0,
                ),
                heightSpace,
                Text(
                  'No Appointments book a new one!',
                  style: greyNormalTextStyle,
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: appModelList.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80.0,
                          height: 80.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            border: (appModelList[index].status == "confirmed")
                                ? Border.all(width: 1.0, color: Colors.green)
                                : Border.all(width: 1.0, color: Colors.red),
                            color: (appModelList[index].status == "confirmed")
                                ? Colors.green[50]
                                : Colors.red[50],
                          ),
                          child: Text(
                            appModelList[index].date,
                            textAlign: TextAlign.center,
                            style: (appModelList[index].status == "confirmed")
                                ? greenColorNormalTextStyle
                                : redColorNormalTextStyle,
                          ),
                        ),
                        widthSpace,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    appModelList[index].time,
                                    style: blackHeadingTextStyle,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      deleteAppointmentDialog(index);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                'Dr. ${appModelList[index].drName}',
                                style: blackNormalTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                '${appModelList[index].typeofDoctor}',
                                style: primaryColorsmallTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider(),
                ],
              );
            },
          );
  }

  // pastAppointment() {
  //   return (pastAppoinmentList.length == 0)
  //       ? Center(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Icon(
  //                 Icons.date_range,
  //                 color: greyColor,
  //                 size: 70.0,
  //               ),
  //               heightSpace,
  //               Text(
  //                 'No Past Appointments',
  //                 style: greyNormalTextStyle,
  //               ),
  //             ],
  //           ),
  //         )
  //       : ListView.builder(
  //           itemCount: pastAppoinmentList.length,
  //           itemBuilder: (context, index) {
  //             final item = pastAppoinmentList[index];
  //             return Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Container(
  //                   padding: EdgeInsets.all(fixPadding * 2.0),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                         width: 80.0,
  //                         height: 80.0,
  //                         alignment: Alignment.center,
  //                         padding: EdgeInsets.all(3.0),
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(40.0),
  //                           border: Border.all(width: 1.0, color: primaryColor),
  //                           color: primaryColor.withOpacity(0.15),
  //                         ),
  //                         child: Text(
  //                           item['date'],
  //                           textAlign: TextAlign.center,
  //                           style: primaryColorNormalTextStyle,
  //                         ),
  //                       ),
  //                       widthSpace,
  //                       Expanded(
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               item['time'],
  //                               style: blackHeadingTextStyle,
  //                             ),
  //                             SizedBox(height: 7.0),
  //                             Text(
  //                               'Dr. ${item['doctorName']}',
  //                               style: blackNormalTextStyle,
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                             SizedBox(height: 7.0),
  //                             Text(
  //                               '${item['doctorType']}',
  //                               style: primaryColorsmallTextStyle,
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 divider(),
  //               ],
  //             );
  //           },
  //         );
  // }

  // cancelledAppointment() {
  //   return (cancelledAppoinmentList.length == 0)
  //       ? Center(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Icon(
  //                 Icons.date_range,
  //                 color: greyColor,
  //                 size: 70.0,
  //               ),
  //               heightSpace,
  //               Text(
  //                 'No Cancelled Appointments',
  //                 style: greyNormalTextStyle,
  //               ),
  //             ],
  //           ),
  //         )
  //       : ListView.builder(
  //           itemCount: cancelledAppoinmentList.length,
  //           itemBuilder: (context, index) {
  //             final item = cancelledAppoinmentList[index];
  //             return Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Container(
  //                   padding: EdgeInsets.all(fixPadding * 2.0),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                         width: 80.0,
  //                         height: 80.0,
  //                         alignment: Alignment.center,
  //                         padding: EdgeInsets.all(3.0),
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(40.0),
  //                           border: Border.all(width: 1.0, color: Colors.red),
  //                           color: Colors.red[50],
  //                         ),
  //                         child: Text(
  //                           item['date'],
  //                           textAlign: TextAlign.center,
  //                           style: redColorNormalTextStyle,
  //                         ),
  //                       ),
  //                       widthSpace,
  //                       Expanded(
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               item['time'],
  //                               style: blackHeadingTextStyle,
  //                             ),
  //                             SizedBox(height: 7.0),
  //                             Text(
  //                               'Dr. ${item['doctorName']}',
  //                               style: blackNormalTextStyle,
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                             SizedBox(height: 7.0),
  //                             Text(
  //                               '${item['doctorType']}',
  //                               style: primaryColorsmallTextStyle,
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 divider(),
  //               ],
  //             );
  //           },
  //         );
  // }

  divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      width: MediaQuery.of(context).size.width - fixPadding * 4.0,
      height: 1.0,
      color: Colors.grey[200],
    );
  }
}
