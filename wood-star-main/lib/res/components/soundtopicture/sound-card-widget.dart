import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wood_star_app/res/components/buttons/sound-replay-button.dart';
import 'package:wood_star_app/res/components/soundtopicture/audio-controls.dart';

// ignore: must_be_immutable
class SoundCardWidget extends StatelessWidget {
  final VoidCallback playSound; // replay button action (your old)
  final VoidCallback onPlayPauseTap; // ✅ new play/pause action
  final bool isPlaying; // ✅ new state
  final double audioControllValue;

  SoundCardWidget({
    super.key,
    required this.playSound,
    required this.onPlayPauseTap,
    required this.isPlaying,
    required this.audioControllValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF4B001F), Color(0xFF8B003A)],
        ),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white12,
            child: Icon(Icons.hearing, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            'listening_text'.tr,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'subtitle_text'.tr,
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
          const SizedBox(height: 16),

          /// ✅ Audio Controls with Play/Pause button
          Row(
            children: [
              InkWell(
                onTap: onPlayPauseTap,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white12,
                  ),
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
              8.horizontalSpace,
              Expanded(
                flex: 2,
                child: AudioControls(value: audioControllValue),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Replay button stays same
          SoundReplayButton(playSound: playSound),
        ],
      ),
    );
  }
}
