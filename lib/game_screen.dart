import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:audioplayers/audioplayers.dart';
import 'dart:ui_web' as ui_web;
import 'dart:html' as html;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class GameScreen extends StatefulWidget {
  final AudioPlayer musicPlayer;

  const GameScreen({Key? key, required this.musicPlayer}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  InAppWebViewController? _webViewController;
  html.IFrameElement? _iframe;

  @override
  void initState() {
    super.initState();
    _stopMusic();
  }

  @override
  void dispose() {
    _resumeMusic();
    super.dispose();
  }

  void _stopMusic() async {
    try {
      await widget.musicPlayer.pause();
    } catch (e) {
      debugPrint('Error stopping music: $e');
    }
  }

  void _resumeMusic() async {
    try {
      await widget.musicPlayer.resume();
    } catch (e) {
      debugPrint('Error resuming music: $e');
    }
  }

  // Simulate mouse button down
  void _simulateJumpPress() {
    if (kIsWeb && _iframe != null) {
      _iframe!.contentWindow?.postMessage({
        'type': 'mousedown',
        'button': 2, // Right click
      }, '*');
    } else if (_webViewController != null) {
      _webViewController!.evaluateJavascript(source: '''
        var event = new MouseEvent('mousedown', {
          button: 2,
          buttons: 2,
          bubbles: true
        });
        document.dispatchEvent(event);
      ''');
    }
  }

  // Simulate mouse button up
  void _simulateJumpRelease() {
    if (kIsWeb && _iframe != null) {
      _iframe!.contentWindow?.postMessage({
        'type': 'mouseup',
        'button': 2,
      }, '*');
    } else if (_webViewController != null) {
      _webViewController!.evaluateJavascript(source: '''
        var event = new MouseEvent('mouseup', {
          button: 2,
          buttons: 0,
          bubbles: true
        });
        document.dispatchEvent(event);
      ''');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    if (kIsWeb) {
      // Register the iframe view factory for web
      const viewType = 'game-iframe';

      // Only register once
      try {
        ui_web.platformViewRegistry.registerViewFactory(
          viewType,
          (int viewId) {
            // Get the current base URL to handle GitHub Pages deployment
            final baseUrl = html.window.location.origin ?? '';
            final basePath = html.document.baseUri ?? '';
            // Construct the full path for the Unity game
            final gamePath = basePath.endsWith('/')
                ? '${basePath}assets/bunnyhop/web_1.2.1/index.html'
                : '$basePath/assets/bunnyhop/web_1.2.1/index.html';

            debugPrint('Loading Unity game from: $gamePath');

            _iframe = html.IFrameElement()
              ..src = gamePath
              ..style.border = 'none'
              ..style.width = '100%'
              ..style.height = '100%'
              ..setAttribute('allow', 'autoplay');
            return _iframe!;
          },
        );
      } catch (e) {
        debugPrint('Error registering iframe: $e');
        // Already registered, ignore
      }

      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('BunnyHop Game'),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Stack(
          children: [
            const HtmlElementView(viewType: viewType),
            // Mobile touch controls overlay
            if (isMobile)
              Positioned(
                bottom: 40,
                right: 40,
                child: GestureDetector(
                  onTapDown: (_) => _simulateJumpPress(),
                  onTapUp: (_) => _simulateJumpRelease(),
                  onTapCancel: () => _simulateJumpRelease(),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.6),
                        width: 3,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'JUMP',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    } else {
      // For mobile platforms, use InAppWebView
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('BunnyHop Game'),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri('asset://assets/bunnyhop/web_1.2.1/index.html'),
              ),
              initialSettings: InAppWebViewSettings(
                allowFileAccessFromFileURLs: true,
                allowUniversalAccessFromFileURLs: true,
                mediaPlaybackRequiresUserGesture: false,
                javaScriptEnabled: true,
              ),
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
            ),
            // Mobile touch controls overlay
            Positioned(
              bottom: 40,
              right: 40,
              child: GestureDetector(
                onTapDown: (_) => _simulateJumpPress(),
                onTapUp: (_) => _simulateJumpRelease(),
                onTapCancel: () => _simulateJumpRelease(),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.6),
                      width: 3,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'JUMP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
