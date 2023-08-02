class AdData {
  int? id;
  String? adURL;
  dynamic published;
  String? wideAdURL;

  AdData({this.id, this.adURL, this.published, this.wideAdURL});

  AdData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adURL = json['adURL'];
    published = json['published'];
    wideAdURL = json['wideAdURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['adURL'] = this.adURL;
    data['published'] = this.published;
    data['wideAdURL'] = this.wideAdURL;
    return data;
  }
}
