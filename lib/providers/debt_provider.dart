import 'package:flutter/material.dart';
import '../models/debt.dart';
import '../services/database_helper.dart';

class DebtProvider with ChangeNotifier {
  List<Debt> _debts = [];

  List<Debt> get debts => _debts;

  Future<void> loadDebts() async {
    _debts = await DatabaseHelper().getDebts();
    notifyListeners();
  }

  Future<void> addDebt(Debt debt) async {
    await DatabaseHelper().addDebt(debt);
    await loadDebts();
  }
}