class InsuranceClass {
  String title;
  int id;
  String icon;
  var data;
  bool selected;
  String? flag;
  InsuranceClass({
    required this.title,
    required this.id,
    this.icon = '',
    this.data,
    this.selected = false,
    this.flag,
  });
  bool get hasFlag => this.flag is String;
}

class TipsClass {
  String title;
  String text;
  int id;
  String icon;

  TipsClass({
    required this.title,
    required this.id,
    required this.icon,
    required this.text,
  });
}
