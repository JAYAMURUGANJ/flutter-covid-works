class IPABNotifications {
  String rCaseType;
  String rCaseNumber;
  String rBenchName;
  String rServiceName;
  String rCategoryName;
  String rTechnicalMember;
  String rDATE;
  String rURL;
  bool rNewStatus;
  String rNotice;

  IPABNotifications(
      {this.rCaseType,
      this.rCaseNumber,
      this.rBenchName,
      this.rServiceName,
      this.rCategoryName,
      this.rTechnicalMember,
      this.rDATE,
      this.rURL,
      this.rNewStatus,
      this.rNotice});

  IPABNotifications.fromJson(Map<String, dynamic> json) {
    rCaseType = json['rCaseType'];
    rCaseNumber = json['rCaseNumber'];
    rBenchName = json['rBenchName'];
    rServiceName = json['rServiceName'];
    rCategoryName = json['rCategoryName'];
    rTechnicalMember = json['rTechnicalMember'];
    rDATE = json['rDATE'];
    rURL = json['rURL'];
    rNewStatus = json['rNewStatus'];
    rNotice = json['rNotice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rCaseType'] = this.rCaseType;
    data['rCaseNumber'] = this.rCaseNumber;
    data['rBenchName'] = this.rBenchName;
    data['rServiceName'] = this.rServiceName;
    data['rCategoryName'] = this.rCategoryName;
    data['rTechnicalMember'] = this.rTechnicalMember;
    data['rDATE'] = this.rDATE;
    data['rURL'] = this.rURL;
    data['rNewStatus'] = this.rNewStatus;
    data['rNotice'] = this.rNotice;
    return data;
  }
}
