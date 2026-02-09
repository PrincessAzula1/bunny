import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:ui_web' as ui_web;
import 'dart:html' as html;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:js' as js;

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
    // Lock to landscape orientation for better gameplay
    _lockLandscape();
    _stopMusic();
  }

  void _lockLandscape() {
    if (kIsWeb) {
      // For web browsers and PWAs, use Screen Orientation API
      try {
        js.context.callMethod('eval', [
          '''
          if (screen.orientation && screen.orientation.lock) {
            screen.orientation.lock("landscape").then(
              () => console.log("Landscape locked"),
              (err) => console.log("Lock failed:", err)
            );
          }
          '''
        ]);
      } catch (e) {
        debugPrint('Web orientation lock failed: $e');
      }
    } else {
      // For native mobile apps
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
  }

  void _unlockOrientation() {
    if (kIsWeb) {
      try {
        js.context.callMethod('eval', ['screen.orientation.unlock()']);
      } catch (e) {
        debugPrint('Web orientation unlock failed: $e');
      }
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
  }

  @override
  void dispose() {
    // Restore portrait orientation when leaving game
    _unlockOrientation();
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
            // For web, use the assets path where Flutter places them
            // In the build output, assets are at: assets/assets/...
            const gamePath = 'assets/assets/bunnyhop/web_1.2.1/index.html';

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
        body: Stack(
          children: [
            const HtmlElementView(viewType: viewType),
            // Small return button (top-left corner)
            Positioned(
              top: 15,
              left: 15,
              child: Material(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                elevation: 4,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      "assets/images/return.png",
                      width: 24,
                      height: 24,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.arrow_back,
                          color: Colors.black87,
                          size: 24,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
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
            // Small return button (top-left corner)
            Positioned(
              top: 15,
              left: 15,
              child: Material(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                elevation: 4,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      "assets/images/return.png",
                      width: 24,
                      height: 24,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.arrow_back,
                          color: Colors.black87,
                          size: 24,
                        );
                      },
                    ),
                  ),
                ),
              ),
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
