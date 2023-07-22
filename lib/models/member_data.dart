class MemberData {
  int? id;
  bool? adminStatus;
  String? birthDate;
  bool? blacklisted;
  String? contact;
  String? email;
  String? gstNo;
  String? latitude;
  String? longitude;
  String? memberName;
  String? memberType;
  String? password;
  String? renewalDate;
  String? shopAddress;
  String? shopName;
  String? userImage;

  MemberData(
      {this.id,
      this.adminStatus,
      this.birthDate,
      this.blacklisted,
      this.contact,
      this.email,
      this.gstNo,
      this.latitude,
      this.longitude,
      this.memberName,
      this.memberType,
      this.password,
      this.renewalDate,
      this.shopAddress,
      this.shopName,
      this.userImage});

  MemberData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminStatus = json['adminStatus'];
    birthDate = json['birthDate'];
    blacklisted = json['blacklisted'];
    contact = json['contact'];
    email = json['email'];
    gstNo = json['gstNo'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    memberName = json['memberName'];
    memberType = json['memberType'];
    password = json['password'];
    renewalDate = json['renewalDate'];
    shopAddress = json['shopAddress'];
    shopName = json['shopName'];
    userImage = json['userImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['adminStatus'] = this.adminStatus;
    data['birthDate'] = this.birthDate;
    data['blacklisted'] = this.blacklisted;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['gstNo'] = this.gstNo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['memberName'] = this.memberName;
    data['memberType'] = this.memberType;
    data['password'] = this.password;
    data['renewalDate'] = this.renewalDate;
    data['shopAddress'] = this.shopAddress;
    data['shopName'] = this.shopName;
    data['userImage'] = this.userImage;
    return data;
  }
}
