import 'package:audio_player/data/models/favorite_model.dart';
import 'package:audio_player/data/models/track_model.dart';
import 'package:dio/dio.dart';

class TrackRepository {
  Dio dio = Dio();

  Future getTrack() async {
    try {
      Response response;
      List<TrackResult> results = [];
      response = await dio.get(
          'http://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/tracks');
      TrackModel tracks = TrackModel.fromJson(response.data);
      print('count is: ${tracks.count}');
      int page = ((tracks.count) / 8).ceil();
      for (int i = 1; i <= page; i++) {
        response = await dio.get(
            'http://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/tracks?page=$i');
        TrackModel tracks = TrackModel.fromJson(response.data);
        results = results..addAll(tracks.results);
      }
      print('count_result of track is: ${results.length}');
      return results;
    } on Exception catch (e) {
      // TODO
    }
  }
}
