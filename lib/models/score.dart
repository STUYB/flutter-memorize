import 'package:isar/isar.dart';

part 'score.g.dart';

@Collection()
class Score {
  Id id = Isar.autoIncrement;
  String username;
  int score;
  Score({required this.username, required this.score});
}
