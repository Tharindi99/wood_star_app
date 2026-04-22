// import 'dart:async';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:wood_star_app/res/appRoutes/route-names.dart';

// class SoundPlayController extends GetxController with WidgetsBindingObserver {
//   final int round;
//   final int score;

//   SoundPlayController({required this.round, required this.score});

//   final AudioPlayer player = AudioPlayer();

//   final isPlaying = false.obs;
//   final position = Duration.zero.obs;
//   final duration = Duration.zero.obs;

//   StreamSubscription<Duration?>? _durationSub;
//   StreamSubscription<Duration>? _positionSub;
//   StreamSubscription<PlayerState>? _playerStateSub;

//   @override
//   void onInit() {
//     super.onInit();
//     WidgetsBinding.instance.addObserver(this);

//     _bindPlayerStreams();
//     _loadAndPlay();
//   }

//   void _bindPlayerStreams() {
//     _durationSub = player.durationStream.listen((d) {
//       duration.value = d ?? Duration.zero;
//     });

//     _positionSub = player.positionStream.listen((p) {
//       position.value = p;
//     });

//     _playerStateSub = player.playerStateStream.listen((state) {
//       if (state.processingState == ProcessingState.completed ||
//           state.processingState == ProcessingState.idle) {
//         isPlaying.value = false;
//       } else {
//         isPlaying.value = state.playing;
//       }
//     });
//   }

//   Future<void> _loadAndPlay() async {
//     await player.setAsset('assets/audios/sound.mp3');
//     await player.seek(Duration.zero);
//     await player.play();
//     isPlaying.value = true;
//   }

//   Future<void> togglePlayPause() async {
//     final dur = player.duration;
//     final pos = player.position;

//     if (player.playing) {
//       await player.pause();
//       isPlaying.value = false;
//     } else {
//       if (dur != null && pos >= dur) {
//         await player.seek(Duration.zero);
//       }
//       await player.play();
//       isPlaying.value = true;
//     }
//   }

//   double get progress {
//     final d = duration.value.inMilliseconds;
//     if (d <= 0) return 0.0;

//     final p = position.value.inMilliseconds;
//     final v = p / d;

//     if (v.isNaN || v.isInfinite) return 0.0;
//     return v.clamp(0.0, 1.0);
//   }

//   /// ✅ Pause sound when app minimizes/background
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused ||
//         state == AppLifecycleState.inactive ||
//         state == AppLifecycleState.detached) {
//       _pauseIfPlaying();
//     }
//   }

//   Future<void> _pauseIfPlaying() async {
//     if (player.playing) {
//       await player.pause();
//     }
//     isPlaying.value = false;
//   }

//   void goHome() {
//     player.stop();
//     Get.toNamed(RouteName.homeScreen);
//   }

//   Future<void> goNext() async {
//     await player.stop();

//     if (round < 5) {
//       Get.offNamed(
//         RouteName.qrScanModeScreen,
//         arguments: {"round": round + 1, "score": score},
//       );
//     } else {
//       Get.toNamed(
//         RouteName.successScreen,
//         arguments: {'pageType': 'sound-to-pic'},
//       );
//       // or Get.offNamed(RouteName.successScreen, arguments: {"pageType":"sound-to-pic"});
//     }
//   }

//   @override
//   void onClose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _durationSub?.cancel();
//     _positionSub?.cancel();
//     _playerStateSub?.cancel();
//     player.dispose();
//     super.onClose();
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wood_star_app/res/appRoutes/route-names.dart';
import 'package:wood_star_app/screens/home/modes/QrScanMode/data/sound-item.dart';
import 'package:wood_star_app/screens/home/modes/QrScanMode/data/sound-library.dart';
import 'package:wood_star_app/screens/leaderboard/local_leaderboard_store.dart';

abstract class QrSoundHuntPrefs {
  static const _p = 'qr_sound_hunt_';
  static const score = '${_p}score';
  static const accuracyPercent = '${_p}accuracy_percent';
  static const longestStreak = '${_p}longest_streak';
  static const timeSeconds = '${_p}time_seconds';
  static const correctRounds = '${_p}correct_rounds';
  static const totalRounds = '${_p}total_rounds';
}

