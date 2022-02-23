class CommentModel {
  int id;
  int raterId;
  double score;
  String comment;
  String raterName;
  String datetime;

  CommentModel({
    required this.id,
    required this.raterId,
    required this.score,
    required this.comment,
    required this.raterName,
    required this.datetime,
  });

  factory CommentModel.fromJson(Map data) {
    return CommentModel(
      id: data['id'],
      raterId: data['raterId'],
      score: data['score'].toDouble(),
      comment: data['comment'],
      raterName: data['raterName'],
      datetime: data['datetime'],
    );
  }
  static List<CommentModel> listFromJson(List data) {
    return data.map((e) => CommentModel.fromJson(e)).toList();
  }
}
