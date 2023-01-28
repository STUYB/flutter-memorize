import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:memorize/bloc/auth/auth_bloc.dart';
import 'package:memorize/bloc/score/score_bloc.dart';

class Skeleton extends StatelessWidget {
  final Widget child;
  const Skeleton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var localizer = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizer.appTitle,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 18,
            )),
        backgroundColor: Colors.grey.shade300,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.gamepad,
                color: Color.fromARGB(255, 91, 164, 93)),
            onPressed: () {
              GoRouter.of(context).push("/");
            },
          ),
          IconButton(
            icon: const Icon(Icons.scoreboard,
                color: Color.fromARGB(255, 94, 149, 194)),
            onPressed: () {
              BlocProvider.of<ScoreBloc>(context).add(LoadScoreEvent());
              GoRouter.of(context).push("/score");
            },
          ),
          IconButton(
            icon: const Icon(Icons.event,
                color: Color.fromARGB(255, 209, 114, 107)),
            onPressed: () {
              GoRouter.of(context).push("/event");
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout,
                color: Color.fromARGB(255, 98, 178, 244)),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
            },
          ),
        ],
      ),
      body: child,
    );
  }
}
