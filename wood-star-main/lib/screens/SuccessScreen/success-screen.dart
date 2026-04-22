// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:wood_star_app/res/appRoutes/route-names.dart';
// import 'package:wood_star_app/res/assets/assets.dart';
// import 'package:wood_star_app/res/components/buttons/successScreen/back-manu-button.dart';
// import 'package:wood_star_app/res/components/buttons/successScreen/play-again-button.dart'
//     show PlayAgainButton;
// import 'package:wood_star_app/res/components/successScreen/stat-box.dart';

// class SuccessScreen extends StatelessWidget {
//   // String pageType;
//   const SuccessScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final args = (Get.arguments as Map?) ?? {};
//     final String pageType = (args["pageType"] ?? "").toString();
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 18.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 /// Logo
//                 Image.asset(Assets.appLogo, width: 100.w, height: 100.h),

//                 16.verticalSpace,

//                 /// Main Card
//                 Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 20.w,
//                     vertical: 28.h,
//                   ),
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [Color(0xFF1E1E1E), Color(0xFF141414)],
//                     ),
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: Colors.grey.shade800, width: 1),
//                   ),
//                   child: Column(
//                     children: [
//                       /// Trophy
//                       Stack(
//                         alignment: Alignment.topRight,
//                         children: [
//                           Container(
//                             height: 76,
//                             width: 76,
//                             decoration: const BoxDecoration(
//                               color: Color(0xFF1E90FF),
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(
//                               Icons.emoji_events_rounded,
//                               color: Colors.white,
//                               size: 38,
//                             ),
//                           ),
//                           Positioned(
//                             right: -3,
//                             top: -4,
//                             child: Text("👏", style: TextStyle(fontSize: 30)),
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 18.h),

//                       /// Title
//                       Text(
//                         "qr_hunt_success_msg".tr,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 22,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),

//                       SizedBox(height: 6.h),

//                       Text(
//                         "qr_hunt_success_title".tr,
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       SizedBox(height: 22.h),

//                       /// Score Card
//                       Container(
//                         width: double.infinity,
//                         padding: EdgeInsets.symmetric(vertical: 18.h),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF2B2B2B),
//                           borderRadius: BorderRadius.circular(18),
//                           border: Border.all(
//                             color: Colors.grey.shade800,
//                             width: 1,
//                           ),
//                         ),
//                         child: Column(
//                           children: [
//                             Text(
//                               "success_score_text".tr,
//                               style: TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.star_rounded,
//                                   color: Color(0xFFFFC107),
//                                   size: 32,
//                                 ),
//                                 SizedBox(width: 6),
//                                 Text(
//                                   "278",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 17.sp,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),

//                       SizedBox(height: 22.h),

//                       /// Stats Row
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: StatBox(
//                               title: "success_accuracy".tr,
//                               value: "85%",
//                             ),
//                           ),
//                           5.horizontalSpace,
//                           Expanded(
//                             child: StatBox(
//                               title: "success_streak".tr,
//                               value: "3",
//                             ),
//                           ),
//                           5.horizontalSpace,
//                           Expanded(
//                             child: StatBox(
//                               title: "success_time".tr,
//                               value: "2:34",
//                             ),
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 26.h),

//                       /// Play Again Button
//                       PlayAgainButton(
//                         onPressed: () {
//                           if (pageType == 'qrScreen') {
//                             Get.offNamed(RouteName.qrScanModeScreen);
//                           } else if (pageType == 'sound-to-pic') {
//                             // Get.offAll(() => SoundToPictureScreen());
//                             Get.offNamed(RouteName.audioToPictureScreen);
//                           } else if (pageType == 'pic-to-sound') {
//                             Get.offNamed(RouteName.pictureToSound);
//                             // Get.offAll(() => PictureToSoundScreen());
//                           }
//                         },
//                       ),
//                       SizedBox(height: 14.h),
//                       BackManuButton(
//                         onPressed: () {
//                           Get.toNamed(RouteName.homeScreen);
//                         },
//                       ),

