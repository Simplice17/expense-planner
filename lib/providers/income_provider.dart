import 'package:flutter/material.dart';
import '../models/income.dart';
import '../services/database_helper.dart';

class IncomeProvider with ChangeNotifier {
  List<Income> _income = [];

  List<Income> get income => _income;

  Future<void> loadIncome() async {
    _income = await DatabaseHelper().getIncome();
    notifyListeners();
  }

  Future<void> addIncome(Income income) async {
    await DatabaseHelper().addIncome(income);
    await loadIncome();
  }
}