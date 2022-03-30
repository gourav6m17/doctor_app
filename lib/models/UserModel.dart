class UserModel {
  String userGender;
  String userName;
  String userMobile;
  String userAge;
  String userEmail;
  String userImage;

  UserModel(
      {this.userGender,
      this.userName,
      this.userMobile,
      this.userAge,
      this.userEmail,
      this.userImage});

  UserModel.fromJson(Map<String, dynamic> json) {
    userGender = json['userGender'];
    userName = json['userName'];
    userMobile = json['userMobile'];
    userAge = json['userAge'];
    userEmail = json['userEmail'];
    userImage = json['userImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userGender'] = this.userGender;
    data['userName'] = this.userName;
    data['userMobile'] = this.userMobile;
    data['userAge'] = this.userAge;
    data['userEmail'] = this.userEmail;
    data['userImage'] = this.userImage;

    return data;
  }
}
