import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memorize/bloc/game/game_bloc.dart';
import 'package:memorize/game/game_engine.dart';
import 'package:memorize/widgets/game_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    var localizer = AppLocalizations.of(context)!;
    return Container(
        constraints: const BoxConstraints.expand(),
        child: Flexible(
          child: GameHandler(
              start: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<GameBloc>(context)
                              .add(StartGameEvent());
                        },
                        child: Container(
                            height: 100,
                            padding: const EdgeInsets.all(18),
                            margin: const EdgeInsets.symmetric(horizontal: 18),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 97, 156, 99),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                localizer.startGame,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ))),
                  ),
                ],
              ),
              game: const GameEngine(),
              end: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<GameBloc>(context)
                              .add(ReStartGameEvent());
                        },
                        child: Container(
                            height: 100,
                            padding: const EdgeInsets.all(18),
                            margin: const EdgeInsets.symmetric(horizontal: 18),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 116, 112, 188),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                localizer.restartGame,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ))),
                  ),
                ],
              )),
        ));
  }
}
