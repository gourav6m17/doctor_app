// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.drImage,
    this.city,
    this.timing,
    this.drAge,
    this.rating,
    this.about,
    this.doctorTypeList,
    this.drName,
    this.drGender,
    this.afternoonSlotList,
    this.searchKey,
    this.experience,
    this.eveningSlotList,
    this.drUid,
    this.pos,
    this.price,
    this.drAddress,
    this.drEmail,
    this.drMobile,
    this.morningSlotList,
  });

  String drImage;
  String city;
  String timing;
  String drAge;
  String rating;
  String about;
  List<DoctorTypeList> doctorTypeList;
  String drName;
  String drGender;
  List<SlotList> afternoonSlotList;
  List<String> searchKey;
  String experience;
  List<SlotList> eveningSlotList;
  String drUid;
  String pos;
  String price;
  String drAddress;
  String drEmail;
  String drMobile;
  List<SlotList> morningSlotList;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        drImage: json["drImage"],
        city: json["city"],
        timing: json["timing"],
        drAge: json["drAge"],
        rating: json["rating"],
        about: json["about"],
        doctorTypeList: List<DoctorTypeList>.from(
            json["doctorTypeList"].map((x) => DoctorTypeList.fromJson(x))),
        drName: json["drName"],
        drGender: json["drGender"],
        afternoonSlotList: List<SlotList>.from(
            json["afternoonSlotList"].map((x) => SlotList.fromJson(x))),
        searchKey: List<String>.from(json["searchKey"].map((x) => x)),
        experience: json["experience"],
        eveningSlotList: List<SlotList>.from(
            json["eveningSlotList"].map((x) => SlotList.fromJson(x))),
        drUid: json["drUid"],
        pos: json["pos"],
        price: json["price"],
        drAddress: json["drAddress"],
        drEmail: json["drEmail"],
        drMobile: json["drMobile"],
        morningSlotList: List<SlotList>.from(
            json["morningSlotList"].map((x) => SlotList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "drImage": drImage,
        "city": city,
        "timing": timing,
        "drAge": drAge,
        "rating": rating,
        "about": about,
        "doctorTypeList":
            List<dynamic>.from(doctorTypeList.map((x) => x.toJson())),
        "drName": drName,
        "drGender": drGender,
        "afternoonSlotList":
            List<dynamic>.from(afternoonSlotList.map((x) => x.toJson())),
        "searchKey": List<dynamic>.from(searchKey.map((x) => x)),
        "experience": experience,
        "eveningSlotList":
            List<dynamic>.from(eveningSlotList.map((x) => x.toJson())),
        "drUid": drUid,
        "pos": pos,
        "price": price,
        "drAddress": drAddress,
        "drEmail": drEmail,
        "drMobile": drMobile,
        "morningSlotList":
            List<dynamic>.from(morningSlotList.map((x) => x.toJson())),
      };
}

class SlotList {
  SlotList({
    this.time,
  });

  String time;

  factory SlotList.fromJson(Map<String, dynamic> json) => SlotList(
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
      };
}

class DoctorTypeList {
  DoctorTypeList({
    this.type,
  });

  String type;

  factory DoctorTypeList.fromJson(Map<String, dynamic> json) => DoctorTypeList(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
      };
}
