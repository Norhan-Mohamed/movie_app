class ListOfTops {
  late List<TopMoviesModel> tops;
  ListOfTops({required this.tops});
  factory ListOfTops.fromJson(List<dynamic> json) {
    List<TopMoviesModel> tops =
        json.map((e) => TopMoviesModel.fromJson(e as Map<String, dynamic>)).toList();
    return ListOfTops(tops: tops);
  }

  Map<String, dynamic> toJson() {
    return {'tops': tops.map((e) => e.toJson()).toList()};
  }
}

class TopMoviesModel {
  late int rank;
  late String title;
  late String thumbnail;
  late String rating;
  late String id;
  late int year;
  late String image;
  late String description;
  late String trailer;
  late List<String> genre;
  late List<String> director;
  late List<String> writers;
  late String imdbid;

  TopMoviesModel({
    required this.rank,
    required this.title,
    required this.thumbnail,
    required this.rating,
    required this.id,
    required this.year,
    required this.image,
    required this.description,
    required this.trailer,
    required this.genre,
    required this.director,
    required this.writers,
    required this.imdbid,
  });

  static String _string(dynamic value, [String fallback = '']) {
    if (value == null) return fallback;
    return value.toString();
  }

  static int _int(dynamic value, [int fallback = 0]) {
    if (value == null) return fallback;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? fallback;
  }

  static List<String> _stringList(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return <String>[];
  }

  TopMoviesModel.fromJson(Map<String, dynamic> json) {
    rank = _int(json['rank']);
    title = _string(json['title']);
    thumbnail = _string(json['thumbnail']);
    rating = _string(json['rating']);
    id = _string(json['id']);
    year = _int(json['year']);
    image = _string(
      json['image'] ?? json['big_image'] ?? json['thumbnail'],
    );
    description = _string(json['description']);
    trailer = _string(json['trailer']);
    genre = _stringList(json['genre']);
    director = _stringList(json['director']);
    writers = _stringList(json['writers']);
    imdbid = _string(json['imdbid']);
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'title': title,
      'thumbnail': thumbnail,
      'rating': rating,
      'id': id,
      'year': year,
      'image': image,
      'description': description,
      'trailer': trailer,
      'genre': genre,
      'director': director,
      'writers': writers,
      'imdbid': imdbid,
    };
  }
}
