import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'game_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartVideoScreen(),
    );
  }
}

//////////////////////////////////////////////////////
//// 1️⃣ VIDEO SCREEN
//////////////////////////////////////////////////////

class StartVideoScreen extends StatefulWidget {
  final AudioPlayer? musicPlayer;

  const StartVideoScreen({Key? key, this.musicPlayer}) : super(key: key);

  @override
  State<StartVideoScreen> createState() => _StartVideoScreenState();
}

class _StartVideoScreenState extends State<StartVideoScreen> {
  late VideoPlayerController _videoController;
  late AudioPlayer _musicPlayer;

  bool _flash = false;

  // ⏰ TIME
  late Timer _clockTimer;
  DateTime _now = DateTime.now();

  // 🌤️ WEATHER
  String _weatherText = "Loading weather...";
  String _tempText = "";
  String _weatherImage = "assets/images/sunny.png";

  @override
  void initState() {
    super.initState();

    _videoController =
        VideoPlayerController.asset('assets/videos/start_menu.mp4')
          ..initialize().then((_) {
            _videoController.setLooping(true);
            _videoController.play();
            setState(() {});
          });

    _musicPlayer = widget.musicPlayer ?? AudioPlayer();
    _musicPlayer.setVolume(1.0);

    if (widget.musicPlayer == null) {
      _startMusicOnce();
    }

    _startClock();
    _fetchWeather();
  }

  // ⏰ LIVE CLOCK
  void _startClock() {
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  // 🌤️ WEATHER (Tangerang)
  Future<void> _fetchWeather() async {
    const url =
        "https://api.openweathermap.org/data/2.5/weather?q=Tangerang,id&units=metric&appid=d83902510af3cb2218a634234166e51e";

    try {
      final res = await http.get(Uri.parse(url));
      final data = json.decode(res.body);
      final weatherCondition = data['weather'][0]['main'];

      setState(() {
        _weatherText = weatherCondition;
        _tempText = "${data['main']['temp'].round()}°C";
        _weatherImage = _getWeatherImage(weatherCondition);
      });
    } catch (_) {
      setState(() {
        _weatherText = "Weather unavailable";
        _weatherImage = "assets/images/sunny.png";
      });
    }
  }

  // 📸 GET WEATHER IMAGE BASED ON CONDITION
  String _getWeatherImage(String weatherCondition) {
    final condition = weatherCondition.toLowerCase();

    if (condition.contains("thunderstorm")) {
      return "assets/images/thunderstorm.png";
    } else if (condition.contains("rain")) {
      if (condition.contains("sunny") || condition.contains("clear")) {
        return "assets/images/sunny with rain.png";
      }
      return "assets/images/rain.png";
    } else if (condition.contains("cloud")) {
      return "assets/images/sunny with clouds.png";
    } else if (condition.contains("sunny") || condition.contains("clear")) {
      return "assets/images/sunny.png";
    } else if (condition.contains("cloudy")) {
      return "assets/images/cloudy.png";
    }

    return "assets/images/sunny.png"; // Default
  }

  Future<void> _startMusicOnce() async {
    try {
      await _musicPlayer.stop();
      await _musicPlayer.setReleaseMode(ReleaseMode.loop);
      await _musicPlayer.play(AssetSource('audio/music.mp3'));
    } catch (_) {}
  }

  Future<void> _goNext() async {
    try {
      _videoController.pause();
      await _musicPlayer.stop();
    } catch (_) {}

    try {
      await _musicPlayer.setReleaseMode(ReleaseMode.stop);
      await _musicPlayer.play(AssetSource('audio/flash.mp3'));
      await Future.delayed(const Duration(seconds: 1));
      await _musicPlayer.stop();
    } catch (_) {}

    setState(() => _flash = true);

    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BunnyScreen(musicPlayer: _musicPlayer),
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    _clockTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🎥 VIDEO
          _videoController.value.isInitialized
              ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _videoController.value.size.width,
                      height: _videoController.value.size.height,
                      child: VideoPlayer(_videoController),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),

          // ⚡ FLASH
          AnimatedOpacity(
            opacity: _flash ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: Container(color: Colors.white),
          ),

          // ⏰ TIME + 🌤️ WEATHER OVERLAY
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.45),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${_now.hour.toString().padLeft(2, '0')}:${_now.minute.toString().padLeft(2, '0')}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${_now.day}/${_now.month}/${_now.year}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Tangerang",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Image.asset(
                        _weatherImage,
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "$_weatherText\n$_tempText",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ▶️ START BUTTON
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: _goNext,
                child: const Text("Start"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////
//// 2️⃣ BUNNY SCREEN
//////////////////////////////////////////////////////

class BunnyScreen extends StatefulWidget {
  final AudioPlayer musicPlayer;

  const BunnyScreen({Key? key, required this.musicPlayer}) : super(key: key);

  @override
  State<BunnyScreen> createState() => _BunnyScreenState();
}

class _BunnyScreenState extends State<BunnyScreen> {
  final List<String> messages = [
    "Hello my love ❤️",
    "How are you, my sunshine?",
    "Your smile is my favorite sunrise.",
    "If I had a garden, I'd plant you in the center.",
    "Every minute with you feels like a soft melody.",
    "I carry your laugh in my pockets.",
    "You make ordinary moments glow.",
    "Close your eyes — I'm sending you a quiet hug.",
    "Your voice is my calm sea.",
    "In every crowd, my eyes find you first.",
    "You are the poem I always want to read.",
    "Small hands, big heart — perfect balance.",
    "I wish I could freeze this moment for you.",
    "Your kindness is my daily miracle.",
    "When you sleep, I count stars for you.",
    "Stay close; I promise to keep you warm.",
    "You're the gentle chapter in my noisy book.",
    "With you, even silence sings.",
    "I hope your day is as kind as your heart.",
    "Forever sounds better with you beside me."
  ];
  int messageIndex = 0;
  int charIndex = 0;

  Timer? _timer;
  final AudioPlayer _voicePlayer = AudioPlayer();

  String get currentMessage => messages[messageIndex];

  Future<void> _startTyping() async {
    // Stop previous voice audio before starting new one
    try {
      await _voicePlayer.stop();
      await _voicePlayer.setReleaseMode(ReleaseMode.loop);
      await _voicePlayer.play(AssetSource('audio/speaking.mp3'));
    } catch (_) {
      // ignore audio errors
    }

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 17), (timer) {
      if (charIndex < currentMessage.length) {
        setState(() => charIndex++);
      } else {
        timer.cancel();
        try {
          _voicePlayer.stop();
        } catch (_) {}
      }
    });
  }

