import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/use_case/log_in_use_case.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{

  final LoginUsecase loginUsecase;
  final SharedPreferences prefs;

  AuthBloc(this.loginUsecase,this.prefs) : super(AuthInitial()){

    on<LoginRequested>(_onLogin);

    on<LogoutRequested>(_onLogout);

    on<CheckSession>(_onCheckSession);

  }

  Future<void> _onLogin(
      LoginRequested event,
      Emitter<AuthState> emit
      ) async {

    emit(AuthLoading());

    try{

      final user = await loginUsecase(
          event.username,
          event.password);

      await prefs.setBool("loggedIn", true);

      emit(AuthAuthenticated(user));

    }catch(e){

      emit(AuthError("Login Failed"));

    }

  }

  Future<void> _onLogout(
      LogoutRequested event,
      Emitter<AuthState> emit
      ) async {

    await prefs.clear();

    emit(AuthUnauthenticated());

  }

  void _onCheckSession(
      CheckSession event,
      Emitter<AuthState> emit
      ){

    final loggedIn = prefs.getBool("loggedIn") ?? false;

    if(loggedIn){
      emit(AuthAuthenticated as AuthState);
    }else{
      emit(AuthUnauthenticated());
    }

  }

}