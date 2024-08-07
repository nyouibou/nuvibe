// import 'package:audio_service/audio_service.dart';
// import 'package:just_audio/just_audio.dart';

// // Class for handling audio playback using AudioService and Just Audio
// class SongHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
//   // Create an instance of the AudioPlayer class from just_audio package
//   final AudioPlayer audioPlayer = AudioPlayer();

//   // Function to create an audio source from a MediaItem
//   UriAudioSource _createAudioSource(MediaItem item) {
//     return ProgressiveAudioSource(Uri.parse(item.id));
//   }

//   // Listen for changes in the current song index and update the media item
//   void _listenForCurrentSongIndexChanges() {
//     audioPlayer.currentIndexStream.listen((index) {
//       final playlist = queue.value;
//       if (index == null || playlist.isEmpty) return;
//       mediaItem.add(playlist[index]);
//     });
//   }

//   // Broadcast the current playback state based on the received PlaybackEvent
//   void _broadcastState(PlaybackEvent event) {
//     playbackState.add(playbackState.value.copyWith(
//       controls: [
//         MediaControl.skipToPrevious,
//         if (audioPlayer.playing) MediaControl.pause else MediaControl.play,
//         MediaControl.skipToNext,
//       ],
//       systemActions: {
//         MediaAction.seek,
//         MediaAction.seekForward,
//         MediaAction.seekBackward,
//       },
//       processingState: const {
//         ProcessingState.idle: AudioProcessingState.idle,
//         ProcessingState.loading: AudioProcessingState.loading,
//         ProcessingState.buffering: AudioProcessingState.buffering,
//         ProcessingState.ready: AudioProcessingState.ready,
//         ProcessingState.completed: AudioProcessingState.completed,
//       }[audioPlayer.processingState]!,
//       playing: audioPlayer.playing,
//       updatePosition: audioPlayer.position,
//       bufferedPosition: audioPlayer.bufferedPosition,
//       speed: audioPlayer.speed,
//       queueIndex: event.currentIndex,
//     ));
//   }

//   // Function to initialize the songs and set up the audio player
//   Future<void> initSongs({required List<MediaItem> songs}) async {
//     // Listen for playback events and broadcast the state
//     audioPlayer.playbackEventStream.listen(_broadcastState);

//     // Create a list of audio sources from the provided songs
//     final audioSource = songs.map(_createAudioSource).toList();

//     // Set the audio source of the audio player to the concatenation of the audio sources
//     await audioPlayer
//         .setAudioSource(ConcatenatingAudioSource(children: audioSource));

//     // Add the songs to the queue
//     queue.value.clear();
//     queue.value.addAll(songs);
//     queue.add(queue.value);

//     // Listen for changes in the current song index
//     _listenForCurrentSongIndexChanges();

//     // Listen for processing state changes and skip to the next song when completed
//     audioPlayer.processingStateStream.listen((state) {
//       if (state == ProcessingState.completed) skipToNext();
//     });
//   }

//   // Play function to start playback
//   @override
//   Future<void> play() => audioPlayer.play();

//   // Pause function to pause playback
//   @override
//   Future<void> pause() => audioPlayer.pause();

//   // Seek function to change the playback position
//   @override
//   Future<void> seek(Duration position) => audioPlayer.seek(position);

//   // Skip to a specific item in the queue and start playback
//   @override
//   Future<void> skipToQueueItem(int index) async {
//     await audioPlayer.seek(Duration.zero, index: index);
//     play();
//   }

//   // Skip to the next item in the queue
//   @override
//   Future<void> skipToNext() => audioPlayer.seekToNext();

//   // Skip to the previous item in the queue
//   @override
//   Future<void> skipToPrevious() => audioPlayer.seekToPrevious();
// }
// import 'package:audio_service/audio_service.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:rxdart/rxdart.dart';

// // Class for handling audio playback using AudioService and Just Audio
// class SongHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
//   // Create an instance of the AudioPlayer class from just_audio package
//   final AudioPlayer audioPlayer = AudioPlayer();

