import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  ExpenseProvider() {
    _fetchExpenses();
  }

  void _fetchExpenses() {
    _firestore.collection('expenses').snapshots().listen((snapshot) {
      _expenses = snapshot.docs
          .map((doc) => Expense.fromMap(doc.data(), doc.id)) // ✅ Pass doc.id
          .toList();
      notifyListeners();
    });
  }


  Future<void> addExpense(Expense expense) async {
    await _firestore.collection('expenses').add(expense.toMap());
  }
}
