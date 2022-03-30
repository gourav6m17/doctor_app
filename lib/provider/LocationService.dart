// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoder/geocoder.dart' as geoCo;

// class GenerateMaps extends ChangeNotifier {
//   Position position;
//   Position get getPosition => position;
//   String finalAddress = "Finding.......";
//   String get getFinalAddress => finalAddress;

//   Future getCurrentLocation() async {
//     var positionData = await GeolocatorPlatform.instance.getCurrentPosition();
//     final cords =
//         geoCo.Coordinates(positionData.latitude, positionData.longitude);
//     var address =
//         await geoCo.Geocoder.local.findAddressesFromCoordinates(cords);
//     String mainAddress = address.first.addressLine;
//     finalAddress = mainAddress;

//     print("===============$getFinalAddress");

//     notifyListeners();
//   }
// }
