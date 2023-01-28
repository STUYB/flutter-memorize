import 'package:isar/isar.dart';
import 'package:memorize/models/score.dart';

class ScoreRepository {
  late Isar db;

  ScoreRepository(isar) {
    db = isar;
  }

  Stream<void> notifyOnChange() => db.scores.watchLazy();

  Future<List<Score>> find(String username) async {
    return db.scores.filter().usernameEqualTo(username).findAll();
  }

  Future<List<Score>> getAll() async {
    return db.scores.where().findAll();
  }

  Future<void> add(Score score) async {
    return db.writeTxn(() async => db.scores.put(score));
  }
}
