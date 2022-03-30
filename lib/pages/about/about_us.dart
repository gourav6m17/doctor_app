import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_doctor_client/constant/constant.dart';

class AboutUs extends StatelessWidget {
  _instagramLaunch() async {
    var instaUrl = 'https://www.instagram.com/my_groobe/';

    if (await canLaunch(instaUrl)) {
      await launch(
        instaUrl,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $instaUrl';
    }
  }

  _fbLaunch() async {
    var instaUrl = ' https://www.facebook.com/DoctorClientOfficial/';

    if (await canLaunch(instaUrl)) {
      await launch(
        instaUrl,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $instaUrl';
    }
  }

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
              "Doctor client is a 24/7 online platform where patient can consult and get appointment of different well known doctors online,test with free home sample collection. An all in one app." +
                  "Doctor client - online doctor appointment and consultation app, offers appointment of different well known doctors just sitting at their home , it also provide free telemedicine solution for you and your family" +
                  "With Doctor client you can:" +
                  "🔸 Find and book appointment with a well-known doctor near you." +
                  "🔸 Book diagnostic test and get your report online." +
                  "Patient are struggling to find a best doctor for their treatment, but through Doctor client India's trusted online doctor appointment app, patient gets appointment of different doctor anytime, anywhere, patient can book a doctor online across 25 + specialist. Common symptoms across some of the top specialist includes:" +
                  "Download this doctor appointment app right away & get well known doctors consultation" +
                  "We’d love to hear from you. Drop us a line at" +
                  "developer.doctorclient@gmail.com",
              style: blackNormalTextStyle,
              textAlign: TextAlign.justify,
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _fbLaunch();
                },
                child: Image.asset("assets/Logo/facebook_logo.png"),
              ),
              // GestureDetector(
              //   onTap: () {
              //     _instagramLaunch();
              //   },
              //   child: Image.asset("assets/Logo/instagram_logo.png"),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
