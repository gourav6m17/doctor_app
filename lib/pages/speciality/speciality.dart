import 'package:flutter/material.dart';
import 'package:my_doctor_app/constant/constant.dart';
import 'package:my_doctor_app/models/drModel.dart';
import 'package:my_doctor_app/pages/screens.dart';
import 'package:page_transition/page_transition.dart';

class Speciality extends StatefulWidget {
  var selectedCity;
  Speciality({this.selectedCity});

  @override
  _SpecialityState createState() => _SpecialityState();
}

class _SpecialityState extends State<Speciality> {
  DrModel drModelList;
  var selectedType;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(fixPadding),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: doctorTypeList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          final item = doctorTypeList[index];
          return Padding(
            padding: EdgeInsets.all(fixPadding),
            child: InkWell(
              onTap: () async {
                //setState(() {
                selectedType = item["type"];
                print(selectedType);
                //  });
                await Future.delayed(const Duration(milliseconds: 200));

                Navigator.push(
                  context,
                  PageTransition(
                    duration: Duration(milliseconds: 500),
                    type: PageTransitionType.fade,
                    child: DoctorList(
                      doctorList: selectedType,
                      selectedCity: widget.selectedCity,
                      typeOfDoctor: selectedType,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        blurRadius: 1.0,
                        spreadRadius: 1.5,
                        color: Colors.grey[300]),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      item['image'],
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      item['type'],
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    // ListView(
    //   backgroundColor: scaffoldBgColor,
    //   appBar: AppBar(
    //     backgroundColor: whiteColor,
    //     titleSpacing: 0.0,
    //     elevation: 0.0,
    //     title: Text(
    //       'Speciality',
    //       style: appBarTitleTextStyle,
    //     ),
    //     leading: IconButton(
    //       icon: Icon(
    //         Icons.arrow_back,
    //         color: blackColor,
    //       ),
    //       onPressed: () {
    //         Navigator.pop(context);
    //       },
    //     ),
    //     bottom: PreferredSize(
    //       preferredSize: Size.fromHeight(65.0),
    //       child: Container(
    //         color: whiteColor,
    //         height: 65.0,
    //         padding: EdgeInsets.only(
    //           left: fixPadding * 2.0,
    //           right: fixPadding * 2.0,
    //           top: fixPadding,
    //           bottom: fixPadding,
    //         ),
    //         alignment: Alignment.center,
    //         child: Container(
    //           height: 55.0,
    //           padding: EdgeInsets.all(fixPadding),
    //           alignment: Alignment.center,
    //           decoration: BoxDecoration(
    //             color: whiteColor,
    //             borderRadius: BorderRadius.circular(8.0),
    //             border:
    //                 Border.all(width: 1.0, color: greyColor.withOpacity(0.6)),
    //           ),
    //           child: TextField(
    //             decoration: InputDecoration(
    //               hintText: 'Search specialities',
    //               hintStyle: greyNormalTextStyle,
    //               prefixIcon: Icon(Icons.search),
    //               border: InputBorder.none,
    //               contentPadding: EdgeInsets.only(
    //                   top: fixPadding * 0.78, bottom: fixPadding * 0.78),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),

    //   body:

    // );
  }
}
