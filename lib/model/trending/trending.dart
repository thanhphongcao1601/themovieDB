// To parse this JSON local_data, do
//
//     final trending = trendingFromJson(jsonString);

import 'dart:convert';
import 'package:ex6/api/decodable.dart';
import 'package:ex6/helper/helper_function.dart';

Trending trendingFromJson(String str) => Trending.fromJson(json.decode(str));

String trendingToJson(Trending data) => json.encode(data.toJson());

class Trending implements Decodable<Trending>{
  Trending({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  List<TrendingResult>? results;
  int? totalPages;
  int? totalResults;

  factory Trending.fromJson(Map<String, dynamic> json) => Trending(
        page: json["page"],
        results: List<TrendingResult>.from(
            json["results"].map((x) => TrendingResult.fromJson(x))),
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
  Trending decode(json) {
    page= json["page"];
    results= List<TrendingResult>.from(
    json["results"].map((x) => TrendingResult.fromJson(x)));
    totalPages= json["total_pages"];
    totalResults= json["total_results"];
    return this;
    // TODO: implement decode
  }
}

class TrendingResult {
  TrendingResult({
    this.title,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.video,
    this.voteAverage,
    this.overview,
    this.releaseDate,
    this.id,
    this.adult,
    this.backdropPath,
    this.voteCount,
    this.genreIds,
    this.popularity,
    this.mediaType,
    this.name,
    this.originalName,
    this.originCountry,
    this.firstAirDate,
  });

  String? title;
  OriginalLanguage? originalLanguage;
  String? originalTitle;
  String? posterPath;
  bool? video;
  double? voteAverage;
  String? overview;
  DateTime? releaseDate;
  int? id;
  bool? adult;
  String? backdropPath;
  int? voteCount;
  List<int>? genreIds;
  double? popularity;
  MediaType? mediaType;
  String? name;
  String? originalName;
  List<String>? originCountry;
  DateTime? firstAirDate;

  factory TrendingResult.fromJson(Map<String, dynamic> json) => TrendingResult(
        title: json["title"],
        originalLanguage:
            originalLanguageValues.map![json["original_language"]],
        originalTitle: json["original_title"],
        posterPath: json["poster_path"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        id: json["id"],
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        voteCount: json["vote_count"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"]?.toDouble(),
        mediaType: mediaTypeValues.map![json["media_type"]],
        name: json["name"],
        originalName: json["original_name"],
        originCountry: json["origin_country"] == null
            ? null
            : List<String>.from(json["origin_country"].map((x) => x)),
        firstAirDate: json["first_air_date"] == null
            ? null
            : DateTime.parse(json["first_air_date"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "poster_path": posterPath,
        "video": video,
        "vote_average": voteAverage,
        "overview": overview,
        "release_date": releaseDate == null
            ? null
            : "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "id": id,
        "adult": adult,
        "backdrop_path": backdropPath,
        "vote_count": voteCount,
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "popularity": popularity,
        "media_type": mediaTypeValues.reverse[mediaType],
        "name": name,
        "original_name": originalName,
        "origin_country": originCountry == null
            ? null
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "first_air_date": firstAirDate == null
            ? null
            : "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
      };
}

final mediaTypeValues =
    EnumValues({"movie": MediaType.MOVIE, "tv": MediaType.TV});

// ignore: constant_identifier_names
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
