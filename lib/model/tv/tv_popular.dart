// To parse this JSON local_data, do
//
//     final tv = tvFromJson(jsonString);

import 'dart:convert';

import 'package:ex6/api/decodable.dart';

TvPopular tvFromJson(String str) => TvPopular.fromJson(json.decode(str));
String tvToJson(TvPopular data) => json.encode(data.toJson());

class TvPopular implements Decodable<TvPopular>{
  TvPopular({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  List<TvPopularResult>? results;
  int? totalPages;
  int? totalResults;

  factory TvPopular.fromJson(Map<String, dynamic> json) => TvPopular(
    page: json["page"],
    results: List<TvPopularResult>.from(json["results"].map((x) => TvPopularResult.fromJson(x))),
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
  TvPopular decode(json) {
    page= json["page"];
    results= List<TvPopularResult>.from(json["results"].map((x) => TvPopularResult.fromJson(x)));
    totalPages= json["total_pages"];
    totalResults= json["total_results"];
    return this;
    // TODO: implement decode
  }
}
class TvPopularResult {
  TvPopularResult({
    this.backdropPath,
    this.firstAirDate,
    this.genreIds,
    this.id,
    this.name,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
  });

  String? backdropPath;
  DateTime? firstAirDate;
  List<int>? genreIds;
  int? id;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  factory TvPopularResult.fromJson(Map<String, dynamic> json) => TvPopularResult(
    backdropPath: json["backdrop_path"],
    firstAirDate: json["first_air_date"]!=null ? DateTime.parse(json["first_air_date"]) : null,
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    name: json["name"],
    originCountry: json["origin_country"]!=null
        ? List<String>.from(json["origin_country"].map((x) => x)):null,
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"]!=null ? json["popularity"].toDouble() : null,
    posterPath: json["poster_path"],
    voteAverage: json["vote_average"]!=null? json["vote_average"].toDouble() : null,
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "first_air_date": "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
    "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
    "id": id,
    "name": name,
    "origin_country": List<dynamic>.from(originCountry!.map((x) => x)),
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}


