// ignore_for_file: prefer_const_constructors

import 'package:audio_service/audio_service.dart';
import 'package:nuvibe/core/notifiers/songs_provider.dart';
import 'package:nuvibe/core/services/song_handler.dart';
import 'package:nuvibe/presentation/global%20widgets/player_deck.dart';
import 'package:nuvibe/presentation/global%20widgets/song_item.dart';
import 'package:nuvibe/presentation/player_screen.dart';
import 'package:nuvibe/core/utils/formatted_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class SearchScreen extends StatefulWidget {
  final SongHandler songHandler;
  const SearchScreen({Key? key, required this.songHandler}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final AutoScrollController _autoScrollController = AutoScrollController();
  // The result list to store filtered songs
  final List<MediaItem> _result = [];
  // Controller for the search input field
  final TextEditingController _textEditingController = TextEditingController();

  void _scrollTo(int index) {
    _autoScrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
      duration: const Duration(milliseconds: 800),
    );
  }

  // Function to search for songs based on the input value
  void _search({required String value, required List<MediaItem> songs}) {
    for (var song in songs) {
      // Check if the title or artist of the song contains the search value
      bool containsTitle = song.title
          .toLowerCase()
          .replaceAll(" ", "")
          .contains(value.toLowerCase().replaceAll(" ", ""));
      bool containsArtist = song.artist
              ?.toLowerCase()
              .replaceAll(" ", "")
              .contains(value.toLowerCase().replaceAll(" ", "")) ??
          false;

      // If the song matches the search criteria and is not already in the result list, add it
      if (containsTitle || containsArtist) {
        bool contains = _result.any((element) => element.id == song.id);
        if (!contains) {
          setState(() {
            _result.add(song);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongsProvider>(
      builder: (context, ref, child) {
        List<MediaItem> songs = ref.songs;
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            backgroundColor: Colors.black,
            title: TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.white54),
              ),
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                // Clear the result list and perform a new search when the input changes
                setState(() {
                  _result.clear();
                });
                _search(value: value, songs: songs);
              },
            ),
            actions: [
              // Display a close button if the search input is not empty
              if (_textEditingController.text.trim().isNotEmpty)
                IconButton(
                  onPressed: () {
                    // Clear the search input and result list
                    setState(() {
                      _textEditingController.clear();
                      _result.clear();
                    });
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
          body: _buildBody(ref),
        );
      },
    );
  }

  // Function to build the body of the screen based on the state of the SongsProvider
  Widget _buildBody(SongsProvider ref) {
    if (ref.isLoading) {
      // Display a loading indicator if songs are still loading
      return _buildLoadingIndicator();
    } else if (ref.songs.isEmpty) {
      // Display a message if there are no songs
      return const Center(
        child: Text(
          "No songs!!!",
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      // Display the search result or the full song list
      return _buildSongList(ref.songs);
    }
  }

  // Function to build the loading indicator widget
  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  // Function to build the song list widget
  Widget _buildSongList(List<MediaItem> songs) {
    return Stack(
      children: [
        // Display the list of songs
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: _result.isNotEmpty ? _result.length : songs.length,
          itemBuilder: (context, index) {
            // Determine the current song based on whether there is a search result
            MediaItem song = _result.isNotEmpty ? _result[index] : songs[index];
            int songIndex = songs.indexOf(song);

            // Build the appropriate song item based on its position in the list
            return StreamBuilder<MediaItem?>(
              stream: widget.songHandler.mediaItem.stream,
              builder: (context, snapshot) {
                MediaItem? playingSong = snapshot.data;
                return index ==
                        (_result.isNotEmpty
                            ? _result.length - 1
                            : songs.length - 1)
                    ? _buildLastSongItem(song, playingSong, songIndex)
                    : _buildRegularSongItem(song, playingSong, songIndex);
              },
            );
          },
        ),
        // Display the player deck at the bottom
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

  // Function to build the last song item in the list
  Widget _buildLastSongItem(MediaItem song, MediaItem? playingSong, int index) {
    int id = int.tryParse(song.displayDescription ?? "") ?? 0;

    return Column(
      children: [
        // Display the song item
        SongItem(
          art: song.artUri!,
          searchedWord: _textEditingController.text.trim(),
          id: id,
          isPlaying: song == playingSong,
          title: formattedTitle(song.title),
          artist: song.artist,
          onSongTap: () async {
            // Skip to the selected song when tapped
            await widget.songHandler.skipToQueueItem(index);
          },
          titleTextStyle: TextStyle(color: Colors.white),
          artistTextStyle: TextStyle(color: Colors.white),
        ),
        // Display the player deck for the last song
        PlayerDeck(
          songHandler: widget.songHandler,
          isLast: false,
          onTap: (index) {
            _scrollTo(index);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FullScreenPlayer(songHandler: widget.songHandler),
              ),
            );
          },
        ),
      ],
    );
  }

  // Function to build a regular song item in the list
  // Update _buildRegularSongItem method
  Widget _buildRegularSongItem(
      MediaItem song, MediaItem? playingSong, int songIndex) {
    int id = int.tryParse(song.displayDescription ?? "") ?? 0;

    return SongItem(
      art: song.artUri, // Use a default value or handle null appropriately
      searchedWord: _textEditingController.text.trim(),
      id: id,
      isPlaying: song == playingSong,
      title: formattedTitle(
          song.title), // Use a default value or handle null appropriately
      artist:
          song.artist ?? '', // Use a default value or handle null appropriately
      onSongTap: () async {
        // Skip to the selected song when tapped
        await widget.songHandler.skipToQueueItem(songIndex);
      },
      titleTextStyle: TextStyle(color: Colors.white),
      artistTextStyle: TextStyle(color: Colors.white),
    );
  }
}
