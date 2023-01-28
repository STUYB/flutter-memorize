part of 'game_bloc.dart';

@immutable
abstract class GameState {}

class GameInitial extends GameState {}

class GameStarted extends GameState {}

class GameEnded extends GameState {}
