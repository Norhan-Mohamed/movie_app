import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/topMoviesModel.dart';

class ApiTopMovies {
  static const String _apiKey = String.fromEnvironment(
    'RAPIDAPI_KEY',
    defaultValue: 'dfca9aeeabmsh821bd4b8f611251p158266jsn3f9057aef37a',
  );

  Future<ListOfTops> apiData() async {
    final response = await http.get(
      Uri.https('imdb-top-100-movies.p.rapidapi.com', '/'),
      headers: {
        'X-RapidAPI-Key': _apiKey,
        'X-RapidAPI-Host': 'imdb-top-100-movies.p.rapidapi.com',
      },
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final List body = jsonDecode(response.body);
      return ListOfTops.fromJson(body);
    }

    if (response.statusCode == 401 || response.statusCode == 403) {
      throw Exception(
        'API access denied (${response.statusCode}).\n\n'
        'Check that the RapidAPI key is valid and subscribed to '
        '"IMDb Top 100 Movies" on RapidAPI.',
      );
    }

    throw Exception('Failed to load movies: ${response.statusCode}');
  }
}
