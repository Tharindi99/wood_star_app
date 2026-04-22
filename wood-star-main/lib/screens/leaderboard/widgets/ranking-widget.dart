import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wood_star_app/res/colors/colors.dart';

/// Olympic-style podium: **left = 2nd**, **center = 1st**, **right = 3rd**.
class RankingWidget extends StatelessWidget {
  const RankingWidget({
    super.key,
    this.rankSecondName = '—',
    this.rankSecondScore = 0,
    this.rankFirstName = '—',
    this.rankFirstScore = 0,
    this.rankThirdName = '—',
    this.rankThirdScore = 0,
  });

  final String rankSecondName;
  final int rankSecondScore;
  final String rankFirstName;
  final int rankFirstScore;
  final String rankThirdName;
  final int rankThirdScore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: _stackItem(
                rakingContHeight: 70,
                topPosition: -60,
                rankNumber: '2',
                linearGradient: const LinearGradient(
                  colors: [Color(0xff577B8D), Color(0xffBCCCDC)],
                  begin: Alignment.centerLeft,
                ),
                borderColor: Colors.white,
                rankBorderColor: Colors.white,
                username: rankSecondName,
                totalScore: '$rankSecondScore',
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: _stackItem(
                rakingContHeight: 90,
                topPosition: -80,
                rankNumber: '1',
                linearGradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 194, 119, 15),
                    Color.fromARGB(255, 202, 169, 39),
                  ],
                  begin: Alignment.topCenter,
                ),
                borderColor: Colors.amber,
                rankBorderColor: Colors.amber,
                username: rankFirstName,
                totalScore: '$rankFirstScore',
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: _stackItem(
                rakingContHeight: 50,
                topPosition: -40,
                rankNumber: '3',
                linearGradient: const LinearGradient(
                  colors: [Color(0xffA62C2C), Color(0xffE6521F)],
                  begin: Alignment.centerLeft,
                ),
                borderColor: Colors.redAccent,
                rankBorderColor: Colors.redAccent,
                username: rankThirdName,
                totalScore: '$rankThirdScore',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _stackItem({
    required double rakingContHeight,
    required double topPosition,
    required String rankNumber,
    required Gradient linearGradient,
    required Color borderColor,
    required Color rankBorderColor,
    required String username,
    required String totalScore,
  }) {
    return SizedBox(
      width: 150,
      height: 140,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: rakingContHeight,
              decoration: BoxDecoration(
                gradient: linearGradient,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                border: Border(top: BorderSide(color: borderColor, width: 2)),
              ),
              alignment: Alignment.center,
              child: Text(
                rankNumber,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: topPosition,
            left: 0,
            right: 0,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1C),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: rankBorderColor, width: 0.4),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.piano, color: textPrimary),
                  6.verticalSpace,
                  Text(
                    username,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    totalScore,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (rankNumber == '1')
            Positioned(
              top: topPosition - 19,
              left: 0,
              right: 0,
              child: Center(child: Text('👑', style: TextStyle(fontSize: 30))),
            ),
        ],
      ),
    );
  }
}
