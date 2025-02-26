import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Expense> get expenses => _expenses;

  ExpenseProvider() {
    fetchExpenses(); // Fetch data in real-time when provider is created
  }

  // Listen for real-time updates
  void fetchExpenses() {
    _firestore.collection('expenses').snapshots().listen((snapshot) {
      _expenses = snapshot.docs.map((doc) {
        return Expense.fromMap(doc.data(), doc.id);
      }).toList();
      notifyListeners(); // Notify UI to refresh
    });
  }

  // Add Expense to Firestore
  Future<void> addExpense(Expense expense) async {
    await _firestore.collection('expenses').add(expense.toMap());
  }
}
