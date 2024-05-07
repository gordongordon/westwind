import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_flutter/core/entities/user.dart';
import 'package:westwind_flutter/features/auth/domain/usecases/user_login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLoginUseCase userLogin;

  AuthBloc({required this.userLogin}) : super(AuthStateInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthStateLoading());
    });
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthIsUserLoggedInEvent>(_onAuthIsUserLoggedIn);
  }

  FutureOr<void> _onAuthLogin(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    final result = await userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthStateFailure(failure.message)),
      (user) => emit(AuthStateSuccess(user)),
    );
  }

  FutureOr<void> _onAuthIsUserLoggedIn(AuthIsUserLoggedInEvent event, Emitter<AuthState> emit) async {
    
  }
}
