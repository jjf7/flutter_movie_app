import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/models.dart';
import 'package:movies/models/movie_search_response.dart';

import '../helpers/debouncer.dart';

class MovieProvider extends ChangeNotifier {
  final String _baseURL = 'api.themoviedb.org';
  final String _apiKey = 'b7ea99402f19490b70c293d239e042b7';
  final String _language = 'es-ES';
  int _page = 0;

  List<Movie> listMovies = [];
  List<Movie> listPopularMovies = [];
  Map<int, List<Cast>> castingList = {};

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStreamContoller =
      StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => _suggestionStreamContoller.stream;

  MovieProvider() {
    getMoviesListFromApi();
    getPopularMovies();
  }

  Future<String> _callApi(String path, [int page = 1]) async {
    var url = Uri.https(_baseURL, path,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);

    return response.body;
  }

  getMoviesListFromApi() async {
    final data = await _callApi('/3/movie/now_playing');

    final NowPlayingResponse nowPlayingResponse =
        nowPlayingResponseFromJson(data);

    listMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    _page++;

    final data = await _callApi('/3/movie/popular', _page);

    final popularMoviesResponse = popularMoviesResponseFromJson(data);

    listPopularMovies = [
      ...listPopularMovies,
      ...popularMoviesResponse.results
    ];

    notifyListeners();
  }

  Future<List<Cast>> getListCastMovie(int idMovie) async {
    if (castingList.containsKey(idMovie)) {
      return castingList[idMovie] as List<Cast>;
    }

    final data = await _callApi('/3/movie/$idMovie/credits');

    final creditsMovie = creditsMovieFromJson(data);

    castingList[idMovie] = creditsMovie.cast;

    return creditsMovie.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseURL, '/3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);

    final searchMovieResponse = searchMovieResponseFromJson(response.body);

    return searchMovieResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      // print('Tenemos valor a buscar: $value');
      final results = await searchMovie(value);
      _suggestionStreamContoller.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
