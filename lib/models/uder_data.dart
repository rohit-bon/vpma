class UserData {
  static bool isUserLogged = false;

  int? id;
  bool? activeStatus;
  bool? blacklisted;
  String? contact;
  String? email;
  String? gstNo;
  String? memberName;
  String? memberType;
  String? password;
  String? renewalDate;
  String? shopAddress;
  String? shopName;
  String? userImage;

  UserData(
      {this.id,
      this.activeStatus,
      this.blacklisted,
      this.contact,
      this.email,
      this.gstNo,
      this.memberName,
      this.memberType,
      this.password,
      this.renewalDate,
      this.shopAddress,
      this.shopName,
      this.userImage});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activeStatus = json['activeStatus'];
    blacklisted = json['blacklisted'];
    contact = json['contact'];
    email = json['email'];
    gstNo = json['gstNo'];
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
    data['activeStatus'] = this.activeStatus;
    data['blacklisted'] = this.blacklisted;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['gstNo'] = this.gstNo;
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
