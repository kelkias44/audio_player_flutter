import 'package:flutter/material.dart';

import '../../data/models/favorite_model.dart';
import '../../data/repositories/favorite_repo.dart';

enum FavoriteLoading { loading, loaded }

class FavoriteProvider extends ChangeNotifier {
  final _favoriteRepository = FavoriteRepository();
  // Loading
  FavoriteLoading? _loading;
  FavoriteLoading? get loading => _loading;
  set loading(FavoriteLoading? loading) {
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
  List<FavoriteResult>? _favorites;
  List<FavoriteResult>? get favorites => _favorites;
  set appointments(List<FavoriteResult>? favorites) {
    _favorites = favorites;
    notifyListeners();
  }

  Future<void> getFavoriteMethod() async {
    try {
      error = null;
      loading = FavoriteLoading.loading;
      _favorites = await _favoriteRepository.getFavorite();
      loading = null;
    } catch (e, stacktrace) {
      debugPrintStack(stackTrace: stacktrace);
      var err = e.toString();
      error = err;
      loading = null;
    }
  }
}
