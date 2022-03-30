class LabModel {
  String name;
  String image;
  String address;
  String mobile;
  String city;

  LabModel({this.name, this.image, this.address, this.mobile, this.city});

  LabModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    address = json['address'];
    mobile = json['mobile'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['city'] = this.city;
    return data;
  }
}
