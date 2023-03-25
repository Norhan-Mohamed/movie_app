class FavScreenModel {
  late int? rank;
  late String? title;
  late String? thumbnail;
  late String? rating;
  late String? id;
  late int? year;
  late String? image;
  late String? description;
  late String? trailer;

  late String? imdbid;

  FavScreenModel(
      {required this.rank,
      required this.title,
      required this.thumbnail,
      required this.rating,
      required this.id,
      required this.year,
      required this.image,
      required this.description,
      required this.trailer,
      required this.imdbid});

  FavScreenModel.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    rating = json['rating'];
    id = json['id'];
    year = json['year'];
    image = json['image'];
    description = json['description'];
    trailer = json['trailer'];

    imdbid = json['imdbid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rank'] = this.rank;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['rating'] = this.rating;
    data['id'] = this.id;
    data['year'] = this.year;
    data['image'] = this.image;
    data['description'] = this.description;
    data['trailer'] = this.trailer;

    data['imdbid'] = this.imdbid;
    return data;
  }
}
