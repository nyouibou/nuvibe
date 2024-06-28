// import 'package:audio_service/audio_service.dart';
// import 'package:flutter/material.dart';
// import 'package:nuvibe/services/song_handler.dart';
// import 'package:nuvibe/ui/components/play_pause_button.dart';
// import 'package:nuvibe/ui/components/song_progress.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class FullScreenPlayer extends StatelessWidget {
//   final SongHandler songHandler;

//   const FullScreenPlayer({Key? key, required this.songHandler})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             StreamBuilder<MediaItem?>(
//               stream: songHandler.mediaItem.stream,
//               builder: (context, snapshot) {
//                 MediaItem? playingSong = snapshot.data;
//                 if (playingSong == null) {
//                   return const Text(
//                     "No song playing",
//                     style: TextStyle(color: Colors.white, fontSize: 24),
//                   );
//                 } else {
//                   return Column(
//                     children: [
//                       Container(
//                         width: 300,
//                         height: 300,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(16.0),
//                           color: Colors.grey[800],
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(16.0),
//                           child: QueryArtworkWidget(
//                             id: int.parse(playingSong.displayDescription!),
//                             type: ArtworkType.AUDIO,
//                             artworkFit: BoxFit.cover,
//                             nullArtworkWidget: const Icon(
//                               Icons.music_note_rounded,
//                               size: 200,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 30), // Increase spacing
//                       Text(
//                         playingSong.title,
//                         style:
//                             const TextStyle(color: Colors.white, fontSize: 24),
//                       ),
//                       const SizedBox(height: 10), // Adjust spacing
//                       Text(
//                         playingSong.artist ?? '',
//                         style:
//                             const TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                       const SizedBox(height: 20),
//                       Container(
//                         width: 300,
//                         child: SongProgress(
//                           totalDuration: playingSong.duration!,
//                           songHandler: songHandler,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           PrevButton(
//                             size: 50,
//                             songHandler: songHandler,
//                           ),
//                           const SizedBox(width: 20),
//                           PlayPauseButton(
//                             size: 50,
//                             songHandler: songHandler,
//                           ),
//                           const SizedBox(width: 20),
//                           NextButton(
//                             size: 50,
//                             songHandler: songHandler,
//                           ),
//                         ],
//                       ),
//                     ],
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: use_super_parameters

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:nuvibe/core/services/song_handler.dart';
import 'package:nuvibe/presentation/global%20widgets/play_pause_button.dart';
import 'package:nuvibe/presentation/global%20widgets/song_progress.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FullScreenPlayer extends StatefulWidget {
  final SongHandler songHandler;

  const FullScreenPlayer({
    Key? key,
    required this.songHandler,
  }) : super(key: key);

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: StreamBuilder<MediaItem?>(
          stream: widget.songHandler.mediaItem.stream,
          builder: (context, snapshot) {
            MediaItem? playingSong = snapshot.data;
            if (playingSong == null) {
              return const Text(
                "No song playing",
                style: TextStyle(color: Colors.white, fontSize: 24),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey[800],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: QueryArtworkWidget(
                        id: int.parse(playingSong.displayDescription!),
                        type: ArtworkType.AUDIO,
                        artworkFit: BoxFit.cover,
                        nullArtworkWidget: const Icon(
                          Icons.music_note_rounded,
                          size: 200,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30), // Increase spacing
                  Text(
                    playingSong.title,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const SizedBox(height: 10), // Adjust spacing
                  Text(
                    playingSong.artist ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 300,
                    child: SongProgress(
                      totalDuration: playingSong.duration!,
                      songHandler: widget.songHandler,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrevButton(
                        size: 50,
                        songHandler: widget.songHandler,
                      ),
                      const SizedBox(width: 20),
                      PlayPauseButton(
                        size: 50,
                        songHandler: widget.songHandler,
                      ),
                      const SizedBox(width: 20),
                      NextButton(
                        size: 50,
                        songHandler: widget.songHandler,
                      ),
                      const SizedBox(width: 20),
                      RepeatButton(size: 50, songHandler: widget.songHandler)
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
