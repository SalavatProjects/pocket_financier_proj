part of 'money_cubit.dart';

class MoneyState extends Equatable {
  const MoneyState({
    this.id,
    this.description = '',
    this.value = 0,
    this.date,
    this.isIncome,
  });

  final int? id;
  final String description;
  final double value;
  final DateTime? date;
  final bool? isIncome;

  factory MoneyState.fromIsarModel(Money money) {
    return MoneyState(
      id: money.id,
      description: money.description ?? '',
      value: money.value ?? 0,
      date: money.date,
      isIncome: money.isIncome,
    );
  }

  @override
  List<Object?> get props => [id, description, value, date, isIncome];

  MoneyState copyWith({
    int? id,
    String? description,
    double? value,
    DateTime? date,
    bool? isIncome,
  }) {
    return MoneyState(
      id: id ?? this.id,
      description: description ?? this.description,
      value: value ?? this.value,
      date: date ?? this.date,
      isIncome: isIncome ?? this.isIncome,
    );
  }

  Money toIsarModel() {
    return Money()
      ..description = description
      ..value = value
      ..date = date
      ..isIncome = isIncome;
  }
}
