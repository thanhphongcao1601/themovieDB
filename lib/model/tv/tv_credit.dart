// To parse this JSON local_data, do
//
//     final tvCredit = tvCreditFromJson(jsonString);

import 'dart:convert';

import 'package:ex6/api/decodable.dart';

TvCredit tvCreditFromJson(String str) => TvCredit.fromJson(json.decode(str));

String tvCreditToJson(TvCredit data) => json.encode(data.toJson());

class TvCredit implements Decodable<TvCredit> {
  TvCredit({
    this.cast,
    this.crew,
    this.id,
  });

  List<TvCastAndCrew>? cast;
  List<TvCastAndCrew>? crew;
  int? id;

  factory TvCredit.fromJson(Map<String, dynamic> json) => TvCredit(
        cast: List<TvCastAndCrew>.from(
            json["cast"].map((x) => TvCastAndCrew.fromJson(x))),
        crew: List<TvCastAndCrew>.from(
            json["crew"].map((x) => TvCastAndCrew.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "cast": List<dynamic>.from(cast!.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew!.map((x) => x.toJson())),
        "id": id,
      };

  @override
  TvCredit decode(json) {
    cast = List<TvCastAndCrew>.from(
        json["cast"].map((x) => TvCastAndCrew.fromJson(x)));
    crew = List<TvCastAndCrew>.from(
        json["crew"].map((x) => TvCastAndCrew.fromJson(x)));
    id = json["id"];
    return this;
  }
}

class TvCastAndCrew {
  TvCastAndCrew({
    this.adult,
    this.gender,
    required this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  bool? adult;
  int? gender;
  int id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  String? character;
  String? creditId;
  int? order;
  String? department;
  String? job;

  factory TvCastAndCrew.fromJson(Map<String, dynamic> json) => TvCastAndCrew(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["department"],
        job: json["job"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "character": character,
        "credit_id": creditId,
        "order": order,
        "department": department,
        "job": job,
      };
}
