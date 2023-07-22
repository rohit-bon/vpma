class EventsData {
  int? id;
  String? eventDate;
  String? eventDesc;
  String? eventHead;
  String? eventThumb;

  EventsData(
      {this.id,
      this.eventDate,
      this.eventDesc,
      this.eventHead,
      this.eventThumb});

  EventsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventDate = json['eventDate'];
    eventDesc = json['eventDesc'];
    eventHead = json['eventHead'];
    eventThumb = json['eventThumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['eventDate'] = this.eventDate;
    data['eventDesc'] = this.eventDesc;
    data['eventHead'] = this.eventHead;
    data['eventThumb'] = this.eventThumb;
    return data;
  }
}
