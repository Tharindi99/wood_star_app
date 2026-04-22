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

abstract class PictureToSoundPrefs {
  static const _p = 'picture_to_sound_';
  static const score = '${_p}score';
  static const accuracyPercent = '${_p}accuracy_percent';
  static const longestStreak = '${_p}longest_streak';
  static const timeSeconds = '${_p}time_seconds';
  static const correctRounds = '${_p}correct_rounds';
  static const totalRounds = '${_p}total_rounds';
}

String pictureToSoundNameL10nKey(String assetPath) =>
    _soundPathToL10nKey[assetPath] ?? 'snd_unknown';

const Map<String, String> _soundPathToL10nKey = {
  Assets.bensawFairWoodCropped: 'snd_bensaw_fair_wood',
  Assets.chipboardCircularSawCropped: 'snd_chipboard_circular_saw',
  Assets.cordlessScrewDrawer: 'snd_cordless_screwdriver',
  Assets.cordlessScrewDrawerSoundFile2: 'snd_cordless_screwdriver_alt',
  Assets.drillingChipboardCropped: 'snd_drilling_chipboard',
  Assets.drillingFairWoodCropped: 'snd_drilling_fair_wood',
  Assets.drillingMachinefairWoodCropped: 'snd_drilling_machine_fair_wood',
  Assets.drillingOakTreeCropped: 'snd_drilling_oak_tree',
  Assets.drillingOakWoodCropped: 'snd_drilling_oak_wood',
  Assets.drillingWithDifferentToolCropped: 'snd_drilling_different_tool',
  Assets.drillingWithFairWoodCropped: 'snd_drilling_with_fair_wood',
  Assets.edgeGrinderSound: 'snd_edge_grinder',
  Assets.electricHeaterSound: 'snd_electric_heater',
  Assets.handCircularSawSound: 'snd_hand_circular_saw',
  Assets.jigsawMachineCropped: 'snd_jigsaw',
  Assets.lamelloCutterSound: 'snd_lamello_cutter',
  Assets.millingMachineCropped: 'snd_milling_machine',
  Assets.nailing: 'snd_nailing',
  Assets.nailingWoodPieceSound: 'snd_nailing_wood_piece',
  Assets.oaktreeCircularSawCropped: 'snd_oak_tree_circular_saw',
  Assets.planningMachine1BeachwoodCropped: 'snd_planning_machine_beech',
  Assets.planningMachine2Cropped: 'snd_planning_machine_2',
  Assets.rutterSound: 'snd_router',
  Assets.sandingFairwoodCropped: 'snd_sanding_fair_wood',
  Assets.tableMilingMachineChangeBlade: 'snd_table_milling_change_blade',
  Assets.tableMilingMachineSound: 'snd_table_milling_machine',
  Assets.veneerPressMachineSound: 'snd_veneer_press',
  Assets.verticalPanelSawCropped: 'snd_vertical_panel_saw',
  Assets.wetGrindingMachineSound: 'snd_wet_grinding',
  Assets.wideBeltSanderSound: 'snd_wide_belt_sander',
};

