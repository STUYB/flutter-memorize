import 'package:isar/isar.dart';
import 'package:memorize/models/user.dart';

class UserRepository {
  late Isar db;

  UserRepository(isar) {
    db = isar;
  }

  Stream<void> notifyOnChange() => db.users.watchLazy();

  Future<List<User>> find(String username) async {
    return db.users.filter().usernameEqualTo(username).findAll();
  }

  Future<void> add(User user) async {
    return db.writeTxn(() async => db.users.put(user));
  }
}
