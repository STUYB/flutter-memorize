import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memorize/bloc/auth/auth_bloc.dart';
import 'package:memorize/bloc/game/game_bloc.dart';
import 'package:memorize/bloc/score/score_bloc.dart';
import 'package:memorize/data/score_repository.dart';
import 'package:memorize/data/user_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MemorizeBlocProvider extends StatelessWidget {
  final Widget child;
  const MemorizeBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = Provider.of<UserRepository>(context);
    ScoreRepository scoreRepository = Provider.of<ScoreRepository>(context);
    var localizer = AppLocalizations.of(context)!;
    return MultiBlocProvider(providers: [
      BlocProvider<AuthBloc>(
        create: (BuildContext _) => AuthBloc(userRepository, localizer),
      ),
      BlocProvider<GameBloc>(
          create: (BuildContext _) => GameBloc(scoreRepository, localizer)),
      BlocProvider<ScoreBloc>(
        create: (BuildContext _) => ScoreBloc(scoreRepository),
      )
    ], child: child);
  }
}
