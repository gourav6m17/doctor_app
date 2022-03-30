// class DrModel {
//   String gender;
//   String timing;
//   String rating;
//   String about;
//   String photo;
//   List<String> afternoonSlotList;
//   String experience;
//   List<String> type;
//   List<String> eveningSlotList;
//   String price;
//   String name;
//   String location;
//   List<String> morningSlotList;

//   DrModel(
//       {this.gender,
//       this.timing,
//       this.rating,
//       this.about,
//       this.photo,
//       this.afternoonSlotList,
//       this.experience,
//       this.type,
//       this.eveningSlotList,
//       this.price,
//       this.name,
//       this.location,
//       this.morningSlotList});

//   DrModel.fromJson(Map<String, dynamic> json) {
//     gender = json['gender'];
//     timing = json['timing'];
//     rating = json['rating'];
//     about = json['about'];
//     photo = json['photo'];
//     afternoonSlotList = json['afternoonSlotList'].cast<String>();
//     experience = json['experience'];
//     type = json['type'].cast<String>();
//     eveningSlotList = json['eveningSlotList'].cast<String>();
//     price = json['price'];
//     name = json['name'];
//     location = json['location'];
//     morningSlotList = json['morningSlotList'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['gender'] = this.gender;
//     data['timing'] = this.timing;
//     data['rating'] = this.rating;
//     data['about'] = this.about;
//     data['photo'] = this.photo;
//     data['afternoonSlotList'] = this.afternoonSlotList;
//     data['experience'] = this.experience;
//     data['type'] = this.type;
//     data['eveningSlotList'] = this.eveningSlotList;
//     data['price'] = this.price;
//     data['name'] = this.name;
//     data['location'] = this.location;
//     data['morningSlotList'] = this.morningSlotList;
//     return data;
//   }
// }

class DrModel {
  String drGender;
  String timing;
  String rating;
  String about;
  String drImage;
  List<AfternoonSlotList> afternoonSlotList;
  String experience;
  List<DoctorTypeList> doctorTypeList;
  List<EveningSlotList> eveningSlotList;
  String price;
  String drName;
  String drAddress;
  List<MorningSlotList> morningSlotList;

  DrModel(
      {this.drGender,
      this.timing,
      this.rating,
      this.about,
      this.drImage,
      this.afternoonSlotList,
      this.experience,
      this.doctorTypeList,
      this.eveningSlotList,
      this.price,
      this.drName,
      this.drAddress,
      this.morningSlotList});

  DrModel.fromJson(Map<String, dynamic> json) {
    drGender = json['drGender'];
    timing = json['timing'];
    rating = json['rating'];
    about = json['about'];
    drImage = json['drImage'];
    if (json['afternoonSlotList'] != null) {
      afternoonSlotList = <AfternoonSlotList>[];
      json['afternoonSlotList'].forEach((v) {
        afternoonSlotList.add(new AfternoonSlotList.fromJson(v));
      });
    }
    experience = json['experience'];
    if (json['doctorTypeList'] != null) {
      doctorTypeList = <DoctorTypeList>[];
      json['doctorTypeList'].forEach((v) {
        doctorTypeList.add(new DoctorTypeList.fromJson(v));
      });
    }
    if (json['eveningSlotList'] != null) {
      eveningSlotList = <EveningSlotList>[];
      json['eveningSlotList'].forEach((v) {
        eveningSlotList.add(new EveningSlotList.fromJson(v));
      });
    }
    price = json['price'];
    drName = json['drName'];
    drAddress = json['drAddress'];
    if (json['morningSlotList'] != null) {
      morningSlotList = <MorningSlotList>[];
      json['morningSlotList'].forEach((v) {
        morningSlotList.add(new MorningSlotList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['drGender'] = this.drGender;
    data['timing'] = this.timing;
    data['rating'] = this.rating;
    data['about'] = this.about;
    data['drImage'] = this.drImage;
    if (this.afternoonSlotList != null) {
      data['afternoonSlotList'] =
          this.afternoonSlotList.map((v) => v.toJson()).toList();
    }
    data['experience'] = this.experience;
    if (this.doctorTypeList != null) {
      data['doctorTypeList'] =
          this.doctorTypeList.map((v) => v.toJson()).toList();
    }
    if (this.eveningSlotList != null) {
      data['eveningSlotList'] =
          this.eveningSlotList.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['drName'] = this.drName;
    data['drAddress'] = this.drAddress;
    if (this.morningSlotList != null) {
      data['morningSlotList'] =
          this.morningSlotList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AfternoonSlotList {
  String time;

  AfternoonSlotList({this.time});

  AfternoonSlotList.fromJson(Map<String, dynamic> json) {
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    return data;
  }
}

class DoctorTypeList {
  String type;

  DoctorTypeList({this.type});

  DoctorTypeList.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    return data;
  }
}

class EveningSlotList {
  String time;

  EveningSlotList({this.time});

  EveningSlotList.fromJson(Map<String, dynamic> json) {
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    return data;
  }
}

class MorningSlotList {
  String time;

  MorningSlotList({this.time});

  MorningSlotList.fromJson(Map<String, dynamic> json) {
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    return data;
  }
}
