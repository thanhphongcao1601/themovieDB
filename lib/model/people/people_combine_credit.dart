// To parse this JSON local_data, do
//
//     final peopleCombineCredit = peopleCombineCreditFromJson(jsonString);

import 'dart:convert';

import 'package:ex6/api/decodable.dart';
import 'package:ex6/helper/helper_function.dart';

PeopleCombineCredit peopleCombineCreditFromJson(String str) =>
    PeopleCombineCredit.fromJson(json.decode(str));

String peopleCombineCreditToJson(PeopleCombineCredit data) =>
    json.encode(data.toJson());

class PeopleCombineCredit implements Decodable<PeopleCombineCredit>{
  PeopleCombineCredit({
    this.cast,
    this.crew,
    this.id,
  });

  List<PeopleCastAndCrew>? cast;
  List<PeopleCastAndCrew>? crew;
  int? id;

  factory PeopleCombineCredit.fromJson(Map<String, dynamic> json) =>
      PeopleCombineCredit(
        cast: List<PeopleCastAndCrew>.from(
            json["cast"].map((x) => PeopleCastAndCrew.fromJson(x))),
        crew: List<PeopleCastAndCrew>.from(
            json["crew"].map((x) => PeopleCastAndCrew.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "cast": List<dynamic>.from(cast!.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew!.map((x) => x.toJson())),
        "id": id,
      };

  @override
  PeopleCombineCredit decode(json) {
    cast= List<PeopleCastAndCrew>.from(
        json["cast"].map((x) => PeopleCastAndCrew.fromJson(x)));
    crew= List<PeopleCastAndCrew>.from(
    json["crew"].map((x) => PeopleCastAndCrew.fromJson(x)));
    id= json["id"];
    return this;
    // TODO: implement decode
  }
}

class PeopleCastAndCrew {
  PeopleCastAndCrew({
    required this.id,
    this.originalLanguage,
    this.episodeCount,
    this.overview,
    this.originCountry,
    this.originalName,
    this.genreIds,
    this.name,
    required this.mediaType,
    this.posterPath,
    this.firstAirDate,
    this.voteAverage,
    this.voteCount,
    this.character,
    this.backdropPath,
    this.popularity,
    this.creditId,
    this.originalTitle,
    this.video,
    this.releaseDate,
    this.title,
    this.adult,
    this.department,
    this.job,
  });

  int id;
  OriginalLanguage? originalLanguage;
  int? episodeCount;
  String? overview;
  List<String>? originCountry;
  String? originalName;
  List<int>? genreIds;
  String? name;
  MediaType? mediaType;
  String? posterPath;
  DateTime? firstAirDate;
  double? voteAverage;
  int? voteCount;
  String? character;
  String? backdropPath;
  double? popularity;
  String? creditId;
  String? originalTitle;
  bool? video;
  DateTime? releaseDate;
  String? title;
  bool? adult;
  String? department;
  String? job;

  factory PeopleCastAndCrew.fromJson(Map<String, dynamic> json) =>
      PeopleCastAndCrew(
        id: json["id"],
        originalLanguage:
            originalLanguageValues.map![json["original_language"]],
        episodeCount: json["episode_count"],
        overview: json["overview"],
        originCountry: json["origin_country"] == null
            ? null
            : List<String>.from(json["origin_country"].map((x) => x)),
        originalName: json["original_name"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        name: json["name"],
        mediaType: mediaTypeValues.map![json["media_type"]],
        posterPath: json["poster_path"],
        firstAirDate:
            json["first_air_date"] == null || json["first_air_date"] == ""
                ? null
                : DateTime.parse(json["first_air_date"]),
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        character: json["character"],
        backdropPath: json["backdrop_path"],
        popularity:
        json["popularity"] != null ? json["popularity"].toDouble() : null,
        creditId: json["credit_id"],
        originalTitle: json["original_title"],
        video: json["video"],
        releaseDate: json["release_date"] == null || json["release_date"] == ""
            ? null
            : DateTime.parse(json["release_date"]),
        title: json["title"],
        adult: json["adult"],
        department: json["department"],
        job: json["job"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "episode_count": episodeCount,
        "overview": overview,
        "origin_country": originCountry == null
            ? null
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "original_name": originalName,
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "name": name,
        "media_type": mediaTypeValues.reverse[mediaType],
        "poster_path": posterPath,
        "first_air_date": firstAirDate == null
            ? null
            : "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "character": character,
        "backdrop_path": backdropPath,
        "popularity": popularity,
        "credit_id": creditId,
        "original_title": originalTitle,
        "video": video,
        "release_date": releaseDate == null
            ? null
            : "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "title": title,
        "adult": adult,
        "department":
            department == null ? null : departmentValues.reverse[department],
        "job": job == null ? null : jobValues.reverse[job],
      };
}

enum Department { PRODUCTION }

final departmentValues = EnumValues({"Production": Department.PRODUCTION});

enum Job { EXECUTIVE_PRODUCER, PRODUCER }

final jobValues = EnumValues(
    {"Executive Producer": Job.EXECUTIVE_PRODUCER, "Producer": Job.PRODUCER});

final mediaTypeValues =
    EnumValues({"movie": MediaType.MOVIE, "tv": MediaType.TV});

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
