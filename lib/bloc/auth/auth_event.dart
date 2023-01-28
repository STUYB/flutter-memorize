part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class TryAuthenticateEvent extends AuthEvent {
  final String username;
  final String password;
  TryAuthenticateEvent({required this.username, required this.password});
}

class AuthFailedEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class AuthSucceededEvent extends AuthEvent {
  final String username;
  AuthSucceededEvent({required this.username});
}

class TryRegisterEvent extends AuthEvent {
  final String username;
  final String password;
  TryRegisterEvent({required this.username, required this.password});
}
