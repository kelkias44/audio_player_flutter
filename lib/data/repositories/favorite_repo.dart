import 'package:audio_player/data/models/favorite_model.dart';
import 'package:dio/dio.dart';

import '../models/album_model.dart';

class FavoriteRepository {
  Dio dio = Dio();

  Future getFavorite() async {
    try {
      Response response;
      List<FavoriteResult> results = [];
      response = await dio.get(
          'https://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/favourites');
      FavoriteModel albums = FavoriteModel.fromJson(response.data);
      print('count is: ${albums.count}');
      int page = ((albums.count) / 8).ceil();
      for (int i = 1; i <= page; i++) {
        response = await dio.get(
            'http://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/favourites?page=$i');
        FavoriteModel favorites = FavoriteModel.fromJson(response.data);
        results = results..addAll(favorites.results);
      }
      print('count_result is: ${results.length}');
      return results;
    } on Exception catch (e) {
      // TODO
    }
  }
}
