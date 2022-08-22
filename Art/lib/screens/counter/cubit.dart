import 'package:bloc/bloc.dart';

import 'state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState().init());

  ///自增
  void increment() => emit(state.clone()..count = ++state.count);
}
