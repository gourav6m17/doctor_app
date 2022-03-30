import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_doctor_client/constant/constant.dart';

class Lab extends StatefulWidget {
  final String name, address, image;
  final lat, lang;

  const Lab(
      {Key key,
      @required this.name,
      @required this.address,
      @required this.image,
      @required this.lat,
      @required this.lang})
      : super(key: key);
  @override
  _LabState createState() => _LabState();
}

class _LabState extends State<Lab> {
  Set<Marker> markers;

  @override
  void initState() {
    super.initState();
    markers = Set.from([]);
  }

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
          'Lab tests & health checkup',
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
      bottomNavigationBar: Material(
        elevation: 5.0,
        child: Container(
          color: Colors.white,
          width: width,
          height: 70.0,
          padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                elevation: 2.0,
                borderRadius: BorderRadius.circular(10.0),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 50.0,
                    width: (width - fixPadding * 6.0) / 2.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: whiteColor,
                      border: Border.all(width: 0.8, color: Colors.grey[400]),
                    ),
                    child: Text(
                      'Message',
                      style: blackColorButtonTextStyle,
                    ),
                  ),
                ),
              ),
              Material(
                elevation: 2.0,
                borderRadius: BorderRadius.circular(10.0),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 50.0,
                    width: (width - fixPadding * 6.0) / 2.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: primaryColor,
                    ),
                    child: Text(
                      'Call Now',
                      style: whiteColorButtonTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Material(
            elevation: 2.0,
            child: Container(
              padding: EdgeInsets.all(fixPadding * 2.0),
              color: whiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 76.0,
                    height: 76.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 1.0,
                          spreadRadius: 1.0,
                          color: Colors.grey[300],
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage(widget.image),
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
                          widget.name,
                          style: blackNormalBoldTextStyle,
                        ),
                        SizedBox(height: 7.0),
                        Text(
                          widget.address,
                          style: greyNormalTextStyle,
                        ),
                        SizedBox(height: 7.0),
                        Text(
                          'Timing:',
                          style: primaryColorsmallTextStyle,
                        ),
                        SizedBox(height: 7.0),
                        Text(
                          '9:00 AM to 8:00 PM',
                          style: blackSmallTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Address & Map Start
          address(),
          // Address & Map End

          // Facilities Start
          facilities(),
          // Facilities End
        ],
      ),
    );
  }

  address() {
    return Container(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Address',
            style: primaryColorHeadingTextStyle,
          ),
          SizedBox(height: 7.0),
          Text(
            widget.address,
            style: blackSmallBoldTextStyle,
          ),
          heightSpace,
          heightSpace,
          Container(
            width: double.infinity,
            height: 250.0,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  color: Colors.grey[300],
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: GoogleMap(
                markers: markers,
                onMapCreated: (GoogleMapController controller) {
                  Marker m = Marker(
                      markerId: MarkerId('1'),
                      position: LatLng(widget.lat, widget.lang));
                  setState(() {
                    markers.add(m);
                  });
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(widget.lat, widget.lang), zoom: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  facilities() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Facilities',
            style: primaryColorHeadingTextStyle,
          ),
          heightSpace,
          heightSpace,
          facilityTile('Parking available'),
          heightSpace,
          facilityTile('E-Reports available'),
          heightSpace,
          facilityTile('Card accepted'),
          heightSpace,
          facilityTile('Prescription pick up available'),
          heightSpace,
          facilityTile('Report doorstep drop available'),
          heightSpace,
          heightSpace,
        ],
      ),
    );
  }

  facilityTile(text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check,
          color: blackColor,
          size: 16.0,
        ),
        widthSpace,
        Expanded(
          child: Text(
            text,
            style: blackSmallTextStyle,
          ),
        ),
      ],
    );
  }
}
