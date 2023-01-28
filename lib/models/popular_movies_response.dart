// To parse this JSON data, do
//
//     final popularMoviesResponse = popularMoviesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:movies/models/movie.dart';

PopularMoviesResponse popularMoviesResponseFromJson(String str) =>
    PopularMoviesResponse.fromJson(json.decode(str));

class PopularMoviesResponse {
  PopularMoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory PopularMoviesResponse.fromJson(Map<String, dynamic> json) =>
      PopularMoviesResponse(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
