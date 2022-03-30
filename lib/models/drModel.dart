// class DrModel {
//   String drUid;
//   String drGender;
//   String timing;
//   String rating;
//   String about;
//   String drImage;
//   List<AfternoonSlotList> afternoonSlotList;
//   String experience;
//   List<DoctorTypeList> doctorTypeList;
//   List<EveningSlotList> eveningSlotList;
//   String price;
//   String drName;
//   String drAddress;
//   List<MorningSlotList> morningSlotList;

//   DrModel(
//       {this.drGender,
//       this.timing,
//       this.rating,
//       this.about,
//       this.drImage,
//       this.afternoonSlotList,
//       this.experience,
//       this.doctorTypeList,
//       this.eveningSlotList,
//       this.price,
//       this.drName,
//       this.drAddress,
//       this.morningSlotList,
//       this.drUid});

//   DrModel.fromJson(Map<String, dynamic> json) {
//     drUid = json['drUid'];
//     drGender = json['drGender'];
//     timing = json['timing'];
//     rating = json['rating'];
//     about = json['about'];
//     drImage = json['drImage'];
//     if (json['afternoonSlotList'] != null) {
//       afternoonSlotList = <AfternoonSlotList>[];
//       json['afternoonSlotList'].forEach((v) {
//         afternoonSlotList.add(new AfternoonSlotList.fromJson(v));
//       });
//     }
//     experience = json['experience'];
//     if (json['doctorTypeList'] != null) {
//       doctorTypeList = <DoctorTypeList>[];
//       json['doctorTypeList'].forEach((v) {
//         doctorTypeList.add(new DoctorTypeList.fromJson(v));
//       });
//     }
//     if (json['eveningSlotList'] != null) {
//       eveningSlotList = <EveningSlotList>[];
//       json['eveningSlotList'].forEach((v) {
//         eveningSlotList.add(new EveningSlotList.fromJson(v));
//       });
//     }
//     price = json['price'];
//     drName = json['drName'];
//     drAddress = json['drAddress'];
//     if (json['morningSlotList'] != null) {
//       morningSlotList = <MorningSlotList>[];
//       json['morningSlotList'].forEach((v) {
//         morningSlotList.add(new MorningSlotList.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['drUid'] = this.drUid;
//     data['drGender'] = this.drGender;
//     data['timing'] = this.timing;
//     data['rating'] = this.rating;
//     data['about'] = this.about;
//     data['drImage'] = this.drImage;
//     if (this.afternoonSlotList != null) {
//       data['afternoonSlotList'] =
//           this.afternoonSlotList.map((v) => v.toJson()).toList();
//     }
//     data['experience'] = this.experience;
//     if (this.doctorTypeList != null) {
//       data['doctorTypeList'] =
//           this.doctorTypeList.map((v) => v.toJson()).toList();
//     }
//     if (this.eveningSlotList != null) {
//       data['eveningSlotList'] =
//           this.eveningSlotList.map((v) => v.toJson()).toList();
//     }
//     data['price'] = this.price;
//     data['drName'] = this.drName;
//     data['drAddress'] = this.drAddress;
//     if (this.morningSlotList != null) {
//       data['morningSlotList'] =
//           this.morningSlotList.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class AfternoonSlotList {
//   String time;

//   AfternoonSlotList({this.time});

//   AfternoonSlotList.fromJson(Map<String, dynamic> json) {
//     time = json['time'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['time'] = this.time;
//     return data;
//   }
// }

// class DoctorTypeList {
//   String type;

//   DoctorTypeList({this.type});

//   DoctorTypeList.fromJson(Map<String, dynamic> json) {
//     type = json['type'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['type'] = this.type;
//     return data;
//   }
// }

// class EveningSlotList {
//   String time;

//   EveningSlotList({this.time});

//   EveningSlotList.fromJson(Map<String, dynamic> json) {
//     time = json['time'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['time'] = this.time;
//     return data;
//   }
// }

// class MorningSlotList {
//   String time;

//   MorningSlotList({this.time});

//   MorningSlotList.fromJson(Map<String, dynamic> json) {
//     time = json['time'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['time'] = this.time;
//     return data;
//   }
// }
// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final drModel = drModelFromJson(jsonString);

import 'dart:convert';

DrModel drModelFromJson(String str) => DrModel.fromDocument(json.decode(str));

String drModelToJson(DrModel data) => json.encode(data.toJson());

class DrModel {
  DrModel({
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
    this.price,
    this.drAddress,
    this.drEmail,
    this.drMobile,
    this.morningSlotList,
    this.pricePayment,
  });
  int pricePayment;
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
  String price;
  String drAddress;
  String drEmail;
  String drMobile;

  List<SlotList> morningSlotList;

  factory DrModel.fromDocument(Map<String, dynamic> json) => DrModel(
        pricePayment: json["pricePayment"],
        drImage: json["drImage"],
        city: json["city"],
        timing: json["timing"],
        drAge: json["drAge"],
        rating: json["rating"],
        about: json["about"],
        doctorTypeList: List<DoctorTypeList>.from(
            json["doctorTypeList"].map((x) => DoctorTypeList.fromDocument(x))),
        drName: json["drName"],
        drGender: json["drGender"],
        afternoonSlotList: List<SlotList>.from(
            json["afternoonSlotList"].map((x) => SlotList.fromDocument(x))),
        searchKey: List<String>.from(json["searchKey"].map((x) => x)),
        experience: json["experience"],
        eveningSlotList: List<SlotList>.from(
            json["eveningSlotList"].map((x) => SlotList.fromDocument(x))),
        drUid: json["drUid"],
        price: json["price"],
        drAddress: json["drAddress"],
        drEmail: json["drEmail"],
        drMobile: json["drMobile"],
        morningSlotList: List<SlotList>.from(
            json["morningSlotList"].map((x) => SlotList.fromDocument(x))),
      );

  Map<String, dynamic> toJson() => {
        "pricePayment": pricePayment,
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

  factory SlotList.fromDocument(Map<String, dynamic> json) => SlotList(
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

  factory DoctorTypeList.fromDocument(Map<String, dynamic> json) =>
      DoctorTypeList(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
      };
}
