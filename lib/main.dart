import 'package:audio_service/audio_service.dart';
import 'package:nuvibe/core/notifiers/songs_provider.dart';
import 'package:nuvibe/core/services/song_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuvibe/presentation/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

// Create a singleton instance of SongHandler
SongHandler _songHandler = SongHandler();

// Entry point of the application
Future<void> main() async {
  // Ensure that the Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AudioService with the custom SongHandler
  _songHandler = await AudioService.init(
    builder: () => SongHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.nuvibe.app',
      androidNotificationChannelName: 'NuVibe',
      androidNotificationOngoing: true,
      androidShowNotificationBadge: true,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SongsProvider()..loadSongs(_songHandler),
        ),
      ],
      child: const MainApp(),
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(songHandler: _songHandler),
    );
  }
}
