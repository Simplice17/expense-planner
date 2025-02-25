import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/register_screen.dart'; // Import register screen
import 'providers/expense_provider.dart';
import 'providers/income_provider.dart';
import 'providers/debt_provider.dart';
import 'screens/add_expense_screen.dart';
import 'screens/add_income_screen.dart';
import 'screens/debts_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/statistics_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
        ChangeNotifierProvider(create: (_) => IncomeProvider()),
        ChangeNotifierProvider(create: (_) => DebtProvider()),

      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: _buildHomeScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/addExpense': (context) => AddExpenseScreen(),
        '/addIncome': (context) => AddIncomeScreen(),
        '/debts': (context) => DebtsScreen(),
        '/calendar': (context) => CalendarScreen(),
        '/statistics': (context) => StatisticsScreen(),
        '/settings': (context) => SettingsScreen(),
        '/profile': (context) => ProfileScreen(),
        '/register': (context) => RegisterScreen(), // Add Register Screen route
      },
    );
  }

  // This method will check whether the user is logged in or not and direct accordingly
  Widget _buildHomeScreen() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),  // Listen for auth state changes
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());  // Show loading indicator
        }

        if (snapshot.hasData) {
          // If the user is logged in, show HomeScreen
          return HomeScreen();
        } else {
          // If the user is not logged in, show RegisterScreen or LoginScreen
          return LoginScreen();  // Navigate to Login screen if not logged in
        }
      },
    );
  }
} 