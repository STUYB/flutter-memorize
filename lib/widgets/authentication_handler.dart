import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';

class AuthenticationHandler extends StatelessWidget {
  final Widget authenticated;
  final Widget login;
  const AuthenticationHandler(
      {super.key, required this.authenticated, required this.login});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
      if (state is Authenticated || state is Registered) {
        return authenticated;
      }
      return login;
    });
  }
}
