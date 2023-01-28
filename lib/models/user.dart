import 'package:isar/isar.dart';

part 'user.g.dart';

@Collection()
class User {
  Id id = Isar.autoIncrement;
  String username;
  String password;
  User({required this.username, required this.password});
}
