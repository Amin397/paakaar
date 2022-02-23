class ReportModel {
  ReportModel({
    this.reportId,
    this.text,
  });

  int? reportId;
  String? text;

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
    reportId: json["reportId"],
    text: json["text"],
  );


  static List<ReportModel> listFromJson(List data){
    return data.map((e) => ReportModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
    "reportId": reportId,
    "text": text,
  };
}
