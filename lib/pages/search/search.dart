import 'package:my_doctor_app/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:my_doctor_app/widget/column_builder.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final recentList = [
    {'title': 'Cough & Fever'},
    {'title': 'Nutrition'}
  ];

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
            decoration: InputDecoration(
              hintText: 'Search for doctors & labs',
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
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: fixPadding,
                    bottom: fixPadding,
                    right: fixPadding * 2.0,
                    left: fixPadding * 2.0),
                color: Colors.grey[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Your recent searches',
                      style: blackNormalBoldTextStyle,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Show more',
                        style: primaryColorsmallTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              ColumnBuilder(
                itemCount: recentList.length,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                itemBuilder: (context, index) {
                  final item = recentList[index];
                  return Container(
                    width: width,
                    color: whiteColor,
                    padding: (index == 0)
                        ? EdgeInsets.all(fixPadding * 2.0)
                        : EdgeInsets.only(
                            right: fixPadding * 2.0,
                            left: fixPadding * 2.0,
                            bottom: fixPadding * 2.0,
                          ),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.history, color: greyColor, size: 22.0),
                          widthSpace,
                          Text(
                            item['title'],
                            style: blackSmallTextStyle,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Container(
                width: width,
                padding: EdgeInsets.only(
                    top: fixPadding,
                    bottom: fixPadding,
                    right: fixPadding * 2.0,
                    left: fixPadding * 2.0),
                color: Colors.grey[100],
                child: Text(
                  'Trending around you',
                  style: blackNormalBoldTextStyle,
                ),
              ),
              ColumnBuilder(
                itemCount: trendingList.length,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                itemBuilder: (context, index) {
                  final item = trendingList[index];
                  return Container(
                    width: width,
                    color: whiteColor,
                    padding: (index == 0)
                        ? EdgeInsets.all(fixPadding * 2.0)
                        : EdgeInsets.only(
                            right: fixPadding * 2.0,
                            left: fixPadding * 2.0,
                            bottom: fixPadding * 2.0,
                          ),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.trending_up,
                              color: Colors.blue, size: 22.0),
                          widthSpace,
                          Text(
                            item['title'],
                            style: blackSmallTextStyle,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
