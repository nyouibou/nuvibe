// import 'package:nuvibe/notifiers/songs_provider.dart';
// import 'package:nuvibe/services/song_handler.dart';
// import 'package:nuvibe/ui/components/player_deck.dart';
// import 'package:nuvibe/ui/components/songs_list.dart';
// import 'package:nuvibe/ui/screens/player_screen.dart';
// import 'package:nuvibe/ui/screens/search_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:scroll_to_index/scroll_to_index.dart';

// class HomeScreen extends StatefulWidget {
//   final SongHandler songHandler;

//   const HomeScreen({super.key, required this.songHandler});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final AutoScrollController _autoScrollController = AutoScrollController();

//   void _scrollTo(int index) {
//     _autoScrollController.scrollToIndex(
//       index,
//       preferPosition: AutoScrollPosition.middle,
//       duration: const Duration(milliseconds: 800),
//     );
//   }

//   // Build method for the HomeScreen widget
//   @override
//   Widget build(BuildContext context) {
//     // Annotate the UI overlay style for system UI elements
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//         systemNavigationBarColor: Theme.of(context).colorScheme.background,
//         systemNavigationBarIconBrightness:
//             Theme.of(context).brightness == Brightness.dark
//                 ? Brightness.light
//                 : Brightness.dark,
//       ),
//       child: Consumer<SongsProvider>(
//         builder: (context, songsProvider, _) {
//           return Scaffold(
//             backgroundColor: Colors.black,
//             appBar: AppBar(
//               backgroundColor: Colors.black,
//               title: const Text(
//                 "Nu Vibe",
//                 style: TextStyle(color: Colors.white),
//               ),
//               actions: [
//                 IconButton(
//                   onPressed: () => Get.to(
//                     () => SearchScreen(songHandler: widget.songHandler),
//                     duration: const Duration(milliseconds: 700),
//                     transition: Transition.rightToLeft,
//                   ),
//                   icon: const Icon(Icons.search_rounded, color: Colors.white),
//                 ),
//               ],
//             ),
//             body: songsProvider.isLoading
//                 ? _buildLoadingIndicator() // Display a loading indicator while songs are loading
//                 : _buildSongsList(songsProvider), // Display the list of songs
//           );
//         },
//       ),
//     );
//   }

//   // Method to build the loading indicator widget
//   Widget _buildLoadingIndicator() {
//     return const Center(
//       child: CircularProgressIndicator(
//         strokeCap: StrokeCap.round,
//       ),
//     );
//   }

//   Widget _buildSongsList(SongsProvider songsProvider) {
//     return Stack(
//       children: [
//         SongsList(
//           songHandler: widget.songHandler,
//           songs: songsProvider.songs,
//           autoScrollController: _autoScrollController,
//         ),
//         _buildPlayerDeck(),
//       ],
//     );
//   }

//   // Method to build the player deck widget
// //   Widget _buildPlayerDeck() {
// //     return Column(
// //       mainAxisAlignment: MainAxisAlignment.end,
// //       children: [
// //         // PlayerDeck widget with controls and the ability to scroll to a specific song
// //         PlayerDeck(
// //           songHandler: widget.songHandler,
// //           isLast: false,
// //           onTap: _scrollTo,
// //         ),
// //       ],
// //     );
// //   }
// // }
//   Widget _buildPlayerDeck() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         // PlayerDeck widget with controls and the ability to scroll to a specific song
//         PlayerDeck(
//           songHandler: widget.songHandler,
//           isLast: false,
//           onTap: (index) {
//             _scrollTo(index);
//             // Navigate to the full screen player, replacing the current route
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>
//                     FullScreenPlayer(songHandler: widget.songHandler),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nuvibe/presentation/player_screen.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'package:nuvibe/core/notifiers/songs_provider.dart';
import 'package:nuvibe/core/services/song_handler.dart';
import 'package:nuvibe/presentation/global%20widgets/player_deck.dart';
import 'package:nuvibe/presentation/global%20widgets/songs_list.dart'; // Assuming FullScreenPlayer is imported here
import 'package:nuvibe/presentation/search_screen.dart';

class HomeScreen extends StatefulWidget {
  final SongHandler songHandler;

  const HomeScreen({Key? key, required this.songHandler}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AutoScrollController _autoScrollController = AutoScrollController();
  DateTime?
      _lastBackPressedTime; // Variable to track last back button press time

  void _scrollTo(int index) {
    _autoScrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastBackPressedTime == null ||
            DateTime.now().difference(_lastBackPressedTime!) >
                Duration(seconds: 2)) {
          // First tap or tap after 2 seconds, show toast or snackbar
          _lastBackPressedTime = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
            ),
          );
          return false; // Do not exit the app
        } else {
          // Double tap within 2 seconds, exit the app
          return true;
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context).colorScheme.background,
          systemNavigationBarIconBrightness:
              Theme.of(context).brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark,
        ),
        child: Consumer<SongsProvider>(
          builder: (context, songsProvider, _) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: const Text(
                  "Nu Vibe",
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  IconButton(
                    onPressed: () => Get.to(
                      () => SearchScreen(songHandler: widget.songHandler),
                      duration: const Duration(milliseconds: 700),
                      transition: Transition.rightToLeft,
                    ),
                    icon: const Icon(Icons.search_rounded, color: Colors.white),
                  ),
                ],
              ),
              body: songsProvider.isLoading
                  ? _buildLoadingIndicator()
                  : _buildSongsList(songsProvider),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  Widget _buildSongsList(SongsProvider songsProvider) {
    return Stack(
      children: [
        SongsList(
          songHandler: widget.songHandler,
          songs: songsProvider.songs,
          autoScrollController: _autoScrollController,
        ),
        _buildPlayerDeck(),
      ],
    );
  }

  Widget _buildPlayerDeck() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
}