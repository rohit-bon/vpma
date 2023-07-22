class NewsData {
  int? id;
  String? description;
  String? head;
  String? image;
  String? published;

  NewsData({this.id, this.description, this.head, this.image, this.published});

  NewsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    head = json['head'];
    image = json['image'];
    published = json['published'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['head'] = this.head;
    data['image'] = this.image;
    data['published'] = this.published;
    return data;
  }
}
