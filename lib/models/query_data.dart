class QueryData {
  int? id;
  String? memberContact;
  String? memberEmail;
  String? memberID;
  String? memberName;
  String? msgDate;
  String? query;
  String? reply;
  String? replyDate;
  String? replyID;
  bool? viewed;

  QueryData(
      {this.id,
      this.memberContact,
      this.memberEmail,
      this.memberID,
      this.memberName,
      this.msgDate,
      this.query,
      this.reply,
      this.replyDate,
      this.replyID,
      this.viewed});

  QueryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberContact = json['memberContact'];
    memberEmail = json['memberEmail'];
    memberID = json['memberID'];
    memberName = json['memberName'];
    msgDate = json['msgDate'];
    query = json['query'];
    reply = json['reply'];
    replyDate = json['replyDate'];
    replyID = json['replyID'];
    viewed = json['viewed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['memberContact'] = this.memberContact;
    data['memberEmail'] = this.memberEmail;
    data['memberID'] = this.memberID;
    data['memberName'] = this.memberName;
    data['msgDate'] = this.msgDate;
    data['query'] = this.query;
    data['reply'] = this.reply;
    data['replyDate'] = this.replyDate;
    data['replyID'] = this.replyID;
    data['viewed'] = this.viewed;
    return data;
  }
}
