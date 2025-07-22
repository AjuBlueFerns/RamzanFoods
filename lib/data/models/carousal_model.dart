
class CarousalModel {
  String? id;
  String? imageUrl;
  String? title;
  String? desc;
  CarousalModel({
    this.id,
    this.imageUrl,
    this.title,
    this.desc,
  });

  factory CarousalModel.fromJson(Map<String, dynamic> json) {
    // var linkUrl = json['']
    return CarousalModel(
      id: json['id'],
      imageUrl: json['img-detail'],
      title: json['title'],
      desc: json['desc'],
    );
  }
}
