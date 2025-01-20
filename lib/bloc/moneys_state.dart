part of 'moneys_cubit.dart';

class MoneysState extends Equatable {
  const MoneysState({
    this.moneys = const [],
  });

  final List<MoneyState> moneys;

  @override
  List<Object?> get props => [moneys];

  MoneysState copyWith({
    List<MoneyState>? moneys,
  }) {
    return MoneysState(
      moneys: moneys ?? this.moneys,
    );
  }
}