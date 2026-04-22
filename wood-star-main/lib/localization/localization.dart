import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    // ********* English ********** //
    'en_US': {
      // main screen
      'nickname_prompt': 'Enter your nickname',
      'nickname_hint': 'Your nickname',
      'description': 'Sound Learning Game for Wood Engineering Students',
      'start_playing': 'Start Playing',
      'rules_button': 'Rules & Settings',
      'sponsored': 'Sponsored by TH OWL',
      'rights': 'All rights reserved © TH OWL',
      'please_wait': 'Please wait...',
      // Rules Screen - welcome card
      'welcome_title': 'Welcome to Wood Star!',
      'welcome_subtitle': 'Turn up the volume and test your ears!',
      'welcome_description':
          'Wood Star is a fast-paced educational sound game designed for wood engineering students to recognize real woodworking machine and tool sounds.',

      // Rules Screen - how to play card
      'how_to_play_title': 'How to Play',
      'how_to_play_step_1': 'A woodworking machine or tool sound will play.',
      'how_to_play_step_2': 'Listen carefully — every detail matters!',
      'how_to_play_step_3':
          'Identify the correct machine or tool before the timer ends.',

      // Rules Screen - Beat Timer
      'beat_timer_title': 'Beat the Timer',
      'beat_timer_step_1': 'Each round has a countdown timer.',
      'beat_timer_step_2': 'Faster correct answers earn more points.',
      'beat_timer_step_3': 'Slower answers give fewer points.',
      'beat_timer_step_4':
          'Wrong answers earn zero points — but you can try again!',

      // Rules Screen - point leaderboard card
      'point_leaderboard_title': 'Points & Leaderboard',
      'point_leaderboard_step_1': 'Points are based on speed + accuracy.',
      'point_leaderboard_step_2': 'Higher scores move you up the leaderboard.',
      'point_leaderboard_step_3':
          'Compete with other students and become the ultimate Wood Star 🌟',

      // Rules Screen - Game Modes
      'game_modes_title': 'Game Modes Explained',
      'game_modes_subtitle': 'Master Machine Sounds.',
      'game_modes_des':
          'Practice real woodworking machine sounds to strengthen practical knowledge.',
      // Rules Screen - Learning Tip Card
      'learning_tip_title': 'Learning Tip',
      'learning_tip_des':
          'The more you play, the sharper your ears become — just like real workshop training!',
      // Rules Screen - Settings
      'settings_title': 'Settings',
      'settings_quiz_pause_title': 'Pause before next question',
      'settings_quiz_pause_subtitle':
          'When on, those modes pause and ask you to continue after each answer. Turn off to go to the next question automatically.',
      'settings_country_region': 'Country / Region Selection',
      'settings_language_selection': 'Language',
      // Home Screen - Header
      'home_header_title': 'Welcome back,',
      'home_title': 'Choose Game Mode',
      'home_subtitle': 'Master Woodworking Machine Sounds',
      'home_description': 'Sharpen your ears and master woodworking sounds.',

      // Home Screen - Qr Sound Hunt
      'qr_hunt_title': 'QR Sound Hunt',
      'qr_hunt_highlight': 'Scan. Listen. Guess.',
      'qr_hunt_description':
          'Scan the QR code, listen to the sound, and identify the correct machine or tool.',
      'qr_hunt_footer':
          'Train your ears and test your practical workshop knowledge.',
      // Home Screen - Sound to Picture
      'sound_to_picture_title': 'Sound to Picture',
      'sound_to_picture_highlight': 'Sound → Visual Match',
      'sound_to_picture_description':
          'Listen to the sound and choose the matching image of the machine or tool.',
      'sound_to_picture_footer':
          'Build strong sound recognition skills step by step.',
      'sound_to_pic_ready_next':
          'Are you ready for the next question?',
      'sound_to_pic_ready_finish':
          'Ready to see your results?',
      'sound_to_pic_lets_go': "Let's go",
      // Home Screen - Picture to Sound
      'picture_to_sound_title': 'Picture to Sound',
      'picture_to_sound_highlight': 'Visual → Sound Match',
      'picture_to_sound_description':
          'See the image and guess the sound it makes.',
      'picture_to_sound_footer':
          'Connect visual learning with real workshop experience.',
      'picture_to_sound_ready_next':
          'Are you ready for the next question?',
      'picture_to_sound_ready_finish':
          'Ready to see your results?',

      // Home Screen - Player Stats Card
      'player_stats_title': 'Player Stats',
      'games_played': 'Games Played',
      'wins': 'Wins',
      'total_score': 'Total Score',

      // Qr Scan Mode Screen
      'qr_round': 'Round',
      'qr_score': 'Score',
      'qr_instruction':
          'Scan the QR code to hear the machine sound. Identify the tool for points!',
      'qr_button_scan': 'Scan QR Code',
      'qr_frame_text': 'Position QR code in frame',

      // Sound Play Screen
      'sound_play_title': 'Now Playing',
      'sound_playing_track': 'Playing Track',
      'next_button_text': 'Next Round',
      'finish_button_text': 'Finish Game',

      // Success Screen – QR Sound Hunt
      'qr_hunt_success_title': 'QR Sound Hunt',
      'qr_hunt_success_msg': 'Good Work!',
      // Success Screen – mode subtitle (under main message)
      'sound_to_picture_success_title': 'Sound to Picture',
      'picture_to_sound_success_title': 'Picture to Sound',
      'success_score_text': 'Your Score',
      'play_again_button': 'Play Again',
      'manu_button_text': 'Back to Menu',
      'success_accuracy': 'Accuracy',
      'success_streak': 'Streak',
      'success_time': 'Time',

      // Leaderboard (local saved scores)
      'leaderboard_subtitle': 'Your scores from this device (all modes)',
      'leaderboard_by_mode': 'Points per mode',
      'leaderboard_total_score': 'Your total score',
      'player_default_name': 'Player',
      'leaderboard_you': 'You',
      'leaderboard_your_row': 'Your score',
      'leaderboard_no_players':
          'No players yet. Finish a game to build the local ranking.',
      'leaderboard_ranked_hint':
          'Everyone listed here has finished at least one game on this device.',
      'leaderboard_rankings_title': 'Local rankings',

      // Sound to Picture Mode
      'question_text': 'Question',
      'listening_text': 'Listen Carefully!',
      'subtitle_text': 'Which machine is this?',
      'replay_button': 'Replay Sound',

      // Picture to sound
      'pic_to_sound_title': 'Look at the Machine',
      'pic_to_sound_subtitle': 'Which sound does it make?',
      // Picture → Sound — option labels (asset → name)
      'snd_unknown': 'Unknown sound',
      'snd_bensaw_fair_wood': 'Bench saw (fair wood)',
      'snd_chipboard_circular_saw': 'Chipboard circular saw',
      'snd_cordless_screwdriver': 'Cordless screwdriver',
      'snd_cordless_screwdriver_alt': 'Cordless screwdriver (alt.)',
      'snd_drilling_chipboard': 'Drilling — chipboard',
      'snd_drilling_fair_wood': 'Drilling — fair wood',
      'snd_drilling_machine_fair_wood': 'Drilling machine — fair wood',
      'snd_drilling_oak_tree': 'Drilling — oak tree',
      'snd_drilling_oak_wood': 'Drilling — oak wood',
      'snd_drilling_different_tool': 'Drilling — different tool',
      'snd_drilling_with_fair_wood': 'Drilling with fair wood',
      'snd_edge_grinder': 'Edge grinder',
      'snd_electric_heater': 'Electric heater',
      'snd_hand_circular_saw': 'Hand circular saw',
      'snd_jigsaw': 'Jigsaw',
      'snd_lamello_cutter': 'Lamello cutter',
      'snd_milling_machine': 'Milling machine',
      'snd_nailing': 'Nailing',
      'snd_nailing_wood_piece': 'Nailing wood piece',
      'snd_oak_tree_circular_saw': 'Oak tree circular saw',
      'snd_planning_machine_beech': 'Planing machine — beech wood',
      'snd_planning_machine_2': 'Planing machine (2)',
      'snd_router': 'Router',
      'snd_sanding_fair_wood': 'Sanding — fair wood',
      'snd_table_milling_change_blade': 'Table milling — blade change',
      'snd_table_milling_machine': 'Table milling machine',
      'snd_veneer_press': 'Veneer press machine',
      'snd_vertical_panel_saw': 'Vertical panel saw',
      'snd_wet_grinding': 'Wet grinding machine',
      'snd_wide_belt_sander': 'Wide belt sander',
    },

    // ********** German Translations ********** //
    'de_DE': {
      // main screen
      'nickname_prompt': 'Geben Sie Ihren Spitznamen ein',
      'nickname_hint': 'Ihr Spitzname',
      'description': 'Sound-Lernspiel für Holzbauingenieur-Studierende',
      'start_playing': 'Spiel starten',
      'rules_button': 'Regeln & Einstellungen',
      'settings_quiz_pause_title': 'Pause vor der nächsten Frage',
      'settings_quiz_pause_subtitle':
          'Wenn an, musst du in Sound→Bild und Bild→Sound nach jeder Antwort auf „Los geht’s“ tippen. Aus, um automatisch weiterzugehen.',
      'sponsored': 'Gesponsert von TH OWL',
      'rights': 'Alle Rechte vorbehalten © TH OWL',
      'please_wait': 'Even geduld...',

      // Rules Screen – welcome card
      'welcome_title': 'Willkommen bei Wood Star!',
      'welcome_subtitle': 'Dreh die Lautstärke auf und teste dein Gehör!',
      'welcome_description':
          'Wood Star ist ein rasantes, edukatives Sound-Spiel für Studierende des Holzingenieurwesens, '
          'bei dem echte Geräusche von Holzbearbeitungsmaschinen und Werkzeugen erkannt werden müssen.',

      // Rules Screen – how to play card
      'how_to_play_title': 'So wird gespielt',
      'how_to_play_step_1':
          'Ein Geräusch einer Holzbearbeitungsmaschine oder eines Werkzeugs wird abgespielt.',
      'how_to_play_step_2': 'Hör genau hin – jedes Detail zählt!',
      'how_to_play_step_3':
          'Erkenne die richtige Maschine oder das richtige Werkzeug, bevor die Zeit abläuft.',

      // Rules Screen – Beat the Timer
      'beat_timer_title': 'Schlage die Zeit',
      'beat_timer_step_1': 'Jede Runde hat einen Countdown-Timer.',
      'beat_timer_step_2': 'Schnelle richtige Antworten bringen mehr Punkte.',
      'beat_timer_step_3': 'Langsamere Antworten geben weniger Punkte.',
      'beat_timer_step_4':
          'Falsche Antworten bringen keine Punkte – aber du kannst es erneut versuchen!',

      // Rules Screen – Point & Leaderboard
      'point_leaderboard_title': 'Punkte & Rangliste',
      'point_leaderboard_step_1':
          'Die Punkte basieren auf Geschwindigkeit und Genauigkeit.',
      'point_leaderboard_step_2':
          'Höhere Punktzahlen bringen dich in der Rangliste nach oben.',
      'point_leaderboard_step_3':
          'Tritt gegen andere Studierende an und werde der ultimative Wood Star 🌟',

      // Rules Screen - Game Modes
      'game_modes_title': 'Spielmodi erklärt',
      'game_modes_subtitle': 'Meistere Maschinengeräusche.',
      'game_modes_des':
          'Übe echte Geräusche von Holzbearbeitungsmaschinen, um dein praktisches Wissen zu stärken.',
      // Rules Screen - Learning Tip Card
      'learning_tip_title': 'Lerntipp',
      'learning_tip_des':
          'Je öfter du spielst, desto besser wird dein Gehör – genau wie beim echten Werkstatttraining!',

      // Rules Screen - Settings
      'settings_title': 'Einstellungen',
      'settings_country_region': 'Länder- / Regionsauswahl',
      'settings_language_selection': 'Sprachauswahl',

      // Home Screen – QR Sound Hunt
      'qr_hunt_title': 'QR-Soundjagd',
      'qr_hunt_highlight': 'Scannen. Hören. Raten.',
      'qr_hunt_description':
          'Scanne den QR-Code, höre dir das Geräusch an und erkenne die richtige Maschine oder das richtige Werkzeug.',
      'qr_hunt_footer':
          'Trainiere dein Gehör und teste dein praktisches Werkstattwissen.',
      // Home Screen
      'home_header_title': 'Willkommen zurück,',
      'home_title': 'Spielmodus wählen',
      'home_subtitle': 'Meistere Geräusche von Holzbearbeitungsmaschinen',
      'home_description':
          'Schärfe dein Gehör und beherrsche Holzbearbeitungsgeräusche.',

      // Home Screen – Sound to Picture
      'sound_to_picture_title': 'Sound zu Bild',
      'sound_to_picture_highlight': 'Sound → Bildabgleich',
      'sound_to_picture_description':
          'Höre dir das Geräusch an und wähle das passende Bild der Maschine oder des Werkzeugs aus.',
      'sound_to_picture_footer':
          'Baue Schritt für Schritt starke Fähigkeiten zur Geräuscherkennung auf.',
      'sound_to_pic_ready_next':
          'Bist du bereit für die nächste Frage?',
      'sound_to_pic_ready_finish':
          'Bereit für dein Ergebnis?',
      'sound_to_pic_lets_go': 'Los geht’s',

      // Home Screen – Picture to Sound
      'picture_to_sound_title': 'Bild zu Sound',
      'picture_to_sound_highlight': 'Bild → Soundabgleich',
      'picture_to_sound_description':
          'Sieh dir das Bild an und errate, welches Geräusch es erzeugt.',
      'picture_to_sound_footer':
          'Verbinde visuelles Lernen mit echter Werkstatterfahrung.',
      'picture_to_sound_ready_next':
          'Bist du bereit für die nächste Frage?',
      'picture_to_sound_ready_finish':
          'Bereit für dein Ergebnis?',
      // Home Screen - Player Stats Card
      'player_stats_title': 'Spielerstatistiken',
      'games_played': 'Gespeilte Spiele',
      'wins': 'Gewonnene Spiele',
      'total_score': 'Gesamtpunktzahl',

      // QR-Scan-Mode
      'qr_round': 'Runde',
      'qr_score': 'Punktestand',
      'qr_instruction':
          'Scanne den QR-Code, um das Maschinengeräusch zu hören. Erkenne das Werkzeug für Punkte!',
      'qr_button_scan': 'QR-Code scannen',
      'qr_frame_text': 'Positioniere den QR-Code im Rahmen',

      // Sound Play Screen
      'sound_play_title': 'Jetzt läuft',
      'sound_playing_track': 'Aktueller Sound',
      'next_button_text': 'Nächste Runde',
      'finish_button_text': 'Spiel beenden',
      // Success Screen – QR Sound Hunt
      'qr_hunt_success_title': 'QR-Soundjagd',
      'qr_hunt_success_msg': 'Gute Arbeit!',
      // Success Screen – mode subtitle (under main message)
      'sound_to_picture_success_title': 'Sound zu Bild',
      'picture_to_sound_success_title': 'Bild zu Sound',
      'success_score_text': 'Dein Punktestand',
      'play_again_button': 'Nochmal spielen',
      'manu_button_text': 'Zurück zum Menü',
      'success_accuracy': 'Genauigkeit',
      'success_streak': 'Serie',
      'success_time': 'Zeit',

      // Leaderboard (local saved scores)
      'leaderboard_subtitle':
          'Deine Punkte auf diesem Gerät (alle Modi)',
      'leaderboard_by_mode': 'Punkte pro Modus',
      'leaderboard_total_score': 'Deine Gesamtpunktzahl',
      'player_default_name': 'Spieler',
      'leaderboard_you': 'Du',
      'leaderboard_your_row': 'Dein Ergebnis',
      'leaderboard_no_players':
          'Noch keine Spieler. Beende ein Spiel für die lokale Rangliste.',
      'leaderboard_ranked_hint':
          'Alle hier haben auf diesem Gerät mindestens ein Spiel beendet.',
      'leaderboard_rankings_title': 'Lokale Rangliste',

      // Sound to Picture Mode
      'question_text': 'Frage',
      'listening_text': 'Hör gut zu!',
      'subtitle_text': 'Welche Maschine ist das?',
      'replay_button': 'Ton erneut abspielen',

      // Picture to sound
      'pic_to_sound_title': 'Sieh dir die Maschine an',
      'pic_to_sound_subtitle': 'Welches Geräusch macht sie?',
      // Picture → Sound — Bezeichnungen
      'snd_unknown': 'Unbekanntes Geräusch',
      'snd_bensaw_fair_wood': 'Tisch-/Bandsäge (Edelholz)',
      'snd_chipboard_circular_saw': 'Kreissäge — Spanplatte',
      'snd_cordless_screwdriver': 'Akku-Schrauber',
      'snd_cordless_screwdriver_alt': 'Akku-Schrauber (Variante)',
      'snd_drilling_chipboard': 'Bohren — Spanplatte',
      'snd_drilling_fair_wood': 'Bohren — Edelholz',
      'snd_drilling_machine_fair_wood': 'Bohrmaschine — Edelholz',
      'snd_drilling_oak_tree': 'Bohren — Eiche',
      'snd_drilling_oak_wood': 'Bohren — Eichenholz',
      'snd_drilling_different_tool': 'Bohren — anderes Werkzeug',
      'snd_drilling_with_fair_wood': 'Bohren mit Edelholz',
      'snd_edge_grinder': 'Kantenfräser / Kantenschleifer',
      'snd_electric_heater': 'Elektroheizer',
      'snd_hand_circular_saw': 'Handkreissäge',
      'snd_jigsaw': 'Stichsäge',
      'snd_lamello_cutter': 'Lamello-Fräse',
      'snd_milling_machine': 'Fräsmaschine',
      'snd_nailing': 'Nageln',
      'snd_nailing_wood_piece': 'Nageln — Holzstück',
      'snd_oak_tree_circular_saw': 'Kreissäge — Eichenholz',
      'snd_planning_machine_beech': 'Hobelmaschine — Buche',
      'snd_planning_machine_2': 'Hobelmaschine (2)',
      'snd_router': 'Oberfräse',
      'snd_sanding_fair_wood': 'Schleifen — Edelholz',
      'snd_table_milling_change_blade': 'Tischfräse — Wechselklinge',
      'snd_table_milling_machine': 'Tischfräsmaschine',
      'snd_veneer_press': 'Furnierpresse',
      'snd_vertical_panel_saw': 'Vertikale Plattenaufteilsäge',
      'snd_wet_grinding': 'Nassschleifmaschine',
      'snd_wide_belt_sander': 'Breitbandschleifer',
    },
  };
}
