import 'package:shared_preferences/shared_preferences.dart';

abstract class QuizFlowPrefs {
  static const betweenRoundPromptKey = 'quiz_between_round_prompt_v1';

  static Future<bool> getShowBetweenRoundPrompt() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool(betweenRoundPromptKey) ?? true;
  }

  static Future<void> setShowBetweenRoundPrompt(bool value) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(betweenRoundPromptKey, value);
  }
}
