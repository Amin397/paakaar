class CallPriceType {
  int id;
  String name;
  bool isSelected = false;

  CallPriceType({
    required this.id,
    required this.name,
    this.isSelected = false,
  });
}
