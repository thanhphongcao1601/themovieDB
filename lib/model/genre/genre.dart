import 'dart:convert';

import 'package:ex6/api/decodable.dart';

GenreList genreFromJson(String str) => GenreList.fromJson(json.decode(str));

String genreToJson(GenreList data) => json.encode(data.toJson());

class GenreList implements Decodable<GenreList>{
  GenreList({
    this.genres,
  });

  List<GenreElement>? genres;

  factory GenreList.fromJson(Map<String, dynamic> json) => GenreList(
    genres: List<GenreElement>.from(json["genres"].map((x) => GenreElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "genres": List<dynamic>.from(genres!.map((x) => x.toJson())),
  };

  @override
  GenreList decode(json) {
    genres= List<GenreElement>.from(json["genres"].map((x) => GenreElement.fromJson(x)));
    return this;
  }
}

class GenreElement {
  GenreElement({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory GenreElement.fromJson(Map<String, dynamic> json) => GenreElement(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
