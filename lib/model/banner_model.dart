class BanneRModel{

  String image;
  String url;

  BanneRModel({
    this.image ="",
    this.url = "",
  });

  factory BanneRModel.fromMap(Map data) {
    return BanneRModel(
      image: data['image'] ?? "",
      url: data['url'] ?? "" ,
    );
  }
}