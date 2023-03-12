import 'package:audio_player/data/models/album_model.dart';
import 'package:audio_player/data/models/favorite_model.dart';
import 'package:audio_player/data/models/track_model.dart';
import 'package:audio_player/data/repositories/album_repo.dart';
import 'package:audio_player/data/repositories/artist_repo.dart';
import 'package:audio_player/data/repositories/favorite_repo.dart';
import 'package:audio_player/data/repositories/track_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../providers/album_providers.dart';

class Albums extends StatefulWidget {
  const Albums({super.key});

  @override
  State<Albums> createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  @override
  void initState() {
    super.initState();
    context.read<AlbumProvider>().getAlbumMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AlbumProvider,
        Tuple3<AlbumLoading?, String?, List<AlbumResult>?>>(
      selector: (_, provider) =>
          Tuple3(provider.loading, provider.error, provider.albums),
      builder: ((context, value, child) {
        final _error = value.item2;
        final _loading = value.item1;
        final _albums = value.item3;
        if (_error != null) {
          return const Center(
            child: Text('There is an Error'),
          );
        } else if (_loading == AlbumLoading.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (_albums!.isEmpty) {
          return const Center(
            child: Text('There is no Album'),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    'All Albums',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // childAspectRatio:
                        //     MediaQuery.of(context).size.width / (300)
                      ),
                      itemCount: _albums.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return albumCard(context, _albums[index]);
                      }),
                )
              ],
            ),
          );
        }
      }),
    );
  }

  Widget albumCard(BuildContext context, AlbumResult album) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            clipBehavior: Clip.hardEdge,
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Image.network(
              album.albumCoverImage,
              fit: BoxFit.fill,
            )),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          alignment: Alignment.topLeft,
          child: Text(
            album.albumName,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          alignment: Alignment.topLeft,
          child: Text(
            album.artistName,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ]),
    );
  }
}
