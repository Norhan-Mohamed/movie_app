class ListOfMovies {
  late List<MoviesModel> movies;
  ListOfMovies({required this.movies});
  factory ListOfMovies.fromJson(List<dynamic> json) {
    List<MoviesModel> movies = <MoviesModel>[];
    movies = json.map((e) => MoviesModel.fromJson(e)).toList();
    return ListOfMovies(movies: movies);
  }
  Map<String, dynamic> toJson() {
    List<Map> MoviesList = [];
    movies!.forEach((element) => MoviesList.add(element.toJson()));
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tops'] = this.movies;
    return data;
  }
}

class MoviesModel {
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

  MoviesModel(
      {required this.rank,
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
      required this.imdbid});

  MoviesModel.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    rating = json['rating'];
    id = json['id'];

    year = json['year'];
    image = json['image'];
    description = json['description'];
    trailer = json['trailer'];
    genre = json['genre'].cast<String>();
    director = json['director'].cast<String>();
    writers = json['writers'].cast<String>();
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
    data['genre'] = this.genre;
    data['director'] = this.director;
    data['writers'] = this.writers;
    data['imdbid'] = this.imdbid;
    return data;
  }
}
