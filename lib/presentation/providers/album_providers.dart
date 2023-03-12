import 'package:flutter/material.dart';

import '../../data/models/album_model.dart';
import '../../data/repositories/album_repo.dart';

enum AlbumLoading { loading, loaded }

class AlbumProvider extends ChangeNotifier {
  final _albumRepository = AlbumRepository();
  // Loading
  AlbumLoading? _loading;
  AlbumLoading? get loading => _loading;
  set loading(AlbumLoading? loading) {
    _loading = loading;
    notifyListeners();
  }

  // Error
  String? _error;
  String? get error => _error;
  set error(String? error) {
    _error = error;
    notifyListeners();
  }

  // apointments
  // appointments
  List<AlbumResult>? _albums;
  List<AlbumResult>? get albums => _albums;
  set appointments(List<AlbumResult>? albums) {
    _albums = albums;
    notifyListeners();
  }

  Future<void> getAlbumMethod() async {
    try {
      error = null;
      loading = AlbumLoading.loading;
      _albums = await _albumRepository.getAlbum();
      loading = null;
    } catch (e, stacktrace) {
      debugPrintStack(stackTrace: stacktrace);
      var err = e.toString();
      error = err;
      loading = null;
    }
  }
}
