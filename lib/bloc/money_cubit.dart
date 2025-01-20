import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_financier_proj/storages/models/money.dart';

part 'money_state.dart';

class MoneyCubit extends Cubit<MoneyState> {
  MoneyCubit({MoneyState? money}) : super(money ?? const MoneyState());

  void updateDescription(String value) {
    emit(state.copyWith(description: value));
  }

  void updateValue(double value) {
    emit(state.copyWith(value: value));
  }

  void updateDate(DateTime value) {
    emit(state.copyWith(date: value));
  }

  void updateIsIncome(bool value) {
    emit(state.copyWith(isIncome: value));
  }

  void clearData() {
    emit(const MoneyState(
      id: null,
      description: '',
      value: 0,
      date: null,
      isIncome: null,
    ));
  }
}
