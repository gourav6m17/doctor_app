import 'package:my_doctor_app/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final notificationList = [
    {
      'type': 'booking',
      'title': 'Booking Success',
      'desc': 'Your have successfully booked appointment. OrderId: OID1256789.'
    },
    {
      'type': 'offer',
      'title': '25% Off use code DoctorPro25',
      'desc':
          'Use code DoctorPro25 for your booking appointment between 20th sept to 25th october and get 25% off.'
    },
    {
      'type': 'offer',
      'title': 'Flat \$10 Off',
      'desc': 'Use code Doctor10 and get \$10 off on your appointment booking.'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1.0,
          titleSpacing: 0.0,
          title: Text(
            'Notifications',
            style: appBarTitleTextStyle,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: blackColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.bellSlash,
                color: Colors.grey,
                size: 60.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'No Notifications',
                style: greyNormalTextStyle,
              )
            ],
          ),
        )
        // (notificationList.length == 0)
        //     ? Center(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: <Widget>[
        //             Icon(
        //               FontAwesomeIcons.bellSlash,
        //               color: Colors.grey,
        //               size: 60.0,
        //             ),
        //             SizedBox(
        //               height: 20.0,
        //             ),
        //             Text(
        //               'No Notifications',
        //               style: greyNormalTextStyle,
        //             )
        //           ],
        //         ),
        //       )
        //     : ListView.builder(
        //         physics: BouncingScrollPhysics(),
        //         itemCount: notificationList.length,
        //         itemBuilder: (context, index) {
        //           final item = notificationList[index];
        //           return Dismissible(
        //             key: Key('$item'),
        //             onDismissed: (direction) {
        //               setState(() {
        //                 notificationList.removeAt(index);
        //               });

        //               // Then show a snackbar.
        //               ScaffoldMessenger.of(context).showSnackBar(
        //                   SnackBar(content: Text("${item['title']} dismissed")));
        //             },
        //             // Show a red background as the item is swiped away.
        //             background: Container(
        //                 margin: (index != notificationList.length - 1)
        //                     ? EdgeInsets.only(
        //                         top: fixPadding * 2.0,
        //                       )
        //                     : EdgeInsets.only(
        //                         top: fixPadding * 2.0,
        //                         bottom: fixPadding * 2.0,
        //                       ),
        //                 color: Colors.red),
        //             child: Center(
        //               child: Container(
        //                 margin: (index != notificationList.length - 1)
        //                     ? EdgeInsets.only(
        //                         top: fixPadding * 2.0,
        //                         right: fixPadding * 2.0,
        //                         left: fixPadding * 2.0,
        //                       )
        //                     : EdgeInsets.all(fixPadding * 2.0),
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(10.0),
        //                   color: whiteColor,
        //                   boxShadow: <BoxShadow>[
        //                     BoxShadow(
        //                       blurRadius: 1.0,
        //                       spreadRadius: 1.0,
        //                       color: Colors.grey[300],
        //                     ),
        //                   ],
        //                 ),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   crossAxisAlignment: CrossAxisAlignment.center,
        //                   children: <Widget>[
        //                     Container(
        //                       alignment: Alignment.topLeft,
        //                       padding: EdgeInsets.all(10.0),
        //                       child: CircleAvatar(
        //                         child: Icon(
        //                           (item['type'] == 'booking')
        //                               ? Icons.date_range
        //                               : Icons.local_offer,
        //                           size: 30.0,
        //                         ),
        //                         radius: 40.0,
        //                       ),
        //                     ),
        //                     Expanded(
        //                       child: Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: <Widget>[
        //                           Padding(
        //                             padding: EdgeInsets.only(
        //                                 top: 8.0, right: 8.0, left: 8.0),
        //                             child: Text(
        //                               '${item['title']}',
        //                               style: blackNormalBoldTextStyle,
        //                             ),
        //                           ),
        //                           Padding(
        //                             padding: EdgeInsets.all(8.0),
        //                             child: Text(
        //                               '${item['desc']}',
        //                               style: greySmallTextStyle,
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           );
        //         },
        //       ),

        );
  }
}
