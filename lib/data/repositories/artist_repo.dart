import 'package:audio_player/data/models/artist_model.dart';
import 'package:dio/dio.dart';

class ArtistRepository {
  Dio dio = Dio();

  Future getArtist() async {
    try {
      Response response;
      List<Result> results = [];
      response = await dio.get(
          'https://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/artists?page=1');
      print("response: ${response.data}");
      ArtistModel artists = ArtistModel.fromJson(response.data);
      print('count is: ${artists.count}');
      int page = ((artists.count) / 8).ceil();
      for (int i = 1; i <= page; i++) {
        response = await dio.get(
            'https://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/artists?page=$i');
        ArtistModel artists = ArtistModel.fromJson(response.data);
        results = results..addAll(artists.results);
      }
      print('count_result is: ${results.length}');
      return results;
    } on Exception catch (e) {
      // TODO
    }
  }
}
