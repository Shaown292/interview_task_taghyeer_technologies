import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final LoginUseCase loginUseCase;
  final SharedPreferences prefs;

  AuthBloc(this.loginUseCase, this.prefs) : super(AuthInitial()) {

    on<LoginEvent>((event, emit) async {

      emit(AuthLoading());

      try {

        await loginUseCase(event.username, event.password);

        await prefs.setBool("loggedIn", true);

        emit(AuthAuthenticated());

      } catch (e) {

        emit(AuthError("Login failed"));

      }

    });

    on<CheckSessionEvent>((event, emit) {

      final logged = prefs.getBool("loggedIn") ?? false;

      if (logged) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }

    });

    on<LogoutEvent>((event, emit) async {

      await prefs.clear();
      emit(AuthUnauthenticated());

    });
  }
}