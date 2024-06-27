// ignore_for_file: unnecessary_null_comparison

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:nuvibe/core/notifiers/songs_provider.dart';
import 'package:nuvibe/core/services/song_handler.dart';
import 'package:nuvibe/core/utils/formatted_title.dart';
import 'package:nuvibe/presentation/global%20widgets/player_deck.dart';
import 'package:nuvibe/presentation/global%20widgets/song_item.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final SongHandler songHandler;
  const SearchScreen({Key? key, required this.songHandler}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<MediaItem> _result = [];
  final TextEditingController _textEditingController = TextEditingController();
  bool _isSearching = false;

  void _search({required String value, required List<MediaItem> songs}) {
    _result.clear();
    if (value.trim().isEmpty) {
      setState(() {
        _isSearching = false;
      });
      return;
    }

    for (var song in songs) {
      if (song.artist == null || song.title == null) {
        // Skip songs without artist or title information
        continue;
      }

      bool containsTitle = song.title!
          .toLowerCase()
          .replaceAll(" ", "")
          .contains(value.toLowerCase().replaceAll(" ", ""));
      bool containsArtist = song.artist!
          .toLowerCase()
          .replaceAll(" ", "")
          .contains(value.toLowerCase().replaceAll(" ", ""));

      if (containsTitle || containsArtist) {
        bool contains = _result.any((element) => element.id == song.id);
        if (!contains) {
          setState(() {
            _result.add(song);
          });
        }
      }
    }

    setState(() {
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongsProvider>(
      builder: (context, ref, child) {
        List<MediaItem> songs = ref.songs;
        return Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
              ),
              onChanged: (value) {
                if (value.trim().isEmpty) {
                  setState(() {
                    _result.clear();
                    _isSearching = false;
                  });
                  return;
                }

                setState(() {
                  _isSearching = true;
                });

                // Debounce search input
                Future.delayed(const Duration(milliseconds: 300), () {
                  if (value == _textEditingController.text.trim()) {
                    _search(value: value, songs: songs);
                  }
                });
              },
            ),
            actions: [
              if (_textEditingController.text.trim().isNotEmpty)
                IconButton(
                  onPressed: () {
                    setState(() {
                      _textEditingController.clear();
                      _result.clear();
                      _isSearching = false;
                    });
                  },
                  icon: const Icon(Icons.close),
                ),
            ],
          ),
          body: _buildBody(ref),
        );
      },
    );
  }

  Widget _buildBody(SongsProvider ref) {
    if (ref.isLoading) {
      return _buildLoadingIndicator();
    } else if (_isSearching) {
      return _buildSearchingIndicator();
    } else if (ref.songs.isEmpty) {
      return const Center(
        child: Text("No songs!!!"),
      );
    } else if (_result.isEmpty && !_isSearching) {
      return const Center(
        child: Text("No results found."),
      );
    } else {
      return _buildSongList(ref.songs);
    }
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
      ),
    );
  }

  Widget _buildSearchingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
      ),
    );
  }

  Widget _buildSongList(List<MediaItem> songs) {
    return Stack(
      children: [
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: _result.isNotEmpty ? _result.length : songs.length,
          itemBuilder: (context, index) {
            if (_result.isNotEmpty) {
              if (index >= _result.length) {
                return SizedBox
                    .shrink(); // Return an empty widget if index is out of bounds
              }
              MediaItem song = _result[index];
              int songIndex = songs
                  .indexOf(song); // Ensure song index is from original list
              return _buildSongItem(song, songIndex);
            } else {
              if (index >= songs.length) {
                return SizedBox
                    .shrink(); // Return an empty widget if index is out of bounds
              }
              MediaItem song = songs[index];
              return _buildSongItem(song, index);
            }
          },
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PlayerDeck(
              songHandler: widget.songHandler,
              isLast: false,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSongItem(MediaItem song, int songIndex) {
    return StreamBuilder<MediaItem?>(
      stream: widget.songHandler.mediaItem.stream,
      builder: (context, snapshot) {
        MediaItem? playingSong = snapshot.data;
        return _buildRegularSongItem(song, playingSong, songIndex);
      },
    );
  }

  Widget _buildRegularSongItem(
      MediaItem song, MediaItem? playingSong, int songIndex) {
    if (song.artUri == null ||
        song.displayDescription == null ||
        song.title == null ||
        song.artist == null) {
      // Return a white colored container if any required field is null
      return Container(
        color: Colors.transparent,
        child: Center(
            // child: Text(
            //   "Song information missing",
            //   style: TextStyle(color: Colors.black),
            // ),
            ),
      );
    }

    return SongItem(
      art: song.artUri!,
      searchedWord: _textEditingController.text.trim(),
      id: int.parse(song.displayDescription!),
      isPlaying: song == playingSong,
      title: formattedTitle(song.title!),
      artist: song.artist!,
      onSongTap: () async {
        await widget.songHandler.skipToQueueItem(songIndex);
      },
      titleTextStyle: TextStyle(color: Colors.black),
      artistTextStyle: TextStyle(color: Colors.black),
    );
  }
}
