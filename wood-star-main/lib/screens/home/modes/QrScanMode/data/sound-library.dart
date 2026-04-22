import 'package:wood_star_app/screens/home/modes/QrScanMode/data/sound-item.dart';

class SoundLibrary {
  static const List<SoundItem> sounds = [
    SoundItem(
      id: "SND001",
      title: "Bensaw fair wood cropped",
      asset: "assets/sounds/bensaw-fair-wood_cropped.mp3",
      points: 10,
    ),
    SoundItem(
      id: "SND002",
      title: "Chipboard circular saw cropped",
      asset: "assets/sounds/chipboard-circular-saw_cropped.mp3",
      points: 15,
    ),
    SoundItem(
      id: "SND003",
      title: "Cordless screw drawer sound file 2",
      asset: "assets/sounds/Cordless screw drawer sound file 2.m4a",
      points: 20,
    ),
    SoundItem(
      id: "SND004",
      title: "Cordless screw drawer",
      asset: "assets/sounds/Cordless screw drawer.m4a",
      points: 12,
    ),
    SoundItem(
      id: "SND005",
      title: "Drilling chipboard cropped",
      asset: "assets/sounds/drilling-chipboard_cropped.mp3",
      points: 18,
    ),

    SoundItem(
      id: "SND006",
      title: "Drilling fair wood cropped",
      asset: "assets/sounds/drilling-fair-wood_cropped.mp3",
      points: 30,
    ),
    SoundItem(
      id: "SND007",
      title: "Drilling machinefair wood cropped",
      asset: "assets/sounds/drilling-machinefair-wood_cropped.mp3",
      points: 45,
    ),
    SoundItem(
      id: "SND008",
      title: "Drilling oak tree cropped",
      asset: "assets/sounds/drilling-oak-tree_cropped.mp3",
      points: 70,
    ),
    SoundItem(
      id: "SND009",
      title: "Drilling oak wood cropped",
      asset: "assets/sounds/drilling-oak-wood_Cropped.m4a",
      points: 98,
    ),

    SoundItem(
      id: "SND0010",
      title: "Drilling chipboard cropped",
      asset: "assets/sounds/drilling-chipboard_cropped.mp3",
      points: 110,
    ),
    SoundItem(
      id: "SND0011",
      title: "Drilling with different tool cropped",
      asset: "assets/sounds/drilling-with-different-tool_cropped.mp3",
      points: 66,
    ),
  ];

  static int get totalRounds => sounds.length;

  /// QR id match
  static SoundItem? byId(String id) {
    try {
      return sounds.firstWhere((e) => e.id.toLowerCase() == id.toLowerCase());
    } catch (_) {
      return null;
    }
  }

  /// Index match (1-based: 1..N)
  static SoundItem? byIndex(int index1Based) {
    final i = index1Based - 1;
    if (i < 0 || i >= sounds.length) return null;
    return sounds[i];
  }
}
