import 'package:flutter/material.dart';

import '../../data/models/artist_model.dart';
import '../../data/repositories/artist_repo.dart';

enum ArtistLoading { loading, loaded }

class ArtistProviders extends ChangeNotifier {
  final _artistRepository = ArtistRepository();
  // Loading
  ArtistLoading? _loading;
  ArtistLoading? get loading => _loading;
  set loading(ArtistLoading? loading) {
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
  List<Result>? _artists;
  List<Result>? get artists => _artists;
  set appointments(List<Result>? artists) {
    _artists = artists;
    notifyListeners();
  }

  Future<void> getArtistMethod() async {
    try {
      error = null;
      loading = ArtistLoading.loading;
      _artists = await _artistRepository.getArtist();
      loading = null;
    } catch (e, stacktrace) {
      debugPrintStack(stackTrace: stacktrace);
      var err = e.toString();
      error = err;
      loading = null;
    }
  }
}
