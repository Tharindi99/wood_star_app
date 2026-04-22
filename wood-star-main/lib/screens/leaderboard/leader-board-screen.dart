import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wood_star_app/res/appRoutes/route-names.dart';
import 'package:wood_star_app/res/colors/colors.dart';
import 'package:wood_star_app/screens/leaderboard/leaderboard_scores.dart';
import 'package:wood_star_app/screens/leaderboard/local_leaderboard_store.dart';
import 'package:wood_star_app/screens/leaderboard/widgets/ranking-widget.dart';

// Dummy list reference (pre–local rankings UI): RockStar99, MusicQueen, JazzMaster,
// BeatDrop, MelodyKing, SoundWave, TuneHero, RhythmAce + you row — see git history.

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late final Future<
      ({LeaderboardScores scores, List<LocalLeaderboardEntry> ranked})> _dataFuture;
  late final String _nickArg;

  static const List<IconData> _rowIcons = [
    Icons.piano,
    Icons.piano,
    Icons.music_note,
    Icons.headphones,
    Icons.piano,
    Icons.music_note,
    Icons.mic,
    Icons.piano,
    Icons.person,
  ];

  @override
  void initState() {
    super.initState();
    final args = (Get.arguments as Map?) ?? {};
    _nickArg = (args['nickname'] ?? '').toString().trim();
    _dataFuture = Future.wait([
      LeaderboardScores.load(fallbackName: _nickArg),
      LocalLeaderboardStore.loadSortedByRank(),
    ]).then((list) {
      return (
        scores: list[0] as LeaderboardScores,
        ranked: list[1] as List<LocalLeaderboardEntry>,
      );
    });
  }

  String _userLabel(LeaderboardScores s) {
    if (s.displayName.isNotEmpty) return s.displayName;
    return 'player_default_name'.tr;
  }

  /// 1-based rank on the local board, or `null` if this nickname has no entry.
  int? _yourRank(List<LocalLeaderboardEntry> ranked, String meLower) {
    if (meLower.isEmpty) return null;
    for (var i = 0; i < ranked.length; i++) {
      if (ranked[i].nickname.toLowerCase() == meLower) return i + 1;
    }
    return null;
  }

  List<Map<String, dynamic>> _rankedAsRows({
    required List<LocalLeaderboardEntry> ranked,
    required String meLower,
  }) {
    return List.generate(ranked.length, (i) {
      final e = ranked[i];
      final icon = _rowIcons[i % _rowIcons.length];
      final isYou =
          meLower.isNotEmpty && e.nickname.toLowerCase() == meLower;
      return <String, dynamic>{
        'rank': i + 1,
        'name': e.nickname,
        'score': e.totalScore,
        'icon': icon,
        'isYou': isYou,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FutureBuilder<
            ({LeaderboardScores scores, List<LocalLeaderboardEntry> ranked})>(
          future: _dataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFFFC107)),
              );
            }

            final data = snapshot.data!;
            final stats = data.scores;
            final ranked = data.ranked;
            final userLabel = _userLabel(stats);
            final homeNick = stats.displayName.isNotEmpty
                ? stats.displayName
                : _nickArg;
            final meNick = stats.displayName.trim().isNotEmpty
                ? stats.displayName.trim()
                : _nickArg.trim();
            final meLower = meNick.toLowerCase();

            final rows = _rankedAsRows(ranked: ranked, meLower: meLower);
            final int? yourRank = _yourRank(ranked, meLower);

            final String n2 =
                ranked.length > 1 ? ranked[1].nickname : '—';
            final int s2 =
                ranked.length > 1 ? ranked[1].totalScore : 0;
            final String n1 =
                ranked.isNotEmpty ? ranked[0].nickname : '—';
            final int s1 =
                ranked.isNotEmpty ? ranked[0].totalScore : 0;
            final String n3 =
                ranked.length > 2 ? ranked[2].nickname : '—';
            final int s3 =
                ranked.length > 2 ? ranked[2].totalScore : 0;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  12.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.offNamed(
                          RouteName.homeScreen,
                          arguments: {'nickname': homeNick},
                        ),
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.home, color: Colors.white),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'Leaderboard',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          4.verticalSpace,
                          Text(
                            userLabel,
                            style: TextStyle(
                              color: const Color(0xFF00C2D1),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.emoji_events_outlined,
                        size: 30.w,
                        color: yellow,
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  Text(
                    'leaderboard_subtitle'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white54, fontSize: 13.sp),
                  ),
                  110.verticalSpace,
                  RankingWidget(
                    rankSecondName: n2,
                    rankSecondScore: s2,
                    rankFirstName: n1,
                    rankFirstScore: s1,
                    rankThirdName: n3,
                    rankThirdScore: s3,
                  ),
                  12.verticalSpace,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'leaderboard_your_row'.tr,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  8.verticalSpace,
                  _playerTile(
                    <String, dynamic>{
                      'rank': yourRank,
                      'name': userLabel,
                      'score': stats.totalScore,
                      'icon': Icons.person,
                      'isYou': true,
                    },
                  ),
                  12.verticalSpace,
                  if (ranked.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'leaderboard_no_players'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 14.sp,
                        ),
                      ),
                    )
                  else ...[
                    ...rows
                        .skip(3)
                        .where((p) => p['isYou'] != true)
                        .map((player) => _playerTile(player)),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _playerTile(Map<String, dynamic> player) {
    final isYou = player['isYou'] == true;
    final rankVal = player['rank'];
    final rankLabel = rankVal == null ? '—' : '$rankVal';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isYou ? const Color(0xFF00C2D1) : Colors.grey.shade800,
          width: isYou ? 1.2 : 1,
        ),
      ),
      child: Row(
        children: [
          Text(
            '#$rankLabel',
            style: TextStyle(
              color: isYou ? const Color(0xFF00C2D1) : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          Icon(player['icon'] as IconData, color: Colors.white, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        player['name'] as String,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (isYou) ...[
                      8.horizontalSpace,
                      Text(
                        "(${'leaderboard_you'.tr})",
                        style: TextStyle(
                          color: const Color(0xFF00C2D1),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ],
                ),
                if (player.containsKey('games') &&
                    (player['games'] as int) > 0)
                  Text(
                    '${player['games']} games',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.yellow, size: 18),
              const SizedBox(width: 4),
              Text(
                '${player['score']}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
