part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  String get reason => "";
  String get username => "";
}

class Authenticated extends AuthState {
  @override
  final String username;
  Authenticated({required this.username});
}

class NotAuthenticated extends AuthState {}

class FailedAuthentication extends AuthState {
  @override
  final String reason;
  FailedAuthentication({required this.reason});
}

class FailedRegistration extends AuthState {
  @override
  final String reason;
  FailedRegistration({required this.reason});
}

class Registered extends AuthState {
  @override
  final String username;
  Registered({required this.username});
}

class AuthLoading extends AuthState {}