//                       /// Back to Menu
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wood_star_app/res/appRoutes/route-names.dart';
import 'package:wood_star_app/res/assets/assets.dart';
import 'package:wood_star_app/res/components/buttons/successScreen/back-manu-button.dart';
import 'package:wood_star_app/res/components/buttons/successScreen/play-again-button.dart'
    show PlayAgainButton;
import 'package:wood_star_app/res/components/successScreen/stat-box.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  /// Subtitle under [qr_hunt_success_msg] — depends on which mode finished.
  String _successModeSubtitleKey(String pageType) {
    switch (pageType) {
      case 'sound-to-pic':
        return 'sound_to_picture_success_title';
      case 'pic-to-sound':
        return 'picture_to_sound_success_title';
      case 'qrScreen':
      default:
        return 'qr_hunt_success_title';
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = (Get.arguments as Map?) ?? {};

    final String pageType = (args["pageType"] ?? "").toString();

    // ✅ dynamic values from arguments
    final int score = (args["score"] ?? 0) as int;
    final int totalRounds = (args["totalRounds"] ?? 5) as int;
    final int correctRounds = (args["correctRounds"] ?? 0) as int;
    final int longestStreak = (args["longestStreak"] ?? 0) as int;
    final int timeSeconds = (args["timeSeconds"] ?? 0) as int;

    final double acc = totalRounds > 0
        ? (correctRounds / totalRounds) * 100
        : 0;
    final String accuracyText = "${acc.clamp(0, 100).toStringAsFixed(0)}%";
    final String timeText = _formatDuration(Duration(seconds: timeSeconds));

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.appLogo, width: 100.w, height: 100.h),
                16.verticalSpace,

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 28.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF1E1E1E), Color(0xFF141414)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade800, width: 1),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            height: 76,
                            width: 76,
                            decoration: const BoxDecoration(
                              color: Color(0xFF1E90FF),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.emoji_events_rounded,
                              color: Colors.white,
                              size: 38,
                            ),
                          ),
                          const Positioned(
                            right: -3,
                            top: -4,
                            child: Text("👏", style: TextStyle(fontSize: 30)),
                          ),
                        ],
                      ),

                      SizedBox(height: 18.h),

                      Text(
                        "qr_hunt_success_msg".tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: 6.h),

                      Text(
                        _successModeSubtitleKey(pageType).tr,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 22.h),

                      // ✅ SCORE (dynamic)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 18.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2B2B2B),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.grey.shade800,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "success_score_text".tr,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Color(0xFFFFC107),
                                  size: 32,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "$score",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 22.h),

                      // ✅ STATS (dynamic)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: StatBox(
                              title: "success_accuracy".tr,
                              value: accuracyText,
                            ),
                          ),
                          5.horizontalSpace,
                          Expanded(
                            child: StatBox(
                              title: "success_streak".tr,
                              value: "$longestStreak",
                            ),
                          ),
                          5.horizontalSpace,
                          Expanded(
                            child: StatBox(
                              title: "success_time".tr,
                              value: timeText,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 26.h),

                      PlayAgainButton(
                        onPressed: () {
                          if (pageType == 'qrScreen') {
                            Get.offNamed(
                              RouteName.qrScanModeScreen,
                              arguments: {
                                'round': 1,
                                'score': 0,
                                'correctRounds': 0,
                                'currentStreak': 0,
                                'longestStreak': 0,
                                'startedAtMs':
                                    DateTime.now().millisecondsSinceEpoch,
                              },
                            );
                          } else if (pageType == 'sound-to-pic') {
                            Get.offNamed(RouteName.audioToPictureScreen);
                          } else if (pageType == 'pic-to-sound') {
                            Get.offNamed(RouteName.pictureToSound);
                          }
                        },
                      ),
                      SizedBox(height: 14.h),
                      BackManuButton(
                        onPressed: () => Get.toNamed(RouteName.homeScreen),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
