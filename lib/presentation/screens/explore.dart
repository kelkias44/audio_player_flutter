import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../data/models/album_model.dart';
import '../../data/models/artist_model.dart';
import '../../data/models/track_model.dart';
import '../providers/album_providers.dart';
import '../providers/artist_providers.dart';
import '../providers/favorite_providers.dart';
import '../providers/track_providers.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  void initState() {
    super.initState();
    context.read<AlbumProvider>().getAlbumMethod();
    context.read<ArtistProviders>().getArtistMethod();
    context.read<FavoriteProvider>().getFavoriteMethod();
    context.read<TrackProvider>().getTrackMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 15),
      child: Column(
        children: [
          Expanded(child: newAlbums()),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: newMusics()),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: newArtists())
        ],
      ),
    );
  }

  Widget newAlbums() {
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    'New Albums',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: _albums.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: MediaQuery.of(context).size.width * 0.7,
                          child: Column(children: [
                            Container(
                                clipBehavior: Clip.hardEdge,
                                width: MediaQuery.of(context).size.width * 0.7,
                                height:
                                    MediaQuery.of(context).size.width * 0.35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.network(
                                    _albums[index].albumCoverImage,
                                    fit: BoxFit.fill)),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          alignment: Alignment.topLeft,
                                          child:
                                              Text(_albums[index].albumName)),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          _albums[index].artistName,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 135, 134, 134)),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Icon(Icons.more_vert)
                                ],
                              ),
                            )
                          ]),
                        );
                      }),
                )
              ],
            );
          }
        }));
  }

  Widget newMusics() {
    return Selector<TrackProvider,
            Tuple3<TrackLoading?, String?, List<TrackResult>?>>(
        selector: (_, provider) =>
            Tuple3(provider.loading, provider.error, provider.tracks),
        builder: ((context, value, child) {
          final _error = value.item2;
          final _loading = value.item1;
          final _tracks = value.item3;
          if (_error != null) {
            return const Center(
              child: Text('There is an Error'),
            );
          } else if (_loading == AlbumLoading.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_tracks!.isEmpty) {
            return const Center(
              child: Text('There is no Track'),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Text(
                    'New Musics',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: _tracks.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 150,
                          child: Column(children: [
                            Container(
                                clipBehavior: Clip.hardEdge,
                                width:
                                    MediaQuery.of(context).size.width * 0.25 -
                                        20,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.network(
                                    _tracks[index].trackCoverImage,
                                    fit: BoxFit.fill)),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        _tracks[index].trackName,
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                      Text(
                                        _tracks[index].artistName,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 135, 134, 134),
                                            fontSize: 8),
                                      )
                                    ],
                                  ),
                                  const Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )
                          ]),
                        );
                      }),
                )
              ],
            );
          }
        }));
  }

  Widget newArtists() {
    return Selector<ArtistProviders,
            Tuple3<ArtistLoading?, String?, List<Result>?>>(
        selector: (_, provider) =>
            Tuple3(provider.loading, provider.error, provider.artists),
        builder: ((context, value, child) {
          final _error = value.item2;
          final _loading = value.item1;
          final _artists = value.item3;
          if (_error != null) {
            return const Center(
              child: Text('There is an Error'),
            );
          } else if (_loading == AlbumLoading.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_artists!.isEmpty) {
            return const Center(
              child: Text('There is no Track'),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    'New Artists',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: _artists.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    clipBehavior: Clip.hardEdge,
                                    width: MediaQuery.of(context).size.width *
                                            0.3 -
                                        20,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Image.network(
                                        _artists[index].artistProfileImage)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(_artists[index].artistName),
                              ]),
                        );
                      }),
                )
              ],
            );
          }
        }));
  }
}
