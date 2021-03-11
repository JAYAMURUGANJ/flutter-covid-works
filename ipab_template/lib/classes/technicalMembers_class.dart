class TechnicalMembers {
  String profileImage;
  String memberName;
  String position;
  String rCategoryName;
  String html;

  TechnicalMembers(
      {this.profileImage,
      this.memberName,
      this.position,
      this.html,
      this.rCategoryName});

  TechnicalMembers.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'];
    memberName = json['memberName'];
    position = json['position'];
    rCategoryName = json['rCategoryName'];
    html = json['html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileImage'] = this.profileImage;
    data['memberName'] = this.memberName;
    data['position'] = this.position;
    data['rCategoryName'] = this.rCategoryName;
    data['html'] = this.html;
    return data;
  }
}
