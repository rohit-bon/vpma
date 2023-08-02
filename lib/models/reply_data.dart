class ReplyData {
  int? id;
  String? query;
  String? queryDate;
  String? reply;
  dynamic replyDate;
  bool? viewed;

  ReplyData(
      {this.id,
      this.query,
      this.queryDate,
      this.reply,
      this.replyDate,
      this.viewed});

  ReplyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    query = json['query'];
    queryDate = json['queryDate'];
    reply = json['reply'];
    replyDate = json['replyDate'];
    viewed = json['viewed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['query'] = this.query;
    data['queryDate'] = this.queryDate;
    data['reply'] = this.reply;
    data['replyDate'] = this.replyDate;
    data['viewed'] = this.viewed;
    return data;
  }
}
