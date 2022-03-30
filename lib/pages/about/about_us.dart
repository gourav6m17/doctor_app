import 'package:flutter/material.dart';
import 'package:my_doctor_app/constant/constant.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        titleSpacing: 0.0,
        elevation: 1.0,
        title: Text(
          'About Us',
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
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: fixPadding * 2.0,
              right: fixPadding * 2.0,
              left: fixPadding * 2.0,
            ),
            child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              style: blackNormalTextStyle,
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: fixPadding * 2.0,
              right: fixPadding * 2.0,
              left: fixPadding * 2.0,
            ),
            child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              style: blackNormalTextStyle,
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: fixPadding * 2.0,
              right: fixPadding * 2.0,
              left: fixPadding * 2.0,
            ),
            child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              style: blackNormalTextStyle,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
