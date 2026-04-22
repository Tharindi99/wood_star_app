// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:get/get.dart';
// // import 'package:wood_star_app/controllers/qr-mode-controller.dart';
// // import 'package:wood_star_app/res/colors/colors.dart';

// // class SoundPlayScreen extends StatelessWidget {
// //   final int round;
// //   final int score;

// //   const SoundPlayScreen({super.key, required this.round, required this.score});

// //   @override
// //   Widget build(BuildContext context) {
// //     final SoundPlayController c = Get.put(
// //       SoundPlayController(round: round, score: score),
// //     );

// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             children: [
// //               _buildHeader(c),
// //               const SizedBox(height: 20),

// //               Container(
// //                 height: 260,
// //                 width: double.infinity,
// //                 decoration: BoxDecoration(
// //                   gradient: const LinearGradient(
// //                     colors: [Color(0xFF0A0F1F), Colors.black],
// //                     begin: Alignment.topLeft,
// //                     end: Alignment.bottomRight,
// //                   ),
// //                   borderRadius: BorderRadius.circular(20),
// //                   border: Border.all(color: globeBlue, width: 0.5),
// //                 ),
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     const Icon(Icons.volume_up, size: 64, color: globeBlue),
// //                     const SizedBox(height: 12),
// //                     Text(
// //                       "sound_play_title".tr,
// //                       style: const TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Text(
// //                       "Machine Sound - Round $round",
// //                       style: const TextStyle(color: globeBlue, fontSize: 14),
// //                     ),
// //                   ],
// //                 ),
// //               ),

// //               const SizedBox(height: 20),

// //               /// Audio Player Card (GetX)
// //               Container(
// //                 padding: const EdgeInsets.all(20),
// //                 decoration: BoxDecoration(
// //                   gradient: const LinearGradient(
// //                     colors: [Color(0xFF1A2238), Color(0xFF0E1425)],
// //                   ),
// //                   borderRadius: BorderRadius.circular(16),
// //                   border: Border.all(color: languagePurple, width: 0.2),
// //                 ),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Text(
// //                           "sound_playing_track".tr,
// //                           style: TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 16.sp,
// //                           ),
// //                         ),
// //                         Obx(() {
// //                           return GestureDetector(
// //                             onTap: c.togglePlayPause,
// //                             child: Icon(
// //                               c.isPlaying.value
// //                                   ? Icons.pause
// //                                   : Icons.play_arrow,
// //                               color: languagePurple,
// //                               size: 28.sp,
// //                             ),
// //                           );
// //                         }),
// //                       ],
// //                     ),
// //                     12.verticalSpace,

// //                     /// Progress (GetX)
// //                     Obx(() {
// //                       return ClipRRect(
// //                         borderRadius: BorderRadius.circular(5),
// //                         child: ShaderMask(
// //                           shaderCallback: (Rect bounds) {
// //                             return const LinearGradient(
// //                               colors: [Color(0xFF8E2DE2), Color(0xFFFF0080)],
// //                             ).createShader(bounds);
// //                           },
// //                           child: LinearProgressIndicator(
// //                             value: c.progress,
// //                             backgroundColor: Colors.white24,
// //                             minHeight: 7.0,
// //                             valueColor: const AlwaysStoppedAnimation(
// //                               Colors.white,
// //                             ),
// //                           ),
// //                         ),
// //                       );
// //                     }),
// //                   ],
// //                 ),
// //               ),

// //               14.verticalSpace,

// //               /// Next / Finish
// //               GestureDetector(
// //                 onTap: c.goNext,
// //                 child: Container(
// //                   height: 55,
// //                   width: double.infinity,
// //                   decoration: BoxDecoration(
// //                     gradient: const LinearGradient(
// //                       colors: [Color(0xFF00C853), Color(0xFF00A86B)],
// //                     ),
// //                     borderRadius: BorderRadius.circular(14),
// //                   ),
// //                   child: Center(
// //                     child: Text(
// //                       round < 5
// //                           ? "${'next_button_text'.tr} ↻"
// //                           : 'finish_button_text'.tr,
// //                       style: const TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),

// //               const Spacer(),
// //               _bottomInfoCard(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildHeader(SoundPlayController c) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         GestureDetector(
// //           onTap: c.goHome,
// //           child: Container(
// //             height: 46.h,
// //             width: 46.w,
// //             decoration: const BoxDecoration(
// //               gradient: LinearGradient(
// //                 colors: [Color(0xFF00B2DA), Color(0xFF2B85FC)],
// //               ),
// //               shape: BoxShape.circle,
// //             ),
// //             child: Icon(Icons.home_outlined, size: 25.w, color: textPrimary),
// //           ),
// //         ),
// //         Column(
// //           children: [
// //             Text(
// //               "${'qr_round'.tr} ${c.round}/5",
// //               style: TextStyle(color: Colors.white, fontSize: 15.sp),
// //             ),
// //             Text(
// //               "${'qr_score'.tr}: ${c.score}",
// //               style: TextStyle(
// //                 color: const Color(0xFF00C2D1),
// //                 fontSize: 15.sp,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(width: 42),
// //       ],
// //     );
// //   }

