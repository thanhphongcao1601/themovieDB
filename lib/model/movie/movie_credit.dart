// To parse this JSON local_data, do
//
//     final movieCredit = movieCreditFromJson(jsonString);

import 'dart:convert';

import 'package:ex6/api/decodable.dart';

MovieCredit movieCreditFromJson(String str) => MovieCredit.fromJson(json.decode(str));

String movieCreditToJson(MovieCredit data) => json.encode(data.toJson());

class MovieCredit  implements Decodable<MovieCredit> {
  MovieCredit({
    this.id,
    this.cast,
    this.crew,
  });

  int? id;
  List<MovieCastAndCrew>? cast;
  List<MovieCastAndCrew>? crew;

  factory MovieCredit.fromJson(Map<String, dynamic> json) => MovieCredit(
    id: json["id"],
    cast: List<MovieCastAndCrew>.from(json["cast"].map((x) => MovieCastAndCrew.fromJson(x))),
    crew: List<MovieCastAndCrew>.from(json["crew"].map((x) => MovieCastAndCrew.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cast": List<dynamic>.from(cast!.map((x) => x.toJson())),
    "crew": List<dynamic>.from(crew!.map((x) => x.toJson())),
  };

  @override
  MovieCredit decode(json) {
    id= json["id"];
    cast= List<MovieCastAndCrew>.from(json["cast"].map((x) => MovieCastAndCrew.fromJson(x)));
    crew= List<MovieCastAndCrew>.from(json["crew"].map((x) => MovieCastAndCrew.fromJson(x)));
    return this;
    // TODO: implement decode
  }
}

class MovieCastAndCrew{
  MovieCastAndCrew({
    this.adult,
    this.gender,
    required this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  bool? adult;
  int? gender;
  int id;
  Department? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;
  Department? department;
  String? job;

  factory MovieCastAndCrew.fromJson(Map<String, dynamic> json) => MovieCastAndCrew(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    knownForDepartment: departmentValues.map![json["known_for_department"]],
    name: json["name"],
    originalName: json["original_name"],
    popularity: json["popularity"].toDouble(),
    profilePath: json["profile_path"],
    castId: json["cast_id"],
    character: json["character"],
    creditId: json["credit_id"],
    order: json["order"],
    department: json["department"] == null ? null : departmentValues.map![json["department"]],
    job: json["job"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": departmentValues.reverse[knownForDepartment],
    "name": name,
    "original_name": originalName,
    "popularity": popularity,
    "profile_path": profilePath,
    "cast_id": castId,
    "character": character,
    "credit_id": creditId,
    "order": order,
    "department": department == null ? null : departmentValues.reverse[department],
    "job": job,
  };

  @override
  MovieCastAndCrew decode(json) {
    adult= json["adult"];
    gender= json["gender"];
    id= json["id"];
    departmentValues.map![json["known_for_department"]];
    name= json["name"];
    originalName= json["original_name"];
    popularity= json["popularity"].toDouble();
    profilePath= json["profile_path"];
    castId= json["cast_id"];
    character= json["character"];
    creditId= json["credit_id"];
    order= json["order"];
    department= json["department"] == null ? null : departmentValues.map![json["department"]];
    job= json["job"];
    return this;
  }
}

// ignore: constant_identifier_names
enum Department { ACTING, WRITING, CREW, VISUAL_EFFECTS, DIRECTING, PRODUCTION, COSTUME_MAKE_UP, ART, SOUND, CAMERA, EDITING, LIGHTING }

final departmentValues = EnumValues({
  "Acting": Department.ACTING,
  "Art": Department.ART,
  "Camera": Department.CAMERA,
  "Costume & Make-Up": Department.COSTUME_MAKE_UP,
  "Crew": Department.CREW,
  "Directing": Department.DIRECTING,
  "Editing": Department.EDITING,
  "Lighting": Department.LIGHTING,
  "Production": Department.PRODUCTION,
  "Sound": Department.SOUND,
  "Visual Effects": Department.VISUAL_EFFECTS,
  "Writing": Department.WRITING
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
