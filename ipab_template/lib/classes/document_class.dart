class Document {
  String rCaseType;
  String rCaseNumber;
  String rBenchName;
  String rServiceName;
  String rCategoryName;
  String rURL;
  String rDATE;

  Document(
      {this.rCaseType,
      this.rCaseNumber,
      this.rBenchName,
      this.rServiceName,
      this.rCategoryName,
      this.rURL,
      this.rDATE});

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
        rCaseType: json["rCaseType"] as String,
        rCaseNumber: json["rCaseNumber"] as String,
        rBenchName: json["rBenchName"] as String,
        rServiceName: json["rServiceName"] as String,
        rCategoryName: json["rCategoryName"] as String,
        rURL: json["rURL"] as String,
        rDATE: json["rDATE"] as String);
  }
}
