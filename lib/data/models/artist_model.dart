import 'dart:convert';

ArtistModel artistModelFromJson(String str) =>
    ArtistModel.fromJson(json.decode(str));

String artistModelToJson(ArtistModel data) => json.encode(data.toJson());

class ArtistModel {
  ArtistModel({
    required this.count,
    required this.next,
    this.previous,
    required this.results,
  });

  int count;
  String? next;
  dynamic? previous;
  List<Result> results;

  factory ArtistModel.fromJson(Map<String, dynamic> json) => ArtistModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.id,
    required this.artistName,
    required this.artistDescription,
    required this.artistProfileImage,
  });

  int id;
  String artistName;
  String artistDescription;
  String artistProfileImage;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        artistName: json["artist_name"],
        artistDescription: json["artist_description"],
        artistProfileImage: json["artist_profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "artist_name": artistName,
        "artist_description": artistDescription,
        "artist_profileImage": artistProfileImage,
      };
}
