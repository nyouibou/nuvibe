// import 'dart:io';

// import 'package:nuvibe/services/uri_to_file.dart';
// import 'package:nuvibe/utils/formatted_text.dart';
// import 'package:flutter/material.dart';
// import 'package:transparent_image/transparent_image.dart';

// class SongItem extends StatelessWidget {
//   final String? searchedWord;
//   final bool isPlaying;
//   final Uri? art;
//   final String title;
//   final String? artist;
//   final int id;
//   final VoidCallback onSongTap;

//   // Constructor for the SongItem class
//   const SongItem({
//     super.key,
//     required this.isPlaying,
//     required this.title,
//     required this.artist,
//     required this.onSongTap,
//     required this.id,
//     this.searchedWord,
//     required this.art,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: ListTile(
//         // Set tile color based on whether the song is playing
//         tileColor: isPlaying ? Colors.grey : null,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//         // Handle tap on the ListTile
//         onTap: () => onSongTap(),
//         // Build leading widget (artwork)
//         leading: _buildLeading(),
//         // Build title and subtitle widgets
//         title: _buildTitle(context),
//         subtitle: _buildSubtitle(context),
//       ),
//     );
//   }

//   // Build the title widget with optional search word formatting
//   Widget _buildTitle(BuildContext context) {
//     return searchedWord != null
//         ? formattedText(
//             corpus: title,
//             searchedWord: searchedWord!,
//             context: context,
//           )
//         : Text(
//             title,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           );
//   }

//   // Build the subtitle widget with optional search word formatting
//   Text? _buildSubtitle(BuildContext context) {
//     return artist == null
//         ? null
//         : searchedWord != null
//             ? formattedText(
//                 corpus: artist!,
//                 searchedWord: searchedWord!,
//                 context: context,
//               )
//             : Text(
//                 artist!,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               );
//   }

//   // Build the leading widget (artwork)
//   Widget _buildLeading() {
//     return FutureBuilder<File?>(
//       // Use the uriToFile function to convert Uri to File
//       future: uriToFile(art),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           // Handle error, e.g., show a placeholder or log the error
//           return const Icon(Icons.error_outline);
//         }

//         return Container(
//           height: 45,
//           width: 45,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8.0), color: Colors.white),
//           child: snapshot.data == null
//               ? const Icon(Icons.music_note_rounded)
//               : ClipRRect(
//                   borderRadius: BorderRadius.circular(8.0),
//                   child: FadeInImage(
//                     height: 45,
//                     width: 45,
//                     image: FileImage(snapshot.data!),
//                     placeholder: MemoryImage(kTransparentImage),
//                     fadeInDuration: const Duration(milliseconds: 700),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//         );
//       },
//     );
//   }
// }

import 'dart:io';

import 'package:nuvibe/core/services/uri_to_file.dart';
import 'package:nuvibe/core/utils/formatted_text.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class SongItem extends StatelessWidget {
  final String? searchedWord;
  final bool isPlaying;
  final Uri? art;
  final String title;
  final String? artist;
  final int id;
  final VoidCallback onSongTap;
  final TextStyle? titleStyle;

  // Constructor for the SongItem class
  const SongItem({
    super.key,
    required this.isPlaying,
    required this.title,
    required this.artist,
    required this.onSongTap,
    required this.id,
    this.searchedWord,
    required this.art,
    this.titleStyle,
    required TextStyle titleTextStyle,
    required TextStyle artistTextStyle,
    // required Color backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        // Set tile color based on whether the song is playing
        tileColor: isPlaying ? Colors.grey : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        // Handle tap on the ListTile
        onTap: () => onSongTap(),
        // Build leading widget (artwork)
        leading: _buildLeading(),
        // Build title and subtitle widgets
        title: _buildTitle(context),
        subtitle: _buildSubtitle(context),
      ),
    );
  }

  // Build the title widget with optional search word formatting
  Widget _buildTitle(BuildContext context) {
    return searchedWord != null
        ? formattedText(
            corpus: title,
            searchedWord: searchedWord!,
            context: context,
            // Applying titleStyle if provided
            // style: titleStyle,
          )
        : Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
            // Apply custom text style
          );
  }

  // Build the subtitle widget with optional search word formatting
  Text? _buildSubtitle(BuildContext context) {
    return artist == null
        ? null
        : searchedWord != null
            ? formattedText(
                corpus: artist!,
                searchedWord: searchedWord!,
                context: context,
              )
            : Text(
                artist!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              );
  }

  // Build the leading widget (artwork)
  Widget _buildLeading() {
    return FutureBuilder<File?>(
      // Use the uriToFile function to convert Uri to File
      future: uriToFile(art),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Handle error, e.g., show a placeholder or log the error
          return const Icon(Icons.error_outline);
        }

        return Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: Colors.grey),
          child: snapshot.data == null
              ? const Icon(Icons.music_note_rounded)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FadeInImage(
                    height: 45,
                    width: 45,
                    image: FileImage(snapshot.data!),
                    placeholder: MemoryImage(kTransparentImage),
                    fadeInDuration: const Duration(milliseconds: 700),
                    fit: BoxFit.cover,
                  ),
                ),
        );
      },
    );
  }
}
