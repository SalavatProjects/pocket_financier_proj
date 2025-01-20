import 'package:isar/isar.dart';

part 'money.g.dart';

@collection
class Money {
  Id id = Isar.autoIncrement;

  String? description;
  double? value;
  DateTime? date;
  bool? isIncome;
}