Future<void> persistQrSoundHuntSession({
  required int score,
  required int totalRounds,
  required int correctRounds,
  required int longestStreak,
  required int timeSeconds,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final acc = totalRounds > 0
      ? ((correctRounds * 100) / totalRounds).round()
      : 0;

  await prefs.setInt(QrSoundHuntPrefs.score, score);
  await prefs.setInt(QrSoundHuntPrefs.accuracyPercent, acc);
  await prefs.setInt(QrSoundHuntPrefs.longestStreak, longestStreak);
  await prefs.setInt(QrSoundHuntPrefs.timeSeconds, timeSeconds);
  await prefs.setInt(QrSoundHuntPrefs.correctRounds, correctRounds);
  await prefs.setInt(QrSoundHuntPrefs.totalRounds, totalRounds);
  await LocalLeaderboardStore.upsertCurrentPlayerFromPrefs();
}

class SoundPlayController extends GetxController with WidgetsBindingObserver {
  final int round;
  final int score;

  final int correctRounds;
  final int currentStreak;
  final int longestStreak;
  final int startedAtMs;

  final SoundItem sound;

  SoundPlayController({
    required this.round,
    required this.score,
    required this.sound,
    required this.correctRounds,
    required this.currentStreak,
    required this.longestStreak,
    required this.startedAtMs,
  });

  final AudioPlayer player = AudioPlayer();

  final isPlaying = false.obs;
  final position = Duration.zero.obs;
  final duration = Duration.zero.obs;

  StreamSubscription<Duration?>? _durationSub;
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<PlayerState>? _playerStateSub;

  int get totalRounds => SoundLibrary.totalRounds;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    _bindPlayerStreams();
    _loadAndPlay(sound.asset);
  }

  void _bindPlayerStreams() {
    _durationSub = player.durationStream.listen((d) {
      duration.value = d ?? Duration.zero;
    });

    _positionSub = player.positionStream.listen((p) {
      position.value = p;
    });

    _playerStateSub = player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed ||
          state.processingState == ProcessingState.idle) {
        isPlaying.value = false;
      } else {
        isPlaying.value = state.playing;
      }
    });
  }

  Future<void> _loadAndPlay(String assetPath) async {
    try {
      await player.setAsset(assetPath);
      await player.seek(Duration.zero);
      await player.play();
      isPlaying.value = true;
    } catch (e) {
      isPlaying.value = false;
      Get.snackbar(
        "Audio Error",
        "Could not play: $assetPath\n${e.toString()}",
        backgroundColor: const Color(0xFFB00020),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }

  Future<void> togglePlayPause() async {
    final dur = player.duration;
    final pos = player.position;

    if (player.playing) {
      await player.pause();
      isPlaying.value = false;
    } else {
      if (dur != null && pos >= dur) {
        await player.seek(Duration.zero);
      }
      await player.play();
      isPlaying.value = true;
    }
  }

  double get progress {
    final d = duration.value.inMilliseconds;
    if (d <= 0) return 0.0;

    final p = position.value.inMilliseconds;
    final v = p / d;

    if (v.isNaN || v.isInfinite) return 0.0;
    return v.clamp(0.0, 1.0);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      _pauseIfPlaying();
    }
  }

  Future<void> _pauseIfPlaying() async {
    if (player.playing) await player.pause();
    isPlaying.value = false;
  }

  void goHome() {
    player.stop();
    Get.toNamed(RouteName.homeScreen);
  }

  Future<void> goNext() async {
    await player.stop();

    final expected = SoundLibrary.byIndex(round);
    final isCorrect = expected != null &&
        sound.id.toLowerCase() == expected.id.toLowerCase();

    final pointsEarned = isCorrect ? sound.points : 0;
    final updatedScore = score + pointsEarned;

    final updatedCorrectRounds = correctRounds + (isCorrect ? 1 : 0);
    final updatedCurrentStreak = isCorrect ? currentStreak + 1 : 0;
    final updatedLongestStreak = updatedCurrentStreak > longestStreak
        ? updatedCurrentStreak
        : longestStreak;

    final timeSeconds =
        ((DateTime.now().millisecondsSinceEpoch - startedAtMs) / 1000).floor();

    if (round < totalRounds) {
      Get.offNamed(
        RouteName.qrScanModeScreen,
        arguments: {
          "round": round + 1,
          "score": updatedScore,
          "correctRounds": updatedCorrectRounds,
          "currentStreak": updatedCurrentStreak,
          "longestStreak": updatedLongestStreak,
          "startedAtMs": startedAtMs,
        },
      );
    } else {
      await persistQrSoundHuntSession(
        score: updatedScore,
        totalRounds: totalRounds,
        correctRounds: updatedCorrectRounds,
        longestStreak: updatedLongestStreak,
        timeSeconds: timeSeconds,
      );

      Get.offNamed(
        RouteName.successScreen,
        arguments: {
          "pageType": "qrScreen",
          "score": updatedScore,
          "totalRounds": totalRounds,
          "correctRounds": updatedCorrectRounds,
          "longestStreak": updatedLongestStreak,
          "timeSeconds": timeSeconds,
        },
      );
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _durationSub?.cancel();
    _positionSub?.cancel();
    _playerStateSub?.cancel();
    player.dispose();
    super.onClose();
  }
}
