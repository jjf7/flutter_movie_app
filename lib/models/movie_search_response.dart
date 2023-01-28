// To parse this JSON data, do
//
//     final searchMovieResponse = searchMovieResponseFromJson(jsonString);

import 'dart:convert';

import 'package:movies/models/models.dart';

SearchMovieResponse searchMovieResponseFromJson(String str) =>
    SearchMovieResponse.fromJson(json.decode(str));

class SearchMovieResponse {
  SearchMovieResponse({
    this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int? page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory SearchMovieResponse.fromJson(Map<String, dynamic> json) =>
      SearchMovieResponse(
        page: json["page"] ?? null,
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
