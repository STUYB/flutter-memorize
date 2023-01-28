import 'package:bloc/bloc.dart';
import 'package:memorize/models/user.dart';
import 'package:meta/meta.dart';
import 'package:memorize/data/user_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository userRepository;
  AppLocalizations localizer;
  AuthBloc(this.userRepository, this.localizer) : super(NotAuthenticated()) {
    // Attempt login
    on<TryAuthenticateEvent>((event, emit) async {
      emit(AuthLoading());
      // Check if values are correct
      String username = event.username;
      String password = event.password;
      List<User> users = await userRepository.find(username);
      bool userFound = users.isNotEmpty;
      if (userFound) {
        bool authenticated = users[0].password == password;
        if (authenticated) {
          emit(Authenticated(username: username));
        } else {
          emit(FailedAuthentication(reason: localizer.passwordIncorrect));
        }
      } else {
        emit(FailedAuthentication(reason: localizer.userDoesNotExist));
      }
    });
    // Login failed
    on<AuthFailedEvent>((event, emit) async {
      emit(NotAuthenticated());
    });
    // Login Succeeded
    on<AuthSucceededEvent>((event, emit) async {
      //
    });
    // Attempt Register
    on<TryRegisterEvent>((event, emit) async {
      emit(AuthLoading());
      // Check if values are correct
      String username = event.username;
      String password = event.password;
      List<User> users = await userRepository.find(username);
      bool userNotFound = users.isEmpty;
      if (userNotFound) {
        User newUser = User(username: username, password: password);
        await userRepository.add(newUser);
        emit(Registered(username: username));
      } else {
        emit(FailedRegistration(reason: localizer.userAlreadyExist));
      }
    });
    // Logout
    on<LogoutEvent>((event, emit) async {
      emit(NotAuthenticated());
    });
  }
}
