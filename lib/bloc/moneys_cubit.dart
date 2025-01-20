import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_financier_proj/bloc/money_cubit.dart';
import 'package:pocket_financier_proj/storages/isar.dart';

part 'moneys_state.dart';

class MoneysCubit extends Cubit<MoneysState> {
  MoneysCubit() : super(const MoneysState());

  Future<void> getMoneys() async {
    final moneys = await AppIsarDatabase.getMoneys();
    emit(state.copyWith(
      moneys: moneys.map((e) => MoneyState.fromIsarModel(e)).toList(),
    ));
  }

  Future<void> addMoney(MoneyState money) async {
    await AppIsarDatabase.addMoney(money.toIsarModel());
    await getMoneys();
  }
}
