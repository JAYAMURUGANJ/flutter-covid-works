class ARdata {
  String arCategory;
  String arDescription;
  String arURLlink;

  ARdata({
    this.arCategory,
    this.arDescription,
    this.arURLlink,
  });

  factory ARdata.fromJson(Map<String, dynamic> json) {
    return ARdata(
        arCategory: json["arCategory"] as String,
        arDescription: json["arDescription"] as String,
        arURLlink: json["arURLlink"] as String);
  }
}
