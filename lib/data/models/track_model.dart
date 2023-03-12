import 'dart:convert';

TrackModel trackModelFromJson(String str) =>
    TrackModel.fromJson(json.decode(str));

String trackModelToJson(TrackModel data) => json.encode(data.toJson());

class TrackModel {
  TrackModel({
    required this.count,
    required this.next,
    this.previous,
    required this.results,
  });

  int count;
  String? next;
  dynamic previous;
  List<TrackResult> results;

  factory TrackModel.fromJson(Map<String, dynamic> json) => TrackModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<TrackResult>.from(
            json["results"].map((x) => TrackResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class TrackResult {
  TrackResult({
    required this.id,
    required this.trackName,
    required this.trackDescription,
    required this.trackCoverImage,
    required this.trackAudioFile,
    required this.artistName,
    required this.albumName,
    required this.genreName,
  });

  int id;
  String trackName;
  String trackDescription;
  String trackCoverImage;
  String trackAudioFile;
  String artistName;
  String albumName;
  String genreName;

  factory TrackResult.fromJson(Map<String, dynamic> json) => TrackResult(
        id: json["id"],
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
        "track_name": trackName,
        "track_description": trackDescription,
        "track_coverImage": trackCoverImage,
        "track_audioFile": trackAudioFile,
        "artist_name": artistName,
        "album_name": albumName,
        "genre_name": genreName,
      };
}
