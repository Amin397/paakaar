class VersionModel {
  VersionModel({
    this.current,
    this.force,
    this.hasDirect,
    this.hasGooglePlay,
    this.directLink,
    this.googlePlayLink,
  });

  String? current;
  bool? force;
  bool? hasDirect;
  bool? hasGooglePlay;
  String? directLink;
  String? googlePlayLink;

  factory VersionModel.fromJson(Map<String, dynamic> json) => VersionModel(
    current: json["current"],
    force: json["force"],
    hasDirect: json["hasDirect"],
    hasGooglePlay: json["hasGooglePlay"],
    directLink: json["directLink"],
    googlePlayLink: json["googlePlayLink"],
  );

  Map<String, dynamic> toJson() => {
    "current": current,
    "force": force,
    "hasDirect": hasDirect,
    "hasGooglePlay": hasGooglePlay,
    "directLink": directLink,
    "googlePlayLink": googlePlayLink,
  };
}
