class AppointmentModel {
  String date;
  String patientname;
  String address;
  String price;
  String drName;
  String drAdress;
  String typeofPatient;
  String typeofDoctor;
  String time;
  String mobileNo;
  String age;
  String userUid;
  String status;
  String slipImg;
  String drUid;

  AppointmentModel(
      {this.date,
      this.patientname,
      this.address,
      this.price,
      this.drName,
      this.drAdress,
      this.typeofPatient,
      this.typeofDoctor,
      this.time,
      this.mobileNo,
      this.age,
      this.userUid,
      this.status,
      this.slipImg,
      this.drUid});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    patientname = json['patientname'];
    address = json['address'];
    price = json['price'];
    drName = json['drName'];
    drAdress = json['drAdress'];
    typeofPatient = json['typeofPatient'];
    typeofDoctor = json['typeofDoctor'];
    time = json['time'];
    mobileNo = json['mobileNo'];
    age = json['age'];
    userUid = json['user_uid'];
    status = json['status'];
    slipImg = json['slipImg'];
    drUid = json['drUid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['patientname'] = this.patientname;
    data['address'] = this.address;
    data['price'] = this.price;
    data['drName'] = this.drName;
    data['drAdress'] = this.drAdress;
    data['typeofPatient'] = this.typeofPatient;
    data['typeofDoctor'] = this.typeofDoctor;
    data['time'] = this.time;
    data['mobileNo'] = this.mobileNo;
    data['age'] = this.age;
    data['user_uid'] = this.userUid;
    data['status'] = this.status;
    data['slipImg'] = this.slipImg;
    data['drUid'] = this.drUid;
    return data;
  }
}
