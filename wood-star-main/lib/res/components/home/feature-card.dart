import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wood_star_app/res/colors/colors.dart';

class FeatureCard extends StatelessWidget {
  final Color glowColor;
  final Color iconBg;
  final IconData icon;
  final String title;
  final String titleEmoji;
  final String highlight;
  final String description;
  final String footer;
  final Color subtitleColor;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.glowColor,
    required this.iconBg,
    required this.icon,
    required this.title,
    required this.titleEmoji,
    required this.highlight,
    required this.description,
    required this.footer,
    required this.subtitleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.6),
            blurRadius: 0.5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          splashColor: glowColor.withOpacity(0.25),
          highlightColor: glowColor.withOpacity(0.08),
          onTap: onTap,
          child: Ink(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [bgPrimary, bgPrimary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: glowColor, width: 0.1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, size: 30, color: Colors.white),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(titleEmoji),
                        ],
                      ),
                      6.verticalSpace,
                      Text(
                        highlight,
                        style: TextStyle(
                          color: subtitleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.5,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          height: 1.5,
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        footer,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.45),
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
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