//   // Function to create an audio source from a MediaItem
//   UriAudioSource _createAudioSource(MediaItem item) {
//     return ProgressiveAudioSource(Uri.parse(item.id));
//   }

//   // Listen for changes in the current song index and update the media item
//   void _listenForCurrentSongIndexChanges() {
//     audioPlayer.currentIndexStream.listen((index) {
//       final playlist = queue.value;
//       if (index == null || playlist.isEmpty) return;
//       mediaItem.add(playlist[index]);
//     });
//   }

//   // Broadcast the current playback state based on the received PlaybackEvent
//   void _broadcastState(PlaybackEvent event) {
//     playbackState.add(playbackState.value.copyWith(
//       controls: [
//         MediaControl.skipToPrevious,
//         if (audioPlayer.playing) MediaControl.pause else MediaControl.play,
//         MediaControl.skipToNext,
//       ],
//       systemActions: {
//         MediaAction.seek,
//         MediaAction.seekForward,
//         MediaAction.seekBackward,
//       },
//       processingState: const {
//         ProcessingState.idle: AudioProcessingState.idle,
//         ProcessingState.loading: AudioProcessingState.loading,
//         ProcessingState.buffering: AudioProcessingState.buffering,
//         ProcessingState.ready: AudioProcessingState.ready,
//         ProcessingState.completed: AudioProcessingState.completed,
//       }[audioPlayer.processingState]!,
//       playing: audioPlayer.playing,
//       updatePosition: audioPlayer.position,
//       bufferedPosition: audioPlayer.bufferedPosition,
//       speed: audioPlayer.speed,
//       queueIndex: event.currentIndex,
//     ));
//   }

//   // Function to initialize the songs and set up the audio player
//   Future<void> initSongs({required List<MediaItem> songs}) async {
//     // Listen for playback events and broadcast the state
//     audioPlayer.playbackEventStream.listen(_broadcastState);

//     // Create a list of audio sources from the provided songs
//     final audioSource = songs.map(_createAudioSource).toList();

//     // Set the audio source of the audio player to the concatenation of the audio sources
//     await audioPlayer
//         .setAudioSource(ConcatenatingAudioSource(children: audioSource));

//     // Add the songs to the queue
//     queue.value.clear();
//     queue.value.addAll(songs);
//     queue.add(queue.value);

//     // Listen for changes in the current song index
//     _listenForCurrentSongIndexChanges();

//     // Listen for processing state changes and skip to the next song when completed
//     audioPlayer.processingStateStream.listen((state) {
//       if (state == ProcessingState.completed) skipToNext();
//     });
//   }

//   // Play function to start playback
//   @override
//   Future<void> play() => audioPlayer.play();

//   // Pause function to pause playback
//   @override
//   Future<void> pause() => audioPlayer.pause();

//   // Seek function to change the playback position
//   @override
//   Future<void> seek(Duration position) => audioPlayer.seek(position);

//   // Skip to a specific item in the queue and start playback
//   @override
//   Future<void> skipToQueueItem(int index) async {
//     await audioPlayer.seek(Duration.zero, index: index);
//     play();
//   }

//   // Skip to the next item in the queue
//   @override
//   Future<void> skipToNext() => audioPlayer.seekToNext();

//   // Skip to the previous item in the queue
//   @override
//   Future<void> skipToPrevious() => audioPlayer.seekToPrevious();
// }
// import 'package:audio_service/audio_service.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:rxdart/rxdart.dart';

// // Enum for the repeat modes
// enum RepeatMode { none, one, all }

// class SongHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
//   final AudioPlayer audioPlayer = AudioPlayer();

//   // Stream controller for the repeat mode
//   final _repeatModeController =
//       BehaviorSubject<RepeatMode>.seeded(RepeatMode.none);
//   Stream<RepeatMode> get repeatModeStream => _repeatModeController.stream;

//   // Variable to store the current repeat mode
//   RepeatMode get currentRepeatMode => _repeatModeController.value;

