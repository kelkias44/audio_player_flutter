import 'package:audio_player/presentation/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/providers/album_providers.dart';
import 'presentation/providers/artist_providers.dart';
import 'presentation/providers/favorite_providers.dart';
import 'presentation/providers/track_providers.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => AlbumProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => ArtistProviders(),
    ),
    ChangeNotifierProvider(
      create: (_) => FavoriteProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => TrackProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'audio player',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
