import 'package:ex6/api/decodable.dart';

class Language implements Decodable<Language>{
  String? iso6391;
  String? englishName;
  String? name;

  Language({this.iso6391, this.englishName, this.name});

  Language.fromJson(Map<String, dynamic> json) {
    iso6391 = json['iso_639_1'];
    englishName = json['english_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iso_639_1'] = iso6391;
    data['english_name'] = englishName;
    data['name'] = name;
    return data;
  }

  @override
  Language decode(json) {
    iso6391 = json['iso_639_1'];
    englishName = json['english_name'];
    name = json['name'];
    return this;
    // TODO: implement decode
  }
}