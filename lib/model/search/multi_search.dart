import 'dart:convert';
import 'package:ex6/api/decodable.dart';
import '../../helper/helper_function.dart';

MultiSearch multiSearchFromJson(String str) =>
    MultiSearch.fromJson(json.decode(str));

String multiSearchToJson(MultiSearch data) => json.encode(data.toJson());

class MultiSearch implements Decodable<MultiSearch>{
  MultiSearch({
    this.page,
    this.results,
    this.totalResults,
    this.totalPages,
  });

  int? page;
  List<SearchResult>? results;
  int? totalResults;
  int? totalPages;

  factory MultiSearch.fromJson(Map<String, dynamic> json) => MultiSearch(
        page: json["page"],
        results:
            List<SearchResult>.from(json["results"].map((x) => SearchResult.fromJson(x))),
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
  MultiSearch decode(json) {
    page= json["page"];
    results=
    List<SearchResult>.from(json["results"].map((x) => SearchResult.fromJson(x)));
    totalResults= json["total_results"];
    totalPages= json["total_pages"];
    return this;
    // TODO: implement decode
  }
}

class SearchResult {
  SearchResult({
    this.posterPath,
    this.popularity,
    this.id,
    this.overview,
    this.backdropPath,
    this.voteAverage,
    required this.mediaType,
    this.firstAirDate,
    this.originCountry,
    this.genreIds,
    this.originalLanguage,
    this.voteCount,
    this.name,
    this.originalName,
    this.adult,
    this.releaseDate,
    this.originalTitle,
    this.title,
    this.video,
    this.profilePath,
    this.knownFor,
  });

  String? posterPath;
  double? popularity;
  int? id;
  String? overview;
  String? backdropPath;
  double? voteAverage;
  MediaType mediaType;
  String? firstAirDate;
  List<String>? originCountry;
  List<int>? genreIds;
  OriginalLanguage? originalLanguage;
  int? voteCount;
  String? name;
  String? originalName;
  bool? adult;
  DateTime? releaseDate;
  String? originalTitle;
  String? title;
  bool? video;
  String? profilePath;
  List<SearchResult>? knownFor;

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        posterPath: json["poster_path"],
        popularity: json["popularity"]!= null ? json["popularity"].toDouble() : 0,
        id: json["id"],
        overview: json["overview"],
        backdropPath: json["backdrop_path"],
        mediaType: mediaTypeValues.map![json["media_type"]]!,
        firstAirDate:
            json["first_air_date"],
        originCountry: json["origin_country"] == null
            ? null
            : List<String>.from(json["origin_country"].map((x) => x)),
        genreIds: json["genre_ids"] == null
            ? null
            : List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: json["original_language"] == null
            ? null
            : originalLanguageValues.map![json["original_language"]],
        voteCount: json["vote_count"],
        name: json["name"],
        originalName:
            json["original_name"],
        adult: json["adult"],
        releaseDate: json["release_date"] == null || json["release_date"] ==""
            ? null
            : DateTime.parse(json["release_date"]),
        originalTitle:
            json["original_title"],
        title: json["title"],
        video: json["video"],
        profilePath: json["profile_path"],
        knownFor: json["known_for"] == null
            ? null
            : List<SearchResult>.from(
                json["known_for"].map((x) => SearchResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "popularity": popularity,
        "id": id,
        "overview": overview,
        "backdrop_path": backdropPath,
        "vote_average": voteAverage,
        "media_type": mediaTypeValues.reverse[mediaType],
        "first_air_date": firstAirDate,
        "origin_country": originCountry == null
            ? null
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "genre_ids": genreIds == null
            ? null
            : List<dynamic>.from(genreIds!.map((x) => x)),
        "original_language": originalLanguage == null
            ? null
            : originalLanguageValues.reverse[originalLanguage],
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
        "adult": adult,
        "release_date": releaseDate == null
            ? null
            : "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "original_title": originalTitle,
        "title": title,
        "video": video,
        "profile_path": profilePath,
        "known_for": knownFor == null
            ? null
            : List<dynamic>.from(knownFor!.map((x) => x.toJson())),
      };
}

final mediaTypeValues = EnumValues(
    {"movie": MediaType.MOVIE, "person": MediaType.PERSON, "tv": MediaType.TV});

// ignore: constant_identifier_names
enum OriginalLanguage { EN, IT }

final originalLanguageValues =
    EnumValues({"en": OriginalLanguage.EN, "it": OriginalLanguage.IT});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
