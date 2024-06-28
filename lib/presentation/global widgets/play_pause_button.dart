import 'package:audio_service/audio_service.dart';
import 'package:nuvibe/core/services/song_handler.dart';
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

class RepeatButton extends StatelessWidget {
  final SongHandler songHandler;
  final double size;

  const RepeatButton({
    super.key,
    required this.size,
    required this.songHandler,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RepeatMode>(
      stream: songHandler.repeatModeStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          RepeatMode repeatMode = snapshot.data!;
          IconData iconData;

          switch (repeatMode) {
            case RepeatMode.none:
              iconData = Icons.repeat;
              break;
            case RepeatMode.one:
              iconData = Icons.repeat_one;
              break;
            case RepeatMode.all:
              iconData = Icons.repeat;
              break;
          }

          return IconButton(
            onPressed: songHandler.toggleRepeatMode,
            icon: Icon(
              iconData,
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
