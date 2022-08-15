// To parse this JSON local_data, do
//
//     final moviePopular = moviePopularFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:ex6/api/decodable.dart';

MoviePopular moviePopularFromJson(String str) =>
    MoviePopular.fromJson(json.decode(str));

String moviePopularToJson(MoviePopular data) => json.encode(data.toJson());

class MoviePopular implements Decodable<MoviePopular>{
  MoviePopular({
    this.page,
    this.results,
    this.totalResults,
    this.totalPages,
  });

  int? page;
  List<MoviePopularResult>? results;
  int? totalResults;
  int? totalPages;

  factory MoviePopular.fromJson(Map<String, dynamic> json) => MoviePopular(
        page: json["page"],
        results: List<MoviePopularResult>.from(
            json["results"].map((x) => MoviePopularResult.fromJson(x))),
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_results": totalResults,
        "total_pages": totalPages,
      };

  @override
  MoviePopular decode(json) {
    page= json["page"];
    results= List<MoviePopularResult>.from(
    json["results"].map((x) => MoviePopularResult.fromJson(x)));
    totalResults= json["total_results"];
    totalPages= json["total_pages"];
    return this;
    // TODO: implement decode
  }
}

class MoviePopularResult {
  MoviePopularResult({
    this.posterPath,
    this.adult,
    this.overview,
    required this.releaseDate,
    this.genreIds,
    this.id,
    this.originalTitle,
    this.originalLanguage,
    this.title,
    this.backdropPath,
    this.popularity,
    this.voteCount,
    this.video,
    this.voteAverage,
  });

  String? posterPath;
  bool? adult;
  String? overview;
  DateTime? releaseDate;
  List<int>? genreIds;
  int? id;
  String? originalTitle;
  OriginalLanguage? originalLanguage;
  String? title;
  String? backdropPath;
  double? popularity;
  int? voteCount;
  bool? video;
  double? voteAverage;

  factory MoviePopularResult.fromJson(Map<String, dynamic> json) =>
      MoviePopularResult(
        posterPath: json["poster_path"],
        adult: json["adult"],
        overview: json["overview"],
        releaseDate: json["release_date"] == null || json["release_date"] == ""
            ? null
            : DateTime.parse(json["release_date"]),
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalTitle: json["original_title"],
        originalLanguage:
            originalLanguageValues.map![json["original_language"]],
        title: json["title"],
        backdropPath: json["backdrop_path"],
        popularity: json["popularity"].toDouble(),
        voteCount: json["vote_count"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "adult": adult,
        "overview": overview,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "original_title": originalTitle,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "title": title,
        "backdrop_path": backdropPath,
        "popularity": popularity,
        "vote_count": voteCount,
        "video": video,
        "vote_average": voteAverage,
      };
}

enum OriginalLanguage { EN }

final originalLanguageValues = EnumValues({"en": OriginalLanguage.EN});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
