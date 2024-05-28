part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardStateInitial extends DashboardState {}

final class DashboardStateLoaded extends DashboardState {
  final int menuIndex;

  DashboardStateLoaded({required this.menuIndex});
}
