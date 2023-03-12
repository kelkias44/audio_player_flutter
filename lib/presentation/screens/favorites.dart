import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../data/models/favorite_model.dart';
import '../providers/artist_providers.dart';
import '../providers/favorite_providers.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    context.read<FavoriteProvider>().getFavoriteMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<FavoriteProvider,
            Tuple3<FavoriteLoading?, String?, List<FavoriteResult>?>>(
        selector: (_, provider) =>
            Tuple3(provider.loading, provider.error, provider.favorites),
        builder: ((context, value, child) {
          final _error = value.item2;
          final _loading = value.item1;
          final _favorites = value.item3;
          if (_error != null) {
            return const Center(
              child: Text('There is an Error'),
            );
          } else if (_loading == FavoriteLoading.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_favorites!.isEmpty) {
            return const Center(
              child: Text('There is no Favorite'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: 10, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      'Favorites List',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: _favorites.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return favoriteCard(context, _favorites[index]);
                        }),
                  )
                ],
              ),
            );
          }
        }));
  }

  Widget favoriteCard(BuildContext context, FavoriteResult favorite) {
    return InkWell(
      onTap: () {
        if (isPlaying) {
          audioPlayer.play((UrlSource(favorite.trackAudioFile)));
        } else {
          audioPlayer.pause();
        }
        isPlaying = !isPlaying;
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Container(
                  clipBehavior: Clip.hardEdge,
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: Image.network(
                    'http://${favorite.trackCoverImage}',
                    fit: BoxFit.cover,
                  )),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(favorite.trackName),
                  Text(
                    favorite.artistName,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 135, 134, 134)),
                  )
                ],
              ),
            ]),
            const Icon(
              Icons.favorite,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
