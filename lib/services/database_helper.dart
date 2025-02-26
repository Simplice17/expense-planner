import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/expense.dart';
import '../models/income.dart';
import '../models/debt.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  // Expense Methods
  Future<void> addExpense(Expense expense) async {
    try {
      await _firestore.collection('expenses').add(expense.toMap());
    } catch (e) {
      print("Error adding expense: $e");
      throw Exception("Error adding expense: $e");
    }
  }

  Future<List<Expense>> getExpenses() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('expenses').get();
      return snapshot.docs
          .map((doc) => Expense.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print("Error getting expenses: $e");
      throw Exception("Error getting expenses: $e");
    }
  }

  Future<void> updateExpense(String id, Expense expense) async {
    try {
      await _firestore.collection('expenses').doc(id).update(expense.toMap());
    } catch (e) {
      print("Error updating expense: $e");
      throw Exception("Error updating expense: $e");
    }
  }

  Future<void> deleteExpense(String id) async {
    try {
      await _firestore.collection('expenses').doc(id).delete();
    } catch (e) {
      print("Error deleting expense: $e");
      throw Exception("Error deleting expense: $e");
    }
  }

  // Income Methods
  Future<void> addIncome(Income income) async {
    try {
      await _firestore.collection('income').add(income.toMap());
    } catch (e) {
      print("Error adding income: $e");
      throw Exception("Error adding income: $e");
    }
  }

  Future<List<Income>> getIncome() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('income').get();
      return snapshot.docs
          .map((doc) => Income.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print("Error getting income: $e");
      throw Exception("Error getting income: $e");
    }
  }

  // Debt Methods
  Future<void> addDebt(Debt debt) async {
    try {
      await _firestore.collection('debts').add(debt.toMap());
    } catch (e) {
      print("Error adding debt: $e");
      throw Exception("Error adding debt: $e");
    }
  }

  Future<List<Debt>> getDebts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('debts').get();
      return snapshot.docs
          .map((doc) => Debt.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print("Error getting debts: $e");
      throw Exception("Error getting debts: $e");
    }
  }

  Future<void> updateDebt(String id, Debt debt) async {
    try {
      await _firestore.collection('debts').doc(id).update(debt.toMap());
    } catch (e) {
      print("Error updating debt: $e");
      throw Exception("Error updating debt: $e");
    }
  }

  Future<void> deleteDebt(String id) async {
    try {
      await _firestore.collection('debts').doc(id).delete();
    } catch (e) {
      print("Error deleting debt: $e");
      throw Exception("Error deleting debt: $e");
    }
  }



  Future<void> deleteCategory(String id) async {
    try {
      await _firestore.collection('categories').doc(id).delete();
    } catch (e) {
      print("Error deleting category: $e");
      throw Exception("Error deleting category: $e");
    }
  }
}
