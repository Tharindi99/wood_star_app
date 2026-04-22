import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wood_star_app/controllers/picture-to-sound-controller.dart';
import 'package:wood_star_app/res/appRoutes/route-names.dart';
import 'package:wood_star_app/res/colors/colors.dart';
import 'package:wood_star_app/res/components/pictureToSound/image-widget.dart';
import 'package:wood_star_app/res/components/quiz/quiz_continue_overlay.dart';
import 'package:wood_star_app/res/components/pictureToSound/sound-hint-widget.dart';
import 'package:wood_star_app/res/components/soundtopicture/header.dart';

class PictureToSoundScreen extends StatelessWidget {
  PictureToSoundScreen({super.key});

  final PictureToSoundController controller = Get.put(
    PictureToSoundController(),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.stopAll();
        controller.resetQuiz();
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(() {
              final n = controller.soundOptions.length;
              final nameKeys = controller.soundNameKeys;
              final showPrompt = controller.showAdvancePrompt.value;
              final isLastRound = controller.currentRound.value >=
                  controller.totalRounds - 1;

              return Stack(
                children: [
                  Positioned.fill(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SoundToPictureHeader(
                            currentRound: controller.currentRound.value,
                            totalRounds: controller.totalRounds,
                            score: controller.score.value,
                            countdown: controller.countdown.value,
                            onHomeTap: () {
                              controller.stopAll();
                              Get.toNamed(RouteName.homeScreen);
                            },
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: (controller.currentRound.value + 1) /
                                  controller.totalRounds,
                              minHeight: 6,
                              backgroundColor: Colors.white24,
                              valueColor: const AlwaysStoppedAnimation(
                                Color(0xFFFF4F9A),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ImageCardWidget(imageUrl: controller.imagePath),
                          const SizedBox(height: 20),
                          Column(
                            children: List.generate(n, (index) {
                            final isSelected =
                                controller.selectedIndex.value == index;
                            final isCorrect =
                                index == (controller.data['correctIndex'] as int);

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? (isCorrect
                                        ? green.withOpacity(0.7)
                                        : optionsBorderColor)
                                    : Colors.grey[900],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: Row(
                                children: [
                                  Obx(() {
                                    final sound = controller.soundOptions[index];
                                    final isThisPlaying =
                                        controller.currentSound.value == sound &&
                                            controller.isPlaying.value;

                                    return Material(
                                      color: Colors.transparent,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white24,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () =>
                                              controller.playSound(sound),
                                          icon: Icon(
                                            isThisPlaying
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  8.horizontalSpace,
                                  Expanded(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () => controller.onOptionTap(index),
                                      child: Text(
                                        nameKeys[index].tr,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (controller.selectedIndex.value != -1 &&
                                      isSelected)
                                    Icon(
                                      isCorrect
                                          ? Icons.check_circle_rounded
                                          : Icons.cancel,
                                      color: isCorrect
                                          ? green
                                          : optionsBorderColor,
                                      size: 30,
                                    ),
                                ],
                              ),
                            );
                            }),
                          ),
                          6.verticalSpace,
                          const SoundHintWidget(),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  if (showPrompt)
                    Positioned.fill(
                      child: QuizContinueOverlay(
                        isLastRound: isLastRound,
                        onLetsGo: () {
                          unawaited(controller.acknowledgeAdvancePrompt());
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
