import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:provider/provider.dart';
import 'package:nuvibe/core/services/song_handler.dart';

class FavoriteSongsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final songHandler = Provider.of<SongHandler>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text('Favorite Songs', style: TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder<List<MediaItem>>(
        stream: songHandler.favoriteSongsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text(
              'No favorite songs',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ));
          }

          final favoriteSongs = snapshot.data!;

          return ListView.builder(
            itemCount: favoriteSongs.length,
            itemBuilder: (context, index) {
              final song = favoriteSongs[index];
              return ListTile(
                title: Text(song.title),
                subtitle: Text(
                  song.artist ?? 'Unknown Artist',
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
                onTap: () {
                  songHandler.skipToQueueItem(index);
                },
              );
            },
          );
        },
      ),
    );
  }
}
