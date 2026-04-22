import 'dart:convert';
import 'package:wood_star_app/screens/home/modes/QrScanMode/data/sound-item.dart';
import 'package:wood_star_app/screens/home/modes/QrScanMode/data/sound-library.dart';

class QrSoundResolver {
  static SoundItem? resolveSound(String raw) {
    final s = raw.trim();
    if (s.isEmpty) return null;

    // ✅ JSON support
    try {
      final obj = jsonDecode(s);
      if (obj is Map) {
        final id = obj["soundId"] ?? obj["sound_id"] ?? obj["id"];
        if (id != null) return SoundLibrary.byId(id.toString());

        final idx = obj["index"] ?? obj["soundIndex"];
        if (idx != null) return SoundLibrary.byIndex(int.parse(idx.toString()));
      }
    } catch (_) {}

    // ✅ key/value support
    final m = RegExp(
      r'(soundId|sound_id|id)\s*[:=]\s*([A-Za-z0-9_-]+)',
    ).firstMatch(s);
    if (m != null) {
      return SoundLibrary.byId(m.group(2)!);
    }

    // ✅ pure number = index (1..N)
    final idx = int.tryParse(s);
    if (idx != null) return SoundLibrary.byIndex(idx);

    // ✅ fallback: treat as id
    return SoundLibrary.byId(s);
  }

  /// Optional: QR payload se round nikalna ho to
  static int? resolveRound(String raw) {
    final s = raw.trim();
    try {
      final obj = jsonDecode(s);
      if (obj is Map) {
        final r = obj["round"];
        if (r != null) return int.tryParse(r.toString());
      }
    } catch (_) {}
    return null;
  }
}