//   // Function to create an audio source from a MediaItem
//   UriAudioSource _createAudioSource(MediaItem item) {
//     return ProgressiveAudioSource(Uri.parse(item.id));
//   }

//   void _listenForCurrentSongIndexChanges() {
//     audioPlayer.currentIndexStream.listen((index) {
//       final playlist = queue.value;
//       if (index == null || playlist.isEmpty) return;
//       mediaItem.add(playlist[index]);
//     });
//   }

//   void _broadcastState(PlaybackEvent event) {
//     playbackState.add(playbackState.value.copyWith(
//       controls: [
//         MediaControl.skipToPrevious,
//         if (audioPlayer.playing) MediaControl.pause else MediaControl.play,
//         MediaControl.skipToNext,
//       ],
//       systemActions: {
//         MediaAction.seek,
//         MediaAction.seekForward,
//         MediaAction.seekBackward,
//       },
//       processingState: const {
//         ProcessingState.idle: AudioProcessingState.idle,
//         ProcessingState.loading: AudioProcessingState.loading,
//         ProcessingState.buffering: AudioProcessingState.buffering,
//         ProcessingState.ready: AudioProcessingState.ready,
//         ProcessingState.completed: AudioProcessingState.completed,
//       }[audioPlayer.processingState]!,
//       playing: audioPlayer.playing,
//       updatePosition: audioPlayer.position,
//       bufferedPosition: audioPlayer.bufferedPosition,
//       speed: audioPlayer.speed,
//       queueIndex: event.currentIndex,
//     ));
//   }

//   Future<void> initSongs({required List<MediaItem> songs}) async {
//     audioPlayer.playbackEventStream.listen(_broadcastState);

//     final audioSource = songs.map(_createAudioSource).toList();
//     await audioPlayer
//         .setAudioSource(ConcatenatingAudioSource(children: audioSource));

//     queue.value.clear();
//     queue.value.addAll(songs);
//     queue.add(queue.value);

//     _listenForCurrentSongIndexChanges();

//     audioPlayer.processingStateStream.listen((state) {
//       if (state == ProcessingState.completed) {
//         switch (currentRepeatMode) {
//           case RepeatMode.none:
//             skipToNext();
//             break;
//           case RepeatMode.one:
//             audioPlayer.seek(Duration.zero);
//             audioPlayer.play();
//             break;
//           case RepeatMode.all:
//             skipToNext();
//             if (audioPlayer.currentIndex == null ||
//                 audioPlayer.currentIndex! >= queue.value.length - 1) {
//               skipToQueueItem(0);
//             }
//             break;
//         }
//       }
//     });
//   }

//   @override
//   Future<void> play() => audioPlayer.play();

//   @override
//   Future<void> pause() => audioPlayer.pause();

//   @override
//   Future<void> seek(Duration position) => audioPlayer.seek(position);

//   @override
//   Future<void> skipToQueueItem(int index) async {
//     await audioPlayer.seek(Duration.zero, index: index);
//     play();
//   }

//   @override
//   Future<void> skipToNext() => audioPlayer.seekToNext();

//   @override
//   Future<void> skipToPrevious() => audioPlayer.seekToPrevious();

//   // Method to toggle repeat mode
//   void toggleRepeatMode() {
//     switch (currentRepeatMode) {
//       case RepeatMode.none:
//         _repeatModeController.add(RepeatMode.one);
//         break;
//       case RepeatMode.one:
//         _repeatModeController.add(RepeatMode.all);
//         break;
//       case RepeatMode.all:
//         _repeatModeController.add(RepeatMode.none);
//         break;
//     }
//   }

//   void dispose() {
//     _repeatModeController.close();
//   }
// }

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

// Enum for the repeat modes
enum RepeatMode { none, one, all }

class SongHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final AudioPlayer audioPlayer = AudioPlayer();

  // Stream controller for the repeat mode
  final _repeatModeController =
      BehaviorSubject<RepeatMode>.seeded(RepeatMode.none);
  Stream<RepeatMode> get repeatModeStream => _repeatModeController.stream;

  // Variable to store the current repeat mode
  RepeatMode get currentRepeatMode => _repeatModeController.value;

  // Stream controller for the favorite status
  final _favoriteStatusController = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get favoriteStatusStream => _favoriteStatusController.stream;

  // Set to store favorite songs' IDs
  final Set<String> _favoriteSongs = {};
  final _favoriteSongsController = BehaviorSubject<List<MediaItem>>.seeded([]);
  Stream<List<MediaItem>> get favoriteSongsStream =>
      _favoriteSongsController.stream;

  // Function to create an audio source from a MediaItem
  UriAudioSource _createAudioSource(MediaItem item) {
    return ProgressiveAudioSource(Uri.parse(item.id));
  }

  void _listenForCurrentSongIndexChanges() {
    audioPlayer.currentIndexStream.listen((index) {
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) return;
      final currentItem = playlist[index];
      mediaItem.add(currentItem);

      // Update the favorite status based on the current song
      _favoriteStatusController.add(_favoriteSongs.contains(currentItem.id));
    });
  }

  void _broadcastState(PlaybackEvent event) {
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (audioPlayer.playing) MediaControl.pause else MediaControl.play,
        MediaControl.skipToNext,
      ],
      systemActions: {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[audioPlayer.processingState]!,
      playing: audioPlayer.playing,
      updatePosition: audioPlayer.position,
      bufferedPosition: audioPlayer.bufferedPosition,
      speed: audioPlayer.speed,
      queueIndex: event.currentIndex,
    ));
  }

  Future<void> initSongs({required List<MediaItem> songs}) async {
    audioPlayer.playbackEventStream.listen(_broadcastState);

    final audioSource = songs.map(_createAudioSource).toList();
    await audioPlayer
        .setAudioSource(ConcatenatingAudioSource(children: audioSource));

    queue.value.clear();
    queue.value.addAll(songs);
    queue.add(queue.value);

    _listenForCurrentSongIndexChanges();

    audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        switch (currentRepeatMode) {
          case RepeatMode.none:
            skipToNext();
            break;
          case RepeatMode.one:
            audioPlayer.seek(Duration.zero);
            audioPlayer.play();
            break;
          case RepeatMode.all:
            skipToNext();
            if (audioPlayer.currentIndex == null ||
                audioPlayer.currentIndex! >= queue.value.length - 1) {
              skipToQueueItem(0);
            }
            break;
        }
      }
    });
  }

  @override
  Future<void> play() => audioPlayer.play();

  @override
  Future<void> pause() => audioPlayer.pause();

  @override
  Future<void> seek(Duration position) => audioPlayer.seek(position);

  @override
  Future<void> skipToQueueItem(int index) async {
    await audioPlayer.seek(Duration.zero, index: index);
    play();
  }

  @override
  Future<void> skipToNext() => audioPlayer.seekToNext();

  @override
  Future<void> skipToPrevious() => audioPlayer.seekToPrevious();

  // Method to toggle repeat mode
  void toggleRepeatMode() {
    switch (currentRepeatMode) {
      case RepeatMode.none:
        _repeatModeController.add(RepeatMode.one);
        break;
      case RepeatMode.one:
        _repeatModeController.add(RepeatMode.all);
        break;
      case RepeatMode.all:
        _repeatModeController.add(RepeatMode.none);
        break;
    }
  }

  // Method to toggle favorite status
  void toggleFavoriteStatus() {
    final currentSong = mediaItem.value;
    if (currentSong == null) return;

    if (_favoriteSongs.contains(currentSong.id)) {
      _favoriteSongs.remove(currentSong.id);
      _favoriteStatusController.add(false);
    } else {
      _favoriteSongs.add(currentSong.id);
      _favoriteStatusController.add(true);
    }

    // Update the list of favorite songs
    _favoriteSongsController.add(
        queue.value.where((song) => _favoriteSongs.contains(song.id)).toList());
  }

  void dispose() {
    _repeatModeController.close();
    _favoriteStatusController.close();
    _favoriteSongsController.close();
  }
}
