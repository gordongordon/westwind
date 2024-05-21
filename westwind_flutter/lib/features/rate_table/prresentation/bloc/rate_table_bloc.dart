import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'rate_table_event.dart';
part 'rate_table_state.dart';

class RateTableBloc extends Bloc<RateTableEvent, RateTableState> {
  RateTableBloc() : super(RateTableInitial()) {
    on<RateTableEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
