import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wood_star_app/res/appRoutes/route-names.dart';
import 'package:wood_star_app/res/assets/assets.dart';
import 'package:wood_star_app/screens/leaderboard/local_leaderboard_store.dart';
import 'package:wood_star_app/screens/rules_screen/quiz_flow_prefs.dart';

abstract class SoundToPicturePrefs {
  static const _p = 'sound_to_pic_';
  static const score = '${_p}score';
  static const accuracyPercent = '${_p}accuracy_percent';
  static const longestStreak = '${_p}longest_streak';
  static const timeSeconds = '${_p}time_seconds';
  static const correctRounds = '${_p}correct_rounds';
  static const totalRounds = '${_p}total_rounds';
}

class SoundToPictureController extends GetxController
    with WidgetsBindingObserver {
  static const int maxRounds = 10;
  static const int _countdownSeconds = 15;
  static const int _pointsPerCorrect = 10;

  final AudioPlayer player = AudioPlayer();

  final currentRound = 0.obs;
  final score = 0.obs;
  final selectedIndex = (-1).obs;

  final isPlaying = false.obs;
  final position = Duration.zero.obs;
  final duration = Duration.zero.obs;

  final countdown = _countdownSeconds.obs;
  bool hurrySnackShown = false;

  int correctRoundsCount = 0;
  int currentStreakCount = 0;
  int longestStreakCount = 0;

  final Stopwatch _quizStopwatch = Stopwatch();
  int _elapsedSecondsAtFinish = 0;

  bool _roundResolving = false;

  final showAdvancePrompt = false.obs;

  Timer? _timer;

  StreamSubscription<Duration?>? _durationSub;
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<PlayerState>? _playerStateSub;

  late final List<Map<String, dynamic>> quizData;

  static final List<String> _imagePool = [
    Assets.beachwoodMilingMachine,
    Assets.chipwoodCircularMachinePanelCut,
    Assets.cordlessScrewdriver,
    Assets.drillMachine,
    Assets.drillMachineFurWood,
    Assets.edgeGrinder,
    Assets.electricHeater,
    Assets.hammer,
    Assets.hammer1,
    Assets.handCircularSaw,
    Assets.handCircularSaw1,
    Assets.handDrillMachine,
    Assets.handSand,
    Assets.hardwoodOkaTreeCicularCut,
    Assets.jigsawChipwood,
    Assets.lameloCutter,
    Assets.nailingWoodPiece,
    Assets.nailingWoodStickPiece,
    Assets.plannnigMachineBeechWood,
    Assets.rutter,
    Assets.softWoodForCrossCutCirular,
    Assets.tableMilingMachine,
    Assets.veneerPressMachine,
    Assets.wetGrindingMachine,
    Assets.wideBeltSander,
  ];

  static const List<Map<String, String>> _soundImagePairs = [
    {
      'sound': Assets.chipboardCircularSawCropped,
      'image': Assets.chipwoodCircularMachinePanelCut,
    },
    {'sound': Assets.cordlessScrewDrawer, 'image': Assets.cordlessScrewdriver},
    {
      'sound': Assets.drillingOakTreeCropped,
      'image': Assets.hardwoodOkaTreeCicularCut,
    },
    {'sound': Assets.edgeGrinderSound, 'image': Assets.edgeGrinder},
    {'sound': Assets.electricHeaterSound, 'image': Assets.electricHeater},
    {'sound': Assets.handCircularSawSound, 'image': Assets.handCircularSaw},
    {'sound': Assets.jigsawMachineCropped, 'image': Assets.jigsawChipwood},
    {'sound': Assets.lamelloCutterSound, 'image': Assets.lameloCutter},
    {'sound': Assets.nailingWoodPieceSound, 'image': Assets.nailingWoodPiece},
    {'sound': Assets.wideBeltSanderSound, 'image': Assets.wideBeltSander},
  ];

  List<Map<String, dynamic>> _buildQuizData() {
    final rng = Random();
    final pairs = List<Map<String, String>>.from(_soundImagePairs)
      ..shuffle(rng);

    return pairs.take(maxRounds).map((pair) {
      final correct = pair['image']!;
      final sound = pair['sound']!;
      final wrongs = _imagePool.where((p) => p != correct).toList()
        ..shuffle(rng);
      final options = <String>[correct, wrongs[0], wrongs[1], wrongs[2]]
        ..shuffle(rng);
      final correctIndex = options.indexOf(correct);
      return <String, dynamic>{
        'sound': sound,
        'correctIndex': correctIndex,
        'score': _pointsPerCorrect,
        'options': options,
      };
    }).toList();
  }

  Map<String, dynamic> get data => quizData[currentRound.value];
  List<dynamic> get options => (data['options'] as List);

  int get totalRounds => quizData.length;

  @override
  void onInit() {
    super.onInit();
    quizData = _buildQuizData();

    WidgetsBinding.instance.addObserver(this);

    _bindPlayerStreams();
    _quizStopwatch.start();
    _loadAndPlayRound();
    _startCountdown();
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
    if (player.playing) {
      await player.pause();
    }
    isPlaying.value = false;
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
        position.value = Duration.zero;
      } else {
        isPlaying.value = state.playing;
      }
    });
  }

  Future<void> _loadAndPlayRound() async {
    final sound = data['sound'] as String;
    await player.setAsset(sound);
    await player.seek(Duration.zero);
    await player.play();
    isPlaying.value = true;
  }

  void _startCountdown() {
    countdown.value = _countdownSeconds;
    hurrySnackShown = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;

        if (countdown.value == 8 && !hurrySnackShown) {
          hurrySnackShown = true;
          _showHurrySnack();
        }
      } else {
        timer.cancel();
        unawaited(_onCountdownExpired());
      }
    });
  }

  Future<void> _onCountdownExpired() async {
    if (selectedIndex.value != -1) return;
    await _resolveRound(wasCorrect: false, tappedIndex: null);
  }

  void _showHurrySnack() {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        '⏰ Hurry Up!',
        'Only a few seconds left!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.9),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
      );
    }
  }

  Future<void> playSound() async {
    await _loadAndPlayRound();
  }

  Future<void> togglePlayPause() async {
    if (isPlaying.value) {
      await player.pause();
      isPlaying.value = false;
    } else {
      if (position.value >= duration.value) {
        await player.seek(Duration.zero);
      }
      await player.play();
      isPlaying.value = true;
    }
  }

  void _applyAnswerStats({required bool wasCorrect}) {
    if (wasCorrect) {
      correctRoundsCount++;
      currentStreakCount++;
      if (currentStreakCount > longestStreakCount) {
        longestStreakCount = currentStreakCount;
      }
      final speedBonus = countdown.value.clamp(0, _countdownSeconds);
      score.value += _pointsPerCorrect + speedBonus;
    } else {
      currentStreakCount = 0;
    }
  }

  Future<void> _resolveRound({
    required bool wasCorrect,
    int? tappedIndex,
  }) async {
    if (selectedIndex.value != -1 || _roundResolving) return;
    _roundResolving = true;

    _timer?.cancel();

    if (tappedIndex != null) {
      selectedIndex.value = tappedIndex;
    }

    _applyAnswerStats(wasCorrect: wasCorrect);

    await Future.delayed(
      Duration(milliseconds: tappedIndex == null ? 400 : 700),
    );

    final showPrompt = await QuizFlowPrefs.getShowBetweenRoundPrompt();
    if (showPrompt) {
      showAdvancePrompt.value = true;
    } else {
      await _advanceAfterRoundResolved();
    }
    _roundResolving = false;
  }

  Future<void> _advanceAfterRoundResolved() async {
    final isLast = currentRound.value >= quizData.length - 1;

    if (!isLast) {
      currentRound.value++;
      selectedIndex.value = -1;
      position.value = Duration.zero;
      duration.value = Duration.zero;
      await playSound();
      _startCountdown();
    } else {
      await player.stop();
      isPlaying.value = false;
      _quizStopwatch.stop();
      _elapsedSecondsAtFinish = _quizStopwatch.elapsed.inSeconds;
      await persistSessionResults();
      _openSuccessScreen();
    }
  }

  /// Continues after the post-question prompt (next round or success screen).
  Future<void> acknowledgeAdvancePrompt() async {
    if (!showAdvancePrompt.value) return;
    showAdvancePrompt.value = false;
    await _advanceAfterRoundResolved();
  }

  Future<void> persistSessionResults() async {
    final prefs = await SharedPreferences.getInstance();
    final acc = totalRounds > 0
        ? ((correctRoundsCount * 100) / totalRounds).round()
        : 0;
    final elapsed = _elapsedSecondsAtFinish > 0
        ? _elapsedSecondsAtFinish
        : _quizStopwatch.elapsed.inSeconds;

    await prefs.setInt(SoundToPicturePrefs.score, score.value);
    await prefs.setInt(SoundToPicturePrefs.accuracyPercent, acc);
    await prefs.setInt(SoundToPicturePrefs.longestStreak, longestStreakCount);
    await prefs.setInt(SoundToPicturePrefs.timeSeconds, elapsed);
    await prefs.setInt(SoundToPicturePrefs.correctRounds, correctRoundsCount);
    await prefs.setInt(SoundToPicturePrefs.totalRounds, totalRounds);
    await LocalLeaderboardStore.upsertCurrentPlayerFromPrefs();
  }

  Map<String, dynamic> successArguments() {
    final elapsed = _elapsedSecondsAtFinish > 0
        ? _elapsedSecondsAtFinish
        : _quizStopwatch.elapsed.inSeconds;
    return {
      'pageType': 'sound-to-pic',
      'score': score.value,
      'totalRounds': totalRounds,
      'correctRounds': correctRoundsCount,
      'longestStreak': longestStreakCount,
      'timeSeconds': elapsed,
    };
  }

  void _openSuccessScreen() {
    Get.offNamed(RouteName.successScreen, arguments: successArguments());
  }

  Future<void> onOptionTap(int index) async {
    if (selectedIndex.value != -1) return;

    final correctIndex = data['correctIndex'] as int;
    final wasCorrect = index == correctIndex;
    await _resolveRound(wasCorrect: wasCorrect, tappedIndex: index);
  }

  void stopAll() {
    _timer?.cancel();
    showAdvancePrompt.value = false;
    player.stop();
    isPlaying.value = false;
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _durationSub?.cancel();
    _positionSub?.cancel();
    _playerStateSub?.cancel();
    player.dispose();
    super.onClose();
  }
}
