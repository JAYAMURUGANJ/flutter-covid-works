class Document {
  String rBenchName;
  String rServiceName;
  String rCategoryName;
  String rURL;
  String rDATE;

  Document(
      {this.rBenchName,
      this.rServiceName,
      this.rCategoryName,
      this.rURL,
      this.rDATE});

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
        rBenchName: json["rBenchName"] as String,
        rServiceName: json["rServiceName"] as String,
        rCategoryName: json["rCategoryName"] as String,
        rURL: json["rURL"] as String,
        rDATE: json["rDATE"] as String);
  }
}
