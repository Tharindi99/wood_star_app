// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
// import 'package:wood_star_app/res/appRoutes/route-names.dart';

// class QRScannerController extends GetxController {
//   QRViewController? qrController;

//   final isCheckingPermission = true.obs;
//   final hasPermission = false.obs;

//   bool isNavigated = false;

//   @override
//   void onInit() {
//     super.onInit();
//     _checkCameraPermission();
//   }

//   /// 🔐 Check permission
//   Future<void> _checkCameraPermission() async {
//     isCheckingPermission.value = true;

//     final status = await Permission.camera.status;

//     if (status.isGranted) {
//       hasPermission.value = true;
//     } else if (status.isDenied) {
//       hasPermission.value = false;
//     } else if (status.isPermanentlyDenied) {
//       hasPermission.value = false;
//     }

//     isCheckingPermission.value = false;
//   }

//   /// 🔁 Retry permission when button pressed
//   Future<void> retryPermission() async {
//     isCheckingPermission.value = true;

//     final status = await Permission.camera.request();

//     if (status.isGranted) {
//       hasPermission.value = true;
//     } else {
//       hasPermission.value = false;
//     }

//     isCheckingPermission.value = false;
//   }

//   /// 📷 QR init
//   void onQRViewCreated(
//     QRViewController controller, {
//     required int round,
//     required int score,
//   }) {
//     qrController = controller;

//     controller.scannedDataStream.listen((scanData) {
//       if (!isNavigated && scanData.code != null) {
//         isNavigated = true;
//         qrController?.pauseCamera();

//         // Get.off(() => SoundPlayScreen(round: round, score: score));
//         Get.offNamed(
//           RouteName.soundPlayScreen,
//           arguments: {"round": round, "score": score},
//         );
//       }
//     });
//   }

//   @override
//   void onClose() {
//     qrController?.dispose();
//     super.onClose();
//   }
// }

import 'dart:async';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:wood_star_app/res/appRoutes/route-names.dart';
import 'package:wood_star_app/screens/home/modes/QrScanMode/data/qr-sound-resolver.dart';

class QRScannerController extends GetxController {
  QRViewController? qrController;

  final isCheckingPermission = true.obs;
  final hasPermission = false.obs;

  bool isNavigated = false;

  StreamSubscription<Barcode>? _scanSub;


  String? _lastRaw;
  DateTime? _lastAt;

  @override
  void onInit() {
    super.onInit();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    isCheckingPermission.value = true;

    final status = await Permission.camera.status;

    if (status.isGranted) {
      hasPermission.value = true;
    } else {
      // denied / restricted / limited / permanentlyDenied
      hasPermission.value = false;
    }

    isCheckingPermission.value = false;
  }

 
  Future<void> retryPermission() async {
    isCheckingPermission.value = true;

    final status = await Permission.camera.request();

    hasPermission.value = status.isGranted;
    isCheckingPermission.value = false;
  }


  void onQRViewCreated(
    QRViewController controller, {
    required int round,
    required int score,
    int correctRounds = 0,
    int currentStreak = 0,
    int longestStreak = 0,
    required int startedAtMs,
  }) {
    qrController = controller;

  
    _scanSub?.cancel();
    isNavigated = false;

    _scanSub = controller.scannedDataStream.listen((scanData) async {
      final raw = (scanData.code ?? '').trim();
      if (raw.isEmpty) return;

      final now = DateTime.now();
      if (_lastRaw == raw &&
          _lastAt != null &&
          now.difference(_lastAt!) < const Duration(milliseconds: 900)) {
        return;
      }
      _lastRaw = raw;
      _lastAt = now;

      if (isNavigated) return;

      final sound = QrSoundResolver.resolveSound(raw);

      if (sound == null) {
        Get.snackbar(
          "Invalid QR",
          "This QR doesn't match any sound.",
          snackPosition: SnackPosition.BOTTOM,
        );
    
        return;
      }

      isNavigated = true;
      await qrController?.pauseCamera();

      Get.offNamed(
        RouteName.soundPlayScreen,
        arguments: {
          "round": round,
          "score": score,
          "soundId": sound.id,
          "qrRaw": raw,
          "correctRounds": correctRounds,
          "currentStreak": currentStreak,
          "longestStreak": longestStreak,
          "startedAtMs": startedAtMs,
        },
      );
    });
  }

  Future<void> resumeScanner() async {
    isNavigated = false;
    await qrController?.resumeCamera();
  }

  @override
  void onClose() {
    _scanSub?.cancel();
    qrController?.dispose();
    super.onClose();
  }
}
