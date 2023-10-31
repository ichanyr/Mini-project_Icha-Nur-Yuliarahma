import 'dart:convert';

class MovieVideosModel {
  final int id;
  final List<Result> results;

  MovieVideosModel({
    required this.id,
    required this.results,
  });

  factory MovieVideosModel.fromRawJson(String str) =>
      MovieVideosModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieVideosModel.fromJson(Map<String, dynamic> json) =>
      MovieVideosModel(
        id: json["id"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  final Iso6391 iso6391;
  final Iso31661 iso31661;
  final String name;
  final String key;
  final DateTime publishedAt;
  final Site site;
  final int size;
  final Type type;
  final bool official;
  final String id;

  Result({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.publishedAt,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.id,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        iso6391: iso6391Values.map[json["iso_639_1"]]!,
        iso31661: iso31661Values.map[json["iso_3166_1"]]!,
        name: json["name"],
        key: json["key"],
        publishedAt: DateTime.parse(json["published_at"]),
        site: siteValues.map[json["site"]]!,
        size: json["size"],
        type: typeValues.map[json["type"]]!,
        official: json["official"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391Values.reverse[iso6391],
        "iso_3166_1": iso31661Values.reverse[iso31661],
        "name": name,
        "key": key,
        "published_at": publishedAt.toIso8601String(),
        "site": siteValues.reverse[site],
        "size": size,
        "type": typeValues.reverse[type],
        "official": official,
        "id": id,
      };
}

enum Iso31661 { US }

final iso31661Values = EnumValues({"US": Iso31661.US});

enum Iso6391 { EN }

final iso6391Values = EnumValues({"en": Iso6391.EN});

enum Site { YOU_TUBE }

final siteValues = EnumValues({"YouTube": Site.YOU_TUBE});

enum Type { FEATURETTE, TEASER, TRAILER }

final typeValues = EnumValues({
  "Featurette": Type.FEATURETTE,
  "Teaser": Type.TEASER,
  "Trailer": Type.TRAILER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
