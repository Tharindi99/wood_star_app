import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homecontroller extends GetxController {
  final nickname = ''.obs;
  final isNicknameValid = false.obs;
  final isSavingNickname = false.obs;

  static const nicknameStorageKey = 'nickname';

  static const _prefKeyNickname = nicknameStorageKey;

  void updateNickname(String value) {
    final v = value.trim();
    nickname.value = v;

    final ok =
        v.isNotEmpty &&
        v.length >= 4 &&
        v.length <= 30 &&
        RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(v);

    isNicknameValid.value = ok;
  }

  // Save nickname
  Future<void> saveNickname(String nickName) async {
    final name = nickName.trim();
    updateNickname(name);

    if (!isNicknameValid.value) {
      throw Exception("Nickname invalid");
    }

    isSavingNickname.value = true;
    try {
      await FirebaseFirestore.instance.collection('users').doc(name).set({
        "nickname": name,
      }, SetOptions(merge: true));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKeyNickname, name);
    } catch (e) {
      rethrow;
    } finally {
      isSavingNickname.value = false;
    }
  }

  Future<String> getNameFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getString(_prefKeyNickname) ?? '').trim();
  }

  Future<String?> getNickNameFromFirestore(String nickId) async {
    final id = nickId.trim();
    if (id.isEmpty) return null;

    final snap =
        await FirebaseFirestore.instance.collection('users').doc(id).get();

    if (!snap.exists) return null;
    return (snap.data()?['nickname'] as String?)?.trim();
  }
}
