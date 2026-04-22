import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wood_star_app/res/appRoutes/route-names.dart';
import 'package:wood_star_app/res/colors/colors.dart';
import 'package:wood_star_app/res/components/home/feature-card.dart';
import 'package:wood_star_app/res/components/home/player-stats-card.dart';
import 'package:wood_star_app/screens/home/modes/PictureToSound/picture-to-sound.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = (Get.arguments as Map?) ?? {};
    final nickId = (args["nickname"] ?? "").toString().trim();

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
            child: Column(
              children: [
                if (nickId.isEmpty)
                  buildHeader(username: '')
                else
                  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream:
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(nickId)
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return buildHeader(username: 'Loading...');
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return buildHeader(username: nickId);
                      }
                      //
                      final data = snapshot.data!.data();
                      final username = (data?['nickname'] ?? nickId).toString();

                      return buildHeader(username: username);
                    },
                  ),

                const SizedBox(height: 20),

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text(
                            'home_description'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                            ),
                          ),
                          20.verticalSpace,
                          Text(
                            'home_title'.tr,
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          16.verticalSpace,
                          Text(
                            'home_subtitle'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xFF00E5FF),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          30.verticalSpace,

                          FeatureCard(
                            glowColor: const Color(0xFF00E5FF),
                            iconBg: const Color(0xFF0AA9C9),
                            subtitleColor: yellow,
                            icon: Icons.qr_code_scanner,
                            title: "qr_hunt_title".tr,
                            titleEmoji: "📱",
                            highlight: "qr_hunt_highlight".tr,
                            description: "qr_hunt_description".tr,
                            footer: "qr_hunt_footer".tr,
                            onTap: () {
                              Get.toNamed(
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
                            },
                          ),
                          16.verticalSpace,

                          FeatureCard(
                            subtitleColor: statusBarColor,
                            glowColor: const Color(0xFF9B5CFF),
                            iconBg: const Color(0xFFB455FF),
                            icon: Icons.hearing,
                            title: "sound_to_picture_title".tr,
                            titleEmoji: "🔊",
                            highlight: "sound_to_picture_highlight".tr,
                            description: "sound_to_picture_description".tr,
                            footer: "sound_to_picture_footer".tr,
                            onTap: () {
                              Get.toNamed(RouteName.audioToPictureScreen);
                            },
                          ),
                          16.verticalSpace,

                          FeatureCard(
                            subtitleColor: const Color(0xFFB455FF),
                            glowColor: const Color(0xFF2DFF9A),
                            iconBg: const Color(0xFF19C37D),
                            icon: Icons.remove_red_eye,
                            title: "picture_to_sound_title".tr,
                            titleEmoji: "🖼️",
                            highlight: "picture_to_sound_highlight".tr,
                            description: "picture_to_sound_description".tr,
                            footer: "picture_to_sound_footer".tr,
                            onTap: () {
                              Get.to(() => PictureToSoundScreen());
                            },
                          ),

                          20.verticalSpace,
                          PlayerStatsCard(),
                        ],
                      ),
                    ),
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

Widget buildHeader({required String? username}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        height: 50.h,
        width: 50.w,
        decoration: BoxDecoration(
          color: const Color(0xFF1C2536),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF00B2DA), Color(0xFF2B85FC)],
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.person_2_outlined, size: 30.w, color: textPrimary),
      ),
      16.horizontalSpace,

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'home_header_title'.tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xffE6E6E6),
              ),
            ),
            4.verticalSpace,
            Text(
              username ?? '',
              style: const TextStyle(fontSize: 14, color: Colors.white70),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),

      GestureDetector(
        onTap: () {
          Get.toNamed(RouteName.leaderBoardScreen);
        },
        child: Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: const Color(0xFF1C2536),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFD54F), Color(0xFFF79A19)],
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.emoji_events_outlined,
            size: 30.w,
            color: textPrimary,
          ),
        ),
      ),
    ],
  );
}
