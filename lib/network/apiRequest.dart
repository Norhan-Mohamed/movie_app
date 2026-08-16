import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/topMoviesModel.dart';

class ApiTopMovies {
  static const String _apiKey = String.fromEnvironment(
    'RAPIDAPI_KEY',
    defaultValue: 'dfca9aeeabmsh821bd4b8f611251p158266jsn3f9057aef37a',
  );

  static Map<String, String> get _headers => {
        'X-RapidAPI-Key': _apiKey,
        'X-RapidAPI-Host': 'imdb-top-100-movies.p.rapidapi.com',
      };

  Future<ListOfTops> apiData() async {
    final response = await http.get(
      Uri.https('imdb-top-100-movies.p.rapidapi.com', '/'),
      headers: _headers,
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final List body = jsonDecode(response.body);
      return ListOfTops.fromJson(body);
    }

    _throwForStatus(response.statusCode);
  }

  Future<TopMoviesModel> apiDataById(String id) async {
    final response = await http.get(
      Uri.https('imdb-top-100-movies.p.rapidapi.com', '/$id'),
      headers: _headers,
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final body = jsonDecode(response.body);
      if (body is Map<String, dynamic>) {
        return TopMoviesModel.fromJson(body);
      }
      if (body is List && body.isNotEmpty) {
        return TopMoviesModel.fromJson(body.first as Map<String, dynamic>);
      }
      throw Exception('Unexpected movie detail response');
    }

    _throwForStatus(response.statusCode);
  }

  Never _throwForStatus(int statusCode) {
    if (statusCode == 401 || statusCode == 403) {
      throw Exception(
        'API access denied ($statusCode).\n\n'
        'Check that the RapidAPI key is valid and subscribed to '
        '"IMDb Top 100 Movies" on RapidAPI.',
      );
    }
    throw Exception('Failed to load movies: $statusCode');
  }
}
