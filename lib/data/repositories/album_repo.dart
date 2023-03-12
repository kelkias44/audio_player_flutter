import 'package:dio/dio.dart';

import '../models/album_model.dart';

class AlbumRepository {
  Dio dio = Dio();

  Future getAlbum() async {
    try {
      Response response;
      List<AlbumResult> results = [];
      response = await dio.get(
          'http://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/albums?page=1');
      AlbumModel albums = AlbumModel.fromJson(response.data);
      print('count is: ${albums.count}');
      int page = ((albums.count) / 8).ceil();
      for (int i = 1; i <= page; i++) {
        response = await dio.get(
            'http://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/albums?page=$i');
        AlbumModel albums = AlbumModel.fromJson(response.data);
        results = results..addAll(albums.results);
      }
      print('count_result is: ${results.length}');
      return results;
    } on Exception catch (e) {
      // TODO
    }
  }
}
