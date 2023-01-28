part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class StartGameEvent extends GameEvent {}

class EndGameEvent extends GameEvent {
  final String username;
  final int score;
  EndGameEvent({required this.username, required this.score});
}

class ReStartGameEvent extends GameEvent {}