// //   Widget _bottomInfoCard() {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
// //       decoration: BoxDecoration(
// //         color: const Color(0xFF0E1621),
// //         borderRadius: BorderRadius.circular(14),
// //         border: Border.all(color: Colors.grey, width: 0.2),
// //       ),
// //       child: Text(
// //         'qr_instruction'.tr,
// //         textAlign: TextAlign.center,
// //         style: TextStyle(color: const Color(0xFF9AA7B2), fontSize: 14.sp),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:wood_star_app/controllers/qr-mode-controller.dart';
// import 'package:wood_star_app/res/colors/colors.dart';

// class SoundPlayScreen extends StatefulWidget {
//   const SoundPlayScreen({super.key});

//   @override
//   State<SoundPlayScreen> createState() => _SoundPlayScreenState();
// }

// class _SoundPlayScreenState extends State<SoundPlayScreen> {
//   late final SoundPlayController c;
//   late final int round;
//   late final int score;

//   @override
//   void initState() {
//     super.initState();

//     final args = (Get.arguments as Map?) ?? {};
//     round = (args["round"] ?? 1) as int;
//     score = (args["score"] ?? 0) as int;

//     if (Get.isRegistered<SoundPlayController>()) {
//       Get.delete<SoundPlayController>(force: true);
//     }

//     c = Get.put(SoundPlayController(round: round, score: score));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               _buildHeader(c),
//               const SizedBox(height: 20),

//               Container(
//                 height: 260,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF0A0F1F), Colors.black],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: globeBlue, width: 0.5),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.volume_up, size: 64, color: globeBlue),
//                     const SizedBox(height: 12),
//                     Text(
//                       "sound_play_title".tr,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       "Machine Sound - Round ${c.round}",
//                       style: const TextStyle(color: globeBlue, fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF1A2238), Color(0xFF0E1425)],
//                   ),
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: languagePurple, width: 0.2),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "sound_playing_track".tr,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16.sp,
//                           ),
//                         ),
//                         Obx(() {
//                           return GestureDetector(
//                             onTap: c.togglePlayPause,
//                             child: Icon(
//                               c.isPlaying.value
//                                   ? Icons.pause
//                                   : Icons.play_arrow,
//                               color: languagePurple,
//                               size: 28.sp,
//                             ),
//                           );
//                         }),
//                       ],
//                     ),
//                     12.verticalSpace,

//                     Obx(() {
//                       return ClipRRect(
//                         borderRadius: BorderRadius.circular(5),
//                         child: ShaderMask(
//                           shaderCallback: (Rect bounds) {
//                             return const LinearGradient(
//                               colors: [Color(0xFF8E2DE2), Color(0xFFFF0080)],
//                             ).createShader(bounds);
//                           },
//                           child: LinearProgressIndicator(
//                             value: c.progress, // <-- IMPORTANT
//                             backgroundColor: Colors.white24,
//                             minHeight: 7.0,
//                             valueColor: const AlwaysStoppedAnimation(
//                               Colors.white,
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   ],
//                 ),
//               ),

//               14.verticalSpace,

