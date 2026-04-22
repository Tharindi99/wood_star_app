import 'package:get/get.dart';
import 'package:wood_star_app/res/appRoutes/route-names.dart';
import 'package:wood_star_app/screens/SuccessScreen/success-screen.dart';
import 'package:wood_star_app/screens/home/homes-screen.dart';
import 'package:wood_star_app/screens/home/modes/Audio-to-Picture-Mode/audio-to-picture-mode.dart';
import 'package:wood_star_app/screens/home/modes/PictureToSound/picture-to-sound.dart';
import 'package:wood_star_app/screens/home/modes/QrScanMode/camera%20scan/camera-scan-screen.dart';
import 'package:wood_star_app/screens/home/modes/QrScanMode/qr-scan-mode-screen.dart';
import 'package:wood_star_app/screens/home/modes/QrScanMode/sound-play-screen.dart';
import 'package:wood_star_app/screens/leaderboard/leader-board-screen.dart';

import 'package:wood_star_app/screens/mainScreen/main-screen.dart';
import 'package:wood_star_app/screens/rules_screen/rules-screen.dart';

class AppRoutes {
  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: RouteName.mainScreen,
      page: () => const WoodStarWelcomeScreen(),
    ),
    GetPage(name: RouteName.rulesScreen, page: () => const RulesScreen()),
    GetPage(name: RouteName.homeScreen, page: () => HomeScreen()),

    GetPage(name: RouteName.qrScanModeScreen, page: () => const ScanQrScreen()),
    GetPage(
      name: RouteName.soundPlayScreen,
      page: () {
        return SoundPlayScreen();
      },
    ),
    GetPage(name: RouteName.cameraScanScreen, page: () => CameraScanScreen()),
    GetPage(
      name: RouteName.leaderBoardScreen,
      page: () => LeaderboardScreen(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: RouteName.audioToPictureScreen,
      page: () => SoundToPictureScreen(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: RouteName.pictureToSound,
      page: () => PictureToSoundScreen(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: RouteName.successScreen,
      page: () => SuccessScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
