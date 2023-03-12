import 'dart:convert';

FavoriteModel favoriteModelFromJson(String str) =>
    FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

class FavoriteModel {
  FavoriteModel({
    required this.count,
    required this.next,
    this.previous,
    required this.results,
  });

  int count;
  String? next;
  dynamic previous;
  List<FavoriteResult> results;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<FavoriteResult>.from(
            json["results"].map((x) => FavoriteResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class FavoriteResult {
  FavoriteResult({
    required this.id,
    required this.userFui,
    required this.trackName,
    required this.trackDescription,
    required this.trackCoverImage,
    required this.trackAudioFile,
    required this.artistName,
    required this.albumName,
    required this.genreName,
  });

  int id;
  String userFui;
  String trackName;
  String trackDescription;
  String trackCoverImage;
  String trackAudioFile;
  String artistName;
  String albumName;
  String genreName;

  factory FavoriteResult.fromJson(Map<String, dynamic> json) => FavoriteResult(
        id: json["id"],
        userFui: json["user_FUI"],
        trackName: json["track_name"],
        trackDescription: json["track_description"],
        trackCoverImage: json["track_coverImage"],
        trackAudioFile: json["track_audioFile"],
        artistName: json["artist_name"],
        albumName: json["album_name"],
        genreName: json["genre_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_FUI": userFui,
        "track_name": trackName,
        "track_description": trackDescription,
        "track_coverImage": trackCoverImage,
        "track_audioFile": trackAudioFile,
        "artist_name": artistName,
        "album_name": albumName,
        "genre_name": genreName,
      };
}
