import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocket_financier_proj/storages/models/money.dart';

abstract class AppIsarDatabase {
  static late final Isar _instance;

  static Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    return _instance = await Isar.open(
      [MoneySchema],
      directory: dir.path,
    );
  }

  static Future<List<Money>> getMoneys() async {
    return await _instance.writeTxn(
        () async => await _instance.moneys.where().findAll()
    );
  }

  static Future<void> addMoney(Money money) async {
    await _instance.writeTxn(() async => await _instance.moneys.put(money));
  }
}