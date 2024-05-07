part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent({
    required this.email,
    required this.password,
  });
}


final class AuthIsUserLoggedInEvent extends AuthEvent {}

final class AuthLogoutEvent extends AuthEvent {}