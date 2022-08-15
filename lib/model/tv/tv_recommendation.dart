import 'dart:convert';
import 'package:ex6/api/decodable.dart';

TvRecommendation tvRecommendationResultFromJson(String str) => TvRecommendation.fromJson(json.decode(str));

String tvRecommendationResultToJson(TvRecommendation data) => json.encode(data.toJson());

class TvRecommendation implements Decodable<TvRecommendation>{
  TvRecommendation({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  List<TvRecommendationResult>? results;
  int? totalPages;
  int? totalResults;

  factory TvRecommendation.fromJson(Map<String, dynamic> json) => TvRecommendation(
    page: json["page"],
    results: List<TvRecommendationResult>.from(json["results"].map((x) => TvRecommendationResult.fromJson(x))),
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
  TvRecommendation decode(json) {
    page= json["page"];
    results= List<TvRecommendationResult>
        .from(json["results"].map((x) => TvRecommendationResult.fromJson(x)));
    totalPages= json["total_pages"];
    totalResults= json["total_results"];
    return this;
    // TODO: implement decode
  }
}

class TvRecommendationResult {
  TvRecommendationResult({
    this.backdropPath,
    this.firstAirDate,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.originCountry,
    this.posterPath,
    this.popularity,
    this.name,
    this.voteAverage,
    this.voteCount,
  });

  String? backdropPath;
  DateTime? firstAirDate;
  List<int>? genreIds;
  int? id;
  OriginalLanguage? originalLanguage;
  String? originalName;
  String? overview;
  List<OriginCountry>? originCountry;
  String? posterPath;
  double? popularity;
  String? name;
  double? voteAverage;
  int? voteCount;

  factory TvRecommendationResult.fromJson(Map<String, dynamic> json) => TvRecommendationResult(
    backdropPath: json["backdrop_path"],
    firstAirDate: DateTime.parse(json["first_air_date"]),
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    originalLanguage: originalLanguageValues.map![json["original_language"]],
    originalName: json["original_name"],
    overview: json["overview"],
    //originCountry: List<OriginCountry>.from(json["origin_country"].map((x) => originCountryValues.map![x])),
    posterPath: json["poster_path"],
    popularity: json["popularity"].toDouble(),
    name: json["name"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "first_air_date": "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
    "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
    "id": id,
    "original_language": originalLanguageValues.reverse[originalLanguage],
    "original_name": originalName,
    "overview": overview,
    "origin_country": List<dynamic>.from(originCountry!.map((x) => originCountryValues.reverse[x])),
    "poster_path": posterPath,
    "popularity": popularity,
    "name": name,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

enum OriginCountry { US, GB }

final originCountryValues = EnumValues({
  "GB": OriginCountry.GB,
  "US": OriginCountry.US
});

enum OriginalLanguage { EN }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}