//               GestureDetector(
//                 onTap: c.goNext,
//                 child: Container(
//                   height: 55,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Color(0xFF00C853), Color(0xFF00A86B)],
//                     ),
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   child: Center(
//                     child: Text(
//                       c.round < 5
//                           ? "${'next_button_text'.tr} ↻"
//                           : 'finish_button_text'.tr,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               const Spacer(),
//               _bottomInfoCard(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(SoundPlayController c) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         GestureDetector(
//           onTap: c.goHome,
//           child: Container(
//             height: 46.h,
//             width: 46.w,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF00B2DA), Color(0xFF2B85FC)],
//               ),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(Icons.home_outlined, size: 25.w, color: textPrimary),
//           ),
//         ),
//         Column(
//           children: [
//             Text(
//               "${'qr_round'.tr} ${c.round}/5",
//               style: TextStyle(color: Colors.white, fontSize: 15.sp),
//             ),
//             Text(
//               "${'qr_score'.tr}: ${c.score}",
//               style: TextStyle(
//                 color: const Color(0xFF00C2D1),
//                 fontSize: 15.sp,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(width: 42),
//       ],
//     );
//   }

//   Widget _bottomInfoCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
//       decoration: BoxDecoration(
//         color: const Color(0xFF0E1621),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: Colors.grey, width: 0.2),
//       ),
//       child: Text(
//         'qr_instruction'.tr,
//         textAlign: TextAlign.center,
//         style: TextStyle(color: const Color(0xFF9AA7B2), fontSize: 14.sp),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wood_star_app/controllers/qr-mode-controller.dart';
import 'package:wood_star_app/res/appRoutes/route-names.dart';
import 'package:wood_star_app/res/colors/colors.dart';
import 'package:wood_star_app/screens/home/modes/QrScanMode/data/sound-library.dart';

class SoundPlayScreen extends StatefulWidget {
  const SoundPlayScreen({super.key});

  @override
  State<SoundPlayScreen> createState() => _SoundPlayScreenState();
}

class _SoundPlayScreenState extends State<SoundPlayScreen> {
  late final SoundPlayController controller;

  @override
  void initState() {
    super.initState();

    final args = (Get.arguments as Map?) ?? {};
    final int round = (args["round"] ?? 1) as int;
    final int score = (args["score"] ?? 0) as int;
    final String soundId = (args["soundId"] ?? "").toString();

    final int correctRounds = (args["correctRounds"] ?? 0) as int;
    final int currentStreak = (args["currentStreak"] ?? 0) as int;
    final int longestStreak = (args["longestStreak"] ?? 0) as int;
    final int startedAtMs =
        (args["startedAtMs"] ?? DateTime.now().millisecondsSinceEpoch) as int;

    final sound = SoundLibrary.byId(soundId);

    if (sound == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          "Sound not found",
          "This QR does not match any sound in the list",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        Get.offNamed(
          RouteName.qrScanModeScreen,
          arguments: {
            "round": round,
            "score": score,
            "correctRounds": correctRounds,
            "currentStreak": currentStreak,
            "longestStreak": longestStreak,
            "startedAtMs": startedAtMs,
          },
        );
      });
      return;
    }

    if (Get.isRegistered<SoundPlayController>()) {
      Get.delete<SoundPlayController>(force: true);
    }

    controller = Get.put(
      SoundPlayController(
        round: round,
        score: score,
        sound: sound,
        correctRounds: correctRounds,
        currentStreak: currentStreak,
        longestStreak: longestStreak,
        startedAtMs: startedAtMs,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SoundPlayController>()) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildHeader(controller),
              const SizedBox(height: 20),

              Container(
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0A0F1F), Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: globeBlue, width: 0.5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.volume_up, size: 64, color: globeBlue),
                    const SizedBox(height: 12),
                    Text(
                      "sound_play_title".tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // const SizedBox(height: 8),
                    // Text(
                    //   "${c.sound.title}  •  +${c.sound.points} pts",
                    //   style: const TextStyle(color: globeBlue, fontSize: 14),
                    // ),
                    // const SizedBox(height: 6),
                    // Text(
                    //   "ID: ${c.sound.id}",
                    //   style: const TextStyle(
                    //     color: Colors.white54,
                    //     fontSize: 12,
                    //   ),
                    // ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1A2238), Color(0xFF0E1425)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: languagePurple, width: 0.2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "sound_playing_track".tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                        Obx(() {
                          return GestureDetector(
                            onTap: controller.togglePlayPause,
                            child: Icon(
                              controller.isPlaying.value
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: languagePurple,
                              size: 28.sp,
                            ),
                          );
                        }),
                      ],
                    ),
                    12.verticalSpace,
                    Obx(() {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: [Color(0xFF8E2DE2), Color(0xFFFF0080)],
                            ).createShader(bounds);
                          },
                          child: LinearProgressIndicator(
                            value: controller.progress,
                            backgroundColor: Colors.white24,
                            minHeight: 7.0,
                            valueColor: const AlwaysStoppedAnimation(
                              Colors.white,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              14.verticalSpace,

              GestureDetector(
                onTap: controller.goNext,
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00C853), Color(0xFF00A86B)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      controller.round < controller.totalRounds
                          ? '${'next_button_text'.tr} ↻'
                          : '${'finish_button_text'.tr} ↻',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),
              _bottomInfoCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(SoundPlayController c) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: c.goHome,
          child: Container(
            height: 46.h,
            width: 46.w,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00B2DA), Color(0xFF2B85FC)],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.home_outlined, size: 25.w, color: textPrimary),
          ),
        ),
        Column(
          children: [
            Text(
              "${'qr_round'.tr} ${c.round}/${c.totalRounds}",
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
            ),
            Text(
              "${'qr_score'.tr}: ${c.score}",
              style: TextStyle(
                color: const Color(0xFF00C2D1),
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(width: 42),
      ],
    );
  }

  Widget _bottomInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1621),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey, width: 0.2),
      ),
      child: Text(
        'qr_instruction'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(color: const Color(0xFF9AA7B2), fontSize: 14.sp),
      ),
    );
  }
}