class PictureToSoundController extends GetxController
    with WidgetsBindingObserver {
  static const int maxRounds = 10;
  static const int _countdownSeconds = 15;
  static const int _pointsPerCorrect = 10;

  final AudioPlayer player = AudioPlayer();

  final currentRound = 0.obs;
  final score = 0.obs;
  final selectedIndex = (-1).obs;

  final isPlaying = false.obs;
  final currentSound = ''.obs;

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

  static final List<String> _soundPool = [
    Assets.bensawFairWoodCropped,
    Assets.chipboardCircularSawCropped,
    Assets.cordlessScrewDrawer,
    Assets.cordlessScrewDrawerSoundFile2,
    Assets.drillingChipboardCropped,
    Assets.drillingFairWoodCropped,
    Assets.drillingMachinefairWoodCropped,
    Assets.drillingOakTreeCropped,
    Assets.drillingOakWoodCropped,
    Assets.drillingWithDifferentToolCropped,
    Assets.drillingWithFairWoodCropped,
    Assets.edgeGrinderSound,
    Assets.electricHeaterSound,
    Assets.handCircularSawSound,
    Assets.jigsawMachineCropped,
    Assets.lamelloCutterSound,
    Assets.millingMachineCropped,
    Assets.nailing,
    Assets.nailingWoodPieceSound,
    Assets.oaktreeCircularSawCropped,
    Assets.planningMachine1BeachwoodCropped,
    Assets.planningMachine2Cropped,
    Assets.rutterSound,
    Assets.sandingFairwoodCropped,
    Assets.tableMilingMachineChangeBlade,
    Assets.tableMilingMachineSound,
    Assets.veneerPressMachineSound,
    Assets.verticalPanelSawCropped,
    Assets.wetGrindingMachineSound,
    Assets.wideBeltSanderSound,
  ];

  static const List<Map<String, String>> _imageSoundPairs = [
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
    final pairs = List<Map<String, String>>.from(_imageSoundPairs)
      ..shuffle(rng);

    return pairs.take(maxRounds).map((pair) {
      final correctSound = pair['sound']!;
      final image = pair['image']!;
      final wrongs = _soundPool.where((s) => s != correctSound).toList()
        ..shuffle(rng);
      final options = <String>[correctSound, wrongs[0], wrongs[1], wrongs[2]]
        ..shuffle(rng);
      final correctIndex = options.indexOf(correctSound);
      final nameKeys = options
          .map(pictureToSoundNameL10nKey)
          .toList(growable: false);
      return <String, dynamic>{
        'image': image,
        'sounds': options,
        'soundNameKeys': nameKeys,
        'correctIndex': correctIndex,
      };
    }).toList();
  }

  Map<String, dynamic> get data => quizData[currentRound.value];

  List<String> get soundOptions =>
      List<String>.from(data['sounds'] as List<dynamic>);

  List<String> get soundNameKeys =>
      List<String>.from(data['soundNameKeys'] as List<dynamic>);

  String get imagePath => data['image'] as String;

  int get totalRounds => quizData.length;

  @override
  void onInit() {
    super.onInit();
    quizData = _buildQuizData();

    WidgetsBinding.instance.addObserver(this);

    _bindPlayerStreams();
    _quizStopwatch.start();
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
        currentSound.value = '';
      } else {
        isPlaying.value = state.playing;
      }
    });
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

  Future<void> playSound(String assetPath) async {
    if (selectedIndex.value != -1) return;

    if (currentSound.value == assetPath) {
      if (isPlaying.value) {
        await player.pause();
        isPlaying.value = false;
      } else {
        await player.play();
        isPlaying.value = true;
      }
      return;
    }

    await player.stop();

    currentSound.value = assetPath;
    await player.setAsset(assetPath);
    await player.seek(Duration.zero);
    await player.play();
    isPlaying.value = true;
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

    await player.stop();
    isPlaying.value = false;
    currentSound.value = '';
    position.value = Duration.zero;
    duration.value = Duration.zero;

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
      _startCountdown();
    } else {
      _quizStopwatch.stop();
      _elapsedSecondsAtFinish = _quizStopwatch.elapsed.inSeconds;
      await persistSessionResults();
      _openSuccessScreen();
    }
  }

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

    await prefs.setInt(PictureToSoundPrefs.score, score.value);
    await prefs.setInt(PictureToSoundPrefs.accuracyPercent, acc);
    await prefs.setInt(PictureToSoundPrefs.longestStreak, longestStreakCount);
    await prefs.setInt(PictureToSoundPrefs.timeSeconds, elapsed);
    await prefs.setInt(PictureToSoundPrefs.correctRounds, correctRoundsCount);
    await prefs.setInt(PictureToSoundPrefs.totalRounds, totalRounds);
    await LocalLeaderboardStore.upsertCurrentPlayerFromPrefs();
  }

  Map<String, dynamic> successArguments() {
    final elapsed = _elapsedSecondsAtFinish > 0
        ? _elapsedSecondsAtFinish
        : _quizStopwatch.elapsed.inSeconds;
    return {
      'pageType': 'pic-to-sound',
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
    currentSound.value = '';
  }

  void resetQuiz() {
    showAdvancePrompt.value = false;
    currentRound.value = 0;
    selectedIndex.value = -1;
    score.value = 0;
    countdown.value = _countdownSeconds;
    correctRoundsCount = 0;
    currentStreakCount = 0;
    longestStreakCount = 0;
    _roundResolving = false;
    _elapsedSecondsAtFinish = 0;
    _quizStopwatch.reset();
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
