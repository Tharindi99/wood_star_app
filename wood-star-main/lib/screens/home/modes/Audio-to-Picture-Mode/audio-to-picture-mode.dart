// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wood_star_app/controllers/sound-to-picture-controller.dart';
import 'package:wood_star_app/res/appRoutes/route-names.dart';
import 'package:wood_star_app/res/colors/colors.dart';
import 'package:wood_star_app/res/components/quiz/quiz_continue_overlay.dart';
import 'package:wood_star_app/res/components/soundtopicture/header.dart';
import 'package:wood_star_app/res/components/soundtopicture/quiz-option-widget.dart';
import 'package:wood_star_app/res/components/soundtopicture/sound-card-widget.dart';

class SoundToPictureScreen extends StatelessWidget {
  SoundToPictureScreen({super.key});

  final SoundToPictureController soundtoPicContr = Get.put(
    SoundToPictureController(),
  );

  double _audioProgress(SoundToPictureController c) {
    final dur = c.duration.value.inMilliseconds;
    if (dur <= 0) return 0.0;

    final pos = c.position.value.inMilliseconds;
    final v = pos / dur;
    if (v.isNaN || v.isInfinite) return 0.0;
    return v.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(() {
              final data = soundtoPicContr.data;
              final options = soundtoPicContr.options;
              final showPrompt = soundtoPicContr.showAdvancePrompt.value;
              final isLastRound = soundtoPicContr.currentRound.value >=
                  soundtoPicContr.totalRounds - 1;

              return Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      children: [
                        /// Top Bar
                        SoundToPictureHeader(
                    currentRound: soundtoPicContr.currentRound.value,
                    totalRounds: soundtoPicContr.totalRounds,
                    score: soundtoPicContr.score.value,
                    countdown: soundtoPicContr.countdown.value,
                          onHomeTap: () {
                            soundtoPicContr.stopAll();
                            Get.toNamed(RouteName.homeScreen);
                          },
                        ),

                        const SizedBox(height: 12),

                        /// Progress Bar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value:
                                (soundtoPicContr.currentRound.value + 1) /
                                soundtoPicContr.totalRounds,
                            minHeight: 6,
                            backgroundColor: Colors.white24,
                            valueColor: const AlwaysStoppedAnimation(
                              Color(0xFFFF4F9A),
                            ),
                          ),
                        ),

                        18.verticalSpace,

                        SoundCardWidget(
                          playSound: soundtoPicContr.playSound,
                          onPlayPauseTap: soundtoPicContr.togglePlayPause,
                          isPlaying: soundtoPicContr.isPlaying.value,
                          audioControllValue: _audioProgress(soundtoPicContr),
                        ),

                        18.verticalSpace,

                        /// Options Grid
                        Expanded(
                          child: GridView.builder(
                            itemCount: options.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                ),
                            itemBuilder: (context, index) {
                              final isSelected =
                                  soundtoPicContr.selectedIndex.value ==
                                      index;
                              final isCorrect =
                                  index == (data['correctIndex'] as int);

                              return QuizOptionTile(
                                index: index,
                                imageUrl: options[index],
                                isSelected: isSelected,
                                isCorrect: isCorrect,
                                green: green,
                                onTap: () => soundtoPicContr.onOptionTap(index),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (showPrompt)
                    Positioned.fill(
                      child: QuizContinueOverlay(
                        isLastRound: isLastRound,
                        messageKeyNext: 'sound_to_pic_ready_next',
                        messageKeyFinish: 'sound_to_pic_ready_finish',
                        iconNext: Icons.headphones_rounded,
                        iconFinish: Icons.flag_outlined,
                        onLetsGo: () {
                          unawaited(
                            soundtoPicContr.acknowledgeAdvancePrompt(),
                          );
                        },
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
