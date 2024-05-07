import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_flutter/core/cubits/cubit/app_user_cubit.dart';
import 'package:westwind_flutter/core/entities/user.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/auth/domain/usecases/current_user.dart';
import 'package:westwind_flutter/features/auth/domain/usecases/user_login.dart';
import 'package:westwind_flutter/features/auth/domain/usecases/user_logout.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppUserCubit appUserCubit;
  final CurrentUserUseCase currentUser;
  final UserLoginUseCase userLogin;
  final UserLogoutUseCase userLogout;

  AuthBloc({
    required this.appUserCubit,
    required this.currentUser,
    required this.userLogin,
    required this.userLogout,
  }) : super(AuthStateInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthStateLoading());
    });
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthIsUserLoggedInEvent>(_onAuthIsUserLoggedIn);
    on<AuthLogoutEvent>(_onAuthLogout);
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

 // FutureOr<void> _onAuthIsUserLoggedIn(
   //   AuthIsUserLoggedInEvent event, Emitter<AuthState> emit) async {}

  FutureOr<void> _onAuthLogout(
      AuthLogoutEvent event, Emitter<AuthState> emit) async {
    final result = await userLogout(NoParams());

    result.fold(
      (failure) => emit(AuthStateFailure(failure.message)),
      (_) {
        appUserCubit.logout();
        emit(AuthStateInitial());
      },
    );
  }

  FutureOr<void> _onAuthIsUserLoggedIn(
    AuthIsUserLoggedInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await currentUser(NoParams());
    result.fold(
      (failure) => emit(AuthStateFailure(failure.message)),
      (user) { 
        appUserCubit.updateUser(user);
        emit( AuthStateSuccess(user) );  },
    );
  }
}
