#!/bin/bash

function create_audio_player_service(){
DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/widgets"
  AUDIO_PLAYER_SERVICE_FILE="$DEST_DIR/audio_player_service.dart"
  cat <<EOL > "$AUDIO_PLAYER_SERVICE_FILE"
import 'package:audioplayers/audioplayers.dart';

/// Utility class for audio playback using audioplayers package
class AudioPlayerService {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  /// Play an audio file from a local asset, file path, or remote URL
  static Future<void> play(
    String path, {
    bool isLocal = true,
    bool isAsset = false,
  }) async {
    if (isAsset) {
      await _audioPlayer.play(AssetSource(path.replaceFirst('assets/', '')));
    } else if (isLocal) {
      await _audioPlayer.play(DeviceFileSource(path));
    } else {
      await _audioPlayer.play(UrlSource(path));
    }
  }

  /// Pause the currently playing audio
  static Future<void> pause() async {
    await _audioPlayer.pause();
  }

  /// Resume the currently paused audio
  static Future<void> resume() async {
    await _audioPlayer.resume();
  }

  /// Stop the currently playing audio
  static Future<void> stop() async {
    await _audioPlayer.stop();
  }

  /// Seek to a specific position in the audio
  static Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  /// Set the volume (0.0 to 1.0)
  static Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  /// Release resources
  static Future<void> release() async {
    await _audioPlayer.release();
  }
}
EOL
 echo "📄 Created audio_player_service.dart file successfully at $AUDIO_PLAYER_SERVICE_FILE"
  echo "✅ Audio player service template generated successfully."
}
export -f create_audio_player_service
