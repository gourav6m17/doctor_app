
import 'package:flutter/material.dart';
import 'package:my_doctor_app/constant/constant.dart';
import 'package:my_doctor_app/widget/column_builder.dart';

class PatientDirectory extends StatefulWidget {
  @override
  _PatientDirectoryState createState() => _PatientDirectoryState();
}

class _PatientDirectoryState extends State<PatientDirectory> {
  final patientList = [
    {'name': 'Allison Perry', 'image': 'assets/user/user_3.jpg'},
    {'name': 'John Smith', 'image': ''}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        titleSpacing: 0.0,
        elevation: 1.0,
        title: Text(
          'Patient Directory',
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: ColumnBuilder(
              itemCount: patientList.length,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              itemBuilder: (context, index) {
                final item = patientList[index];
                return Container(
                  margin: (index == 0)
                      ? EdgeInsets.only(top: 0.0)
                      : EdgeInsets.only(top: fixPadding * 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (item['image'] != '')
                          ? Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(35.0),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    blurRadius: 1.0,
                                    spreadRadius: 1.0,
                                    color: Colors.grey[300],
                                  ),
                                ],
                                image: DecorationImage(
                                    image: AssetImage(item['image']),
                                    fit: BoxFit.cover),
                              ),
                            )
                          : Container(
                              width: 70.0,
                              height: 70.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(35.0),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    blurRadius: 1.0,
                                    spreadRadius: 1.0,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.person,
                                size: 30.0,
                                color: greyColor,
                              ),
                            ),
                      widthSpace,
                      widthSpace,
                      Expanded(
                        child: Text(
                          item['name'],
                          style: blackNormalBoldTextStyle,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