  void _nextMessage() {
    if (messageIndex < messages.length - 1) {
      setState(() {
        messageIndex++;
        charIndex = 0;
      });
      _startTyping();
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

    // Resume looping music if it's not playing
    _resetMusicPlayer();
    _startTyping();
  }

  Future<void> _resetMusicPlayer() async {
    try {
      // Ensure music player is back to loop mode
      await widget.musicPlayer.setReleaseMode(ReleaseMode.loop);
      // Resume music if it's stopped
      if (widget.musicPlayer.state == PlayerState.stopped) {
        await widget.musicPlayer.play(AssetSource('audio/music.mp3'));
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _timer?.cancel();
    try {
      _voicePlayer.stop();
      _voicePlayer.release();
    } catch (_) {}
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  Future<void> _returnToHome() async {
    _timer?.cancel();
    try {
      _voicePlayer.stop();
    } catch (_) {}

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => StartVideoScreen(musicPlayer: widget.musicPlayer),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isTypingComplete = charIndex >= currentMessage.length;
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;
    final isMobile = size.width < 600;

    // Responsive sizes
    final bubbleWidth = isMobile ? size.width * 0.85 : 500.0;
    final textWidth = isMobile ? size.width * 0.65 : 400.0;
    final fontSize = isMobile ? 16.0 : 20.0;
    final returnButtonSize = isMobile ? 40.0 : 50.0;

    return Scaffold(
      body: Stack(
        children: [
          // 🐰 Animated Bunny (webp animates automatically)
          Positioned.fill(
            child: Image.asset(
              "assets/images/bunny.webp",
              fit: BoxFit.cover,
            ),
          ),

          // ↩️ Return Button (Top Right)
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onTap: _returnToHome,
              child: Image.asset(
                "assets/images/return.png",
                width: returnButtonSize,
                height: returnButtonSize,
              ),
            ),
          ),

          // 💬 Bubble Image + Typing Text
          Positioned(
            bottom: isMobile ? 80 : 30,
            left: 0,
            right: isMobile ? 0 : -260,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/images/Bubble.png",
                    width: bubbleWidth,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: bubbleWidth * 0.136,
                      vertical: 9,
                    ),
                    child: SizedBox(
                      width: textWidth,
                      child: Text(
                        currentMessage.substring(0, charIndex),
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Bokutoh',
                          fontSize: fontSize,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ▶️ Next Button (appears after message finishes typing)
          if (isTypingComplete)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: isMobile
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: _nextMessage,
                            child: const Text("Next"),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GameScreen(
                                      musicPlayer: widget.musicPlayer),
                                ),
                              );
                              // Resume music when returning
                              _resetMusicPlayer();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text("Play BunnyHop"),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _nextMessage,
                            child: const Text("Next"),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GameScreen(
                                      musicPlayer: widget.musicPlayer),
                                ),
                              );
                              // Resume music when returning
                              _resetMusicPlayer();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text("Play BunnyHop"),
                          ),
                        ],
                      ),
              ),
            ),
        ],
      ),
    );
  }
}
