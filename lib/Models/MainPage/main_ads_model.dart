class MainAdsModel {
  MainAdsModel({
    this.adBannerPic,
  });

  String? adBannerPic;

  factory MainAdsModel.fromJson(Map<String, dynamic> json) => MainAdsModel(
    adBannerPic: json["ad_banner_pic"],
  );

  static List<MainAdsModel> listFromJson(List data){
    return data.map((e) => MainAdsModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
    "ad_banner_pic": adBannerPic,
  };
}
