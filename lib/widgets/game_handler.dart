import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memorize/bloc/game/game_bloc.dart';

class GameHandler extends StatelessWidget {
  final Widget start;
  final Widget game;
  final Widget end;
  const GameHandler(
      {super.key, required this.start, required this.game, required this.end});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(builder: (_, state) {
      if (state is GameStarted) {
        return game;
      } else if (state is GameEnded) {
        return end;
      }
      return start;
    });
  }
}
