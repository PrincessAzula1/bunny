// Minimal local stub for the subset of `audioplayers` API used by the app.
// All methods are no-ops so the app can run during development without the
// native plugin. Replace with the real package import for production.
import 'dart:typed_data';

class AssetSource {
  final String source;
  AssetSource(this.source);
}

class BytesSource {
  final Uint8List bytes;
  BytesSource(this.bytes);
}

enum ReleaseMode { loop, stop }

class AudioPlayer {
  Future<void> play(dynamic source) async {
    // `source` can be AssetSource or BytesSource; no-op here.
    return;
  }

  Future<void> setReleaseMode(ReleaseMode mode) async {
    return;
  }

  Future<void> setVolume(double volume) async {
    return;
  }

  Future<void> stop() async {
    return;
  }

  Future<void> release() async {
    return;
  }

  void dispose() {}
}
