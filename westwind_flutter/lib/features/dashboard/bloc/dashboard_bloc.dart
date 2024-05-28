import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardStateInitial()) {
    on<DashboardMenuChange>((event, emit) {
         emit( DashboardStateLoaded( menuIndex: event.menuIndex ) );
    });
  }
}
