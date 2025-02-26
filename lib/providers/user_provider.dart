import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  String _name = '';
  String _email = '';
  String _currency = 'USD';

  String get name => _name;
  String get email => _email;
  String get currency => _currency;

  // Load user data from SharedPreferences
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name') ?? '';
    _email = prefs.getString('email') ?? '';
    _currency = prefs.getString('currency') ?? 'USD';
    notifyListeners();
  }

  // Save user name and email
  Future<void> saveProfile(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    _name = name;
    _email = email;
    notifyListeners();
  }

  // Save currency preference
  Future<void> saveCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currency', currency);
    _currency = currency;
    notifyListeners();
  }

  // Clear user data (for logout)
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('currency');
    _name = '';
    _email = '';
    _currency = 'USD';
    notifyListeners();
  }
}