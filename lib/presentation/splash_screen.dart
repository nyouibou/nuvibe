import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nuvibe/core/utils/texts.dart';
import 'package:nuvibe/presentation/home_screen.dart';
import 'package:nuvibe/core/services/song_handler.dart';

class SplashScreen extends StatefulWidget {
  final SongHandler songHandler;

  const SplashScreen({Key? key, required this.songHandler}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3)); // Delay for splash screen
    Get.off(() => HomeScreen(songHandler: widget.songHandler));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 220,
              height: 220,
              child: Lottie.asset(
                "assets/images/Animation - 1716911199498.json",
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
                height:
                    20), // Add some spacing between Lottie animation and text
            Text(
              "Nu Vibe",
              style: MytextStyle.AppName,
            ),
          ],
        ),
      ),
    );
  }
}
