// import 'package:audio_service/audio_service.dart';
// import 'package:nuvibe/services/song_handler.dart';
// import 'package:flutter/material.dart';

// // PlayPauseButton class responsible for displaying a play/pause button
// class PlayPauseButton extends StatelessWidget {
//   // SongHandler instance to control playback
//   final SongHandler songHandler;

//   // Size of the button
//   final double size;

//   // Constructor to initialize the PlayPauseButton
//   const PlayPauseButton({
//     super.key,
//     required this.size,
//     required this.songHandler,
//   });

//   // Build method to create the widget
//   @override
//   Widget build(BuildContext context) {
//     // StreamBuilder listens to changes in the playback state
//     return StreamBuilder<PlaybackState>(
//       stream: songHandler.playbackState.stream,
//       builder: (context, snapshot) {
//         // Check if there's data in the snapshot
//         if (snapshot.hasData) {
//           // Retrieve the playing status from the playback state
//           bool playing = snapshot.data!.playing;

//           // Return an IconButton that toggles play/pause on press
//           return IconButton(
//             onPressed: () {
//               // Toggle play/pause based on the current playing status
//               if (playing) {
//                 songHandler.pause();
//               } else {
//                 songHandler.play();
//               }
//             },
//             // Display a play or pause icon based on the playing status
//             icon: playing
//                 ? Icon(Icons.pause_rounded, size: size)
//                 : Icon(Icons.play_arrow_rounded, size: size),
//           );
//         } else {
//           // If there's no data in the snapshot, return an empty SizedBox
//           return const SizedBox.shrink();
//         }
//       },
//     );
//   }
// }

import 'package:audio_service/audio_service.dart';
import 'package:nuvibe/services/song_handler.dart';
import 'package:flutter/material.dart';

class PlayPauseButton extends StatelessWidget {
  final SongHandler songHandler;
  final double size;

  const PlayPauseButton({
    super.key,
    required this.size,
    required this.songHandler,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaybackState>(
      stream: songHandler.playbackState.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          bool playing = snapshot.data!.playing;
          return IconButton(
            onPressed: () {
              if (playing) {
                songHandler.pause();
              } else {
                songHandler.play();
              }
            },
            icon: playing
                ? Icon(
                    Icons.pause_rounded,
                    size: size,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.play_arrow_rounded,
                    size: size,
                    color: Colors.white,
                  ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class NextButton extends StatelessWidget {
  final SongHandler songHandler;
  final double size;

  const NextButton({
    super.key,
    required this.size,
    required this.songHandler,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        songHandler.skipToNext();
      },
      icon: Icon(
        Icons.skip_next_rounded,
        size: size,
        color: Colors.white,
      ),
    );
  }
}

class PrevButton extends StatelessWidget {
  final SongHandler songHandler;
  final double size;

  const PrevButton({
    super.key,
    required this.size,
    required this.songHandler,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        songHandler.skipToPrevious();
      },
      icon: Icon(
        Icons.skip_previous_rounded,
        size: size,
        color: Colors.white,
      ),
    );
  }
}
