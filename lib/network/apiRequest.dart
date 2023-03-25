import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/topMoviesModel.dart';

import '../models/moviesModel.dart';

class ApiTopMovies {
  Future<ListOfTops> ApiData() async {
    final response = await http
        .get(Uri.https('imdb-top-100-movies.p.rapidapi.com'), headers: {
      'X-RapidAPI-Key': 'dfca9aeeabmsh821bd4b8f611251p158266jsn3f9057aef37a',
      'X-RapidAPI-Host': 'imdb-top-100-movies.p.rapidapi.com'
    });
    if (response.statusCode <= 299 && response.statusCode >= 200) {
      List body = jsonDecode(response.body);
      print(body);
      ListOfTops topMoviesModel = ListOfTops.fromJson(body);
      return topMoviesModel;
    } else {
      throw ('failed' + response.body);
    }
  }
}

class ApiDataById {
  Future<MoviesModel> ApiData() async {
    final response = await http
        .get(Uri.https('imdb-top-100-movies.p.rapidapi.com/top17'), headers: {
      'X-RapidAPI-Key': 'dfca9aeeabmsh821bd4b8f611251p158266jsn3f9057aef37a',
      'X-RapidAPI-Host': 'imdb-top-100-movies.p.rapidapi.com'
    });
    if (response.statusCode <= 299 && response.statusCode >= 200) {
      List body = jsonDecode(response.body);
      print(body);
      MoviesModel moviesModel =
          MoviesModel.fromJson(body as Map<String, dynamic>);
      return moviesModel;
    } else {
      throw ('failed' + response.body);
    }
  }
}
