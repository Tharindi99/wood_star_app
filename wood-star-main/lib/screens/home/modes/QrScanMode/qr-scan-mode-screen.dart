// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:wood_star_app/res/appRoutes/route-names.dart';
// import 'package:wood_star_app/res/colors/colors.dart';
// import 'package:wood_star_app/res/components/buttons/home/scan-button.dart';

// class ScanQrScreen extends StatelessWidget {
//   const ScanQrScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final args = (Get.arguments as Map?) ?? {};
//     final int round = (args["round"] ?? 1) as int;
//     final int score = (args["score"] ?? 0) as int;
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             children: [
//               const SizedBox(height: 10),
//               buildHeader(round, score),
//               const SizedBox(height: 30),

//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [Color(0xFF0A0F14), Color(0xFF0E1621)],
//                     ),
//                     borderRadius: BorderRadius.circular(28),
//                     border: Border.all(color: Color(0xFF00C2D1), width: 0.5),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(
//                         Icons.qr_code_scanner_rounded,
//                         size: 64,
//                         color: Color(0xFF00C2D1),
//                       ),
//                       const SizedBox(height: 14),
//                       Text(
//                         "qr_frame_text".tr,
//                         style: TextStyle(
//                           color: Color(0xFF9AA7B2),
//                           fontSize: 16.sp,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 24),

//               ScanButton(
//                 onPressed: () {
//                   // Get.to(() => CameraScanScreen(round: round, score: score));
//                   Get.toNamed(
//                     RouteName.cameraScanScreen,
//                     arguments: {'round': round, 'score': score},
//                   );
//                 },
//               ),

//               16.verticalSpace,
//               bottomInfoCard(),
//               15.verticalSpace,
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildHeader(int round, int score) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         GestureDetector(
//           onTap: () => Get.toNamed(RouteName.homeScreen),
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
//               "${'qr_round'.tr} $round/5",
//               style: TextStyle(color: Colors.white, fontSize: 15.sp),
//             ),
//             Text(
//               "${'qr_score'.tr}: $score",
//               style: TextStyle(
//                 color: Color(0xFF00C2D1),
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

//   Widget bottomInfoCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
//       decoration: BoxDecoration(
//         color: const Color(0xFF0E1621),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: Colors.grey.shade400, width: 0.2),
//       ),
//       child: Text(
//         'qr_instruction'.tr,
//         textAlign: TextAlign.center,
//         style: TextStyle(color: Color(0xFF9AA7B2), fontSize: 14.sp),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wood_star_app/res/appRoutes/route-names.dart';
import 'package:wood_star_app/res/colors/colors.dart';
import 'package:wood_star_app/res/components/buttons/home/scan-button.dart';
import 'package:wood_star_app/screens/home/modes/QrScanMode/data/sound-library.dart';

class ScanQrScreen extends StatelessWidget {
  const ScanQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = (Get.arguments as Map?) ?? {};
    final int round = (args["round"] ?? 1) as int;
    final int score = (args["score"] ?? 0) as int;
    final int correctRounds = (args["correctRounds"] ?? 0) as int;
    final int currentStreak = (args["currentStreak"] ?? 0) as int;
    final int longestStreak = (args["longestStreak"] ?? 0) as int;
    final int startedAtMs =
        (args["startedAtMs"] ?? DateTime.now().millisecondsSinceEpoch) as int;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              buildHeader(round, score, longestStreak: longestStreak),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF0A0F14), Color(0xFF0E1621)],
                    ),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: const Color(0xFF00C2D1),
                      width: 0.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.qr_code_scanner_rounded,
                        size: 64,
                        color: Color(0xFF00C2D1),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        "qr_frame_text".tr,
                        style: TextStyle(
                          color: const Color(0xFF9AA7B2),
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ScanButton(
                onPressed: () {
                  Get.toNamed(
                    RouteName.cameraScanScreen,
                    arguments: {
                      'round': round,
                      'score': score,
                      'correctRounds': correctRounds,
                      'currentStreak': currentStreak,
                      'longestStreak': longestStreak,
                      'startedAtMs': startedAtMs,
                    },
                  );
                },
              ),
              16.verticalSpace,
              bottomInfoCard(),
              15.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(
    int round,
    int score, {
    int longestStreak = 0,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(RouteName.homeScreen),
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
              "${'qr_round'.tr} $round/${SoundLibrary.totalRounds}",
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
            ),
            Text(
              "${'qr_score'.tr}: $score",
              style: TextStyle(
                color: const Color(0xFF00C2D1),
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "${'success_streak'.tr}: $longestStreak",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(width: 42),
      ],
    );
  }

  Widget bottomInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1621),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade400, width: 0.2),
      ),
      child: Text(
        'qr_instruction'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(color: const Color(0xFF9AA7B2), fontSize: 14.sp),
      ),
    );
  }
}
