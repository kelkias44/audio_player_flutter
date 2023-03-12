import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/models/track_model.dart';
import '../../data/repositories/track_repo.dart';

enum TrackLoading { loading, loaded }

class TrackProvider extends ChangeNotifier {
  final _trackRepository = TrackRepository();
  // Loading
  TrackLoading? _loading;
  TrackLoading? get loading => _loading;
  set loading(TrackLoading? loading) {
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
  List<TrackResult>? _tracks;
  List<TrackResult>? get tracks => _tracks;
  set appointments(List<TrackResult>? tracks) {
    _tracks = tracks;
    notifyListeners();
  }

  Future<void> getTrackMethod() async {
    try {
      error = null;
      loading = TrackLoading.loading;
      _tracks = await _trackRepository.getTrack();
      // print("tracks in provider: ${_tracks.length}");
      loading = null;
    } catch (e, stacktrace) {
      debugPrintStack(stackTrace: stacktrace);
      var err = e.toString();
      error = err;
      loading = null;
    }
  }
}
