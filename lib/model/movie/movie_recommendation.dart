// To parse this JSON local_data, do
//
//     final movieRecommendation = movieRecommendationFromJson(jsonString);

import 'dart:convert';

import 'package:ex6/api/decodable.dart';
import 'package:ex6/helper/helper_function.dart';

MovieRecommendation movieRecommendationFromJson(String str) => MovieRecommendation.fromJson(json.decode(str));

String movieRecommendationToJson(MovieRecommendation data) => json.encode(data.toJson());

class MovieRecommendation implements Decodable<MovieRecommendation> {
  MovieRecommendation({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  List<MovieRecommendationResult>? results;
  int? totalPages;
  int? totalResults;

  factory MovieRecommendation.fromJson(Map<String, dynamic> json) => MovieRecommendation(
    page: json["page"],
    results: List<MovieRecommendationResult>.from(json["results"].map((x) => MovieRecommendationResult.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results!.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };

  @override
  MovieRecommendation decode(json) {
    page= json["page"];
    results= List<MovieRecommendationResult>
        .from(json["results"].map((x) => MovieRecommendationResult.fromJson(x)));
    totalPages= json["total_pages"];
    totalResults= json["total_results"];
    return this;
    // TODO: implement decode
  }
}

class MovieRecommendationResult {
  MovieRecommendationResult({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.mediaType,
    this.title,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  MediaType? mediaType;
  String? title;
  OriginalLanguage? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  bool? video;
  double? voteAverage;
  int? voteCount;

  factory MovieRecommendationResult.fromJson(Map<String, dynamic> json) => MovieRecommendationResult(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    //mediaType: mediaTypeValues.map[json["media_type"]],
    title: json["title"],
    //originalLanguage: originalLanguageValues.map[json["original_language"]],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"].toDouble(),
    posterPath: json["poster_path"],
    releaseDate: json["release_date"],
    video: json["video"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
    "id": id,
    "media_type": mediaTypeValues.reverse[mediaType],
    "title": title,
    "original_language": originalLanguageValues.reverse[originalLanguage],
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": releaseDate,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}


final mediaTypeValues = EnumValues({
  "movie": MediaType.MOVIE
});

// ignore: constant_identifier_names
enum OriginalLanguage { EN, FR, ES, KO }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES,
  "fr": OriginalLanguage.FR,
  "ko": OriginalLanguage.KO
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map?.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
