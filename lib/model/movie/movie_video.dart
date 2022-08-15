// To parse this JSON local_data, do
//
//     final movieVideo = movieVideoFromJson(jsonString);

import 'dart:convert';

import 'package:ex6/api/decodable.dart';

VideoTrailer movieVideoFromJson(String str) => VideoTrailer.fromJson(json.decode(str));

String movieVideoToJson(VideoTrailer data) => json.encode(data.toJson());

class VideoTrailer implements Decodable<VideoTrailer> {
  VideoTrailer({
    this.id,
    this.results,
  });

  int? id;
  List<ResultVideoTrailer>? results;

  factory VideoTrailer.fromJson(Map<String, dynamic> json) => VideoTrailer(
    id: json["id"],
    results: List<ResultVideoTrailer>.from(json["results"].map((x) => ResultVideoTrailer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  "results": List<dynamic>.from(results!.map((x) => x.toJson())),
  };

  @override
  VideoTrailer decode(json) {
    id= json["id"];
    results= List<ResultVideoTrailer>.from(json["results"].map((x) => ResultVideoTrailer.fromJson(x)));
    return this;
    // TODO: implement decode
  }
}

class ResultVideoTrailer {
  ResultVideoTrailer({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  });

  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  DateTime? publishedAt;
  String? id;

  factory ResultVideoTrailer.fromJson(Map<String, dynamic> json) => ResultVideoTrailer(
    iso6391: json["iso_639_1"],
    iso31661: json["iso_3166_1"],
    name: json["name"],
    key: json["key"],
    site: json["site"],
    size: json["size"],
    type: json["type"],
    official: json["official"],
    publishedAt: DateTime.parse(json["published_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "iso_639_1": iso6391,
    "iso_3166_1": iso31661,
    "name": name,
    "key": key,
    "site": site,
    "size": size,
    "type": type,
    "official": official,
    "published_at": publishedAt!.toIso8601String(),
    "id": id,
  };
}
