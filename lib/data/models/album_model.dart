import 'dart:convert';

AlbumModel albumModelFromJson(String str) =>
    AlbumModel.fromJson(json.decode(str));

String albumModelToJson(AlbumModel data) => json.encode(data.toJson());

class AlbumModel {
  AlbumModel({
    required this.count,
    required this.next,
    this.previous,
    required this.results,
  });

  int count;
  String? next;
  dynamic previous;
  List<AlbumResult> results;

  factory AlbumModel.fromJson(Map<String, dynamic> json) => AlbumModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<AlbumResult>.from(
            json["results"].map((x) => AlbumResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class AlbumResult {
  AlbumResult({
    required this.id,
    required this.albumName,
    required this.albumDescription,
    required this.albumCoverImage,
    required this.artistName,
  });

  int id;
  String albumName;
  String albumDescription;
  String albumCoverImage;
  String artistName;

  factory AlbumResult.fromJson(Map<String, dynamic> json) => AlbumResult(
        id: json["id"],
        albumName: json["album_name"],
        albumDescription: json["album_description"],
        albumCoverImage: json["album_coverImage"],
        artistName: json["artist_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "album_name": albumName,
        "album_description": albumDescription,
        "album_coverImage": albumCoverImage,
        "artist_name": artistName,
      };
}
