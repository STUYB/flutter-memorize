import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:memorize/data/score_repository.dart';
import 'package:memorize/data/user_repository.dart';
import 'package:memorize/models/score.dart';
import 'package:memorize/models/user.dart';
import 'package:provider/provider.dart';

class RepoProvider extends StatelessWidget {
  final Widget child;
  const RepoProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Provider<Isar>(
        create: (context) => Isar.openSync([UserSchema, ScoreSchema]),
        child: MultiRepositoryProvider(providers: [
          RepositoryProvider<UserRepository>(
              create: (context) => UserRepository(context.read<Isar>())),
          RepositoryProvider<ScoreRepository>(
              create: (context) => ScoreRepository(context.read<Isar>()))
        ], child: child));
  }
}
