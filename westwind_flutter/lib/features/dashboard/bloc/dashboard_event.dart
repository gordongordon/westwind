part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class DashboardMenuChange extends DashboardEvent {
   final int menuIndex;

   DashboardMenuChange( { required this.menuIndex });
}


