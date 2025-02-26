import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../providers/income_provider.dart';
import '../widgets/expense_item.dart';
import '../services/auth_service.dart';
import '../widgets/income_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final incomeProvider = Provider.of<IncomeProvider>(context);

    final incomes = incomeProvider.income;
    final expenses = expenseProvider.expenses;

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Planner'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 📌 Income Section
            _buildSectionTitle('Income'),
            incomes.isEmpty
                ? _buildEmptyMessage("No income added yet!")
                : ListView.builder(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: incomes.length,
              itemBuilder: (context, index) {
                return IncomeItem(income: incomes[index]);
              },
            ),

            // 📌 Expense Section
            _buildSectionTitle('Expenses'),
            expenses.isEmpty
                ? _buildEmptyMessage("No expenses added yet!")
                : ListView.builder(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return ExpenseItem(expense: expenses[index]);
              },
            ),

          ],
        ),
      ),
      floatingActionButton: _buildFloatingButtons(context),
    );
  }

  // 🔹 Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 🔹 Empty Message Widget
  Widget _buildEmptyMessage(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          message,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }

  // 🔹 Floating Action Button for Adding Expense & Income
  Widget _buildFloatingButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'addIncome',
          onPressed: () {
            Navigator.pushNamed(context, '/addIncome');
          },
          backgroundColor: Colors.green,
          child: Icon(Icons.attach_money),
        ),
        SizedBox(width: 10),
        FloatingActionButton(
          heroTag: 'addExpense',
          onPressed: () {
            Navigator.pushNamed(context, '/addExpense');
          },
          backgroundColor: Colors.deepPurpleAccent,
          child: Icon(Icons.add),
        ),
      ],
    );
  }

  // 🔹 Sidebar Drawer
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Tikela"),
            accountEmail: Text("tikela@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/profile.png'),
            ),
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
          ),
          _buildDrawerItem(Icons.settings, "Settings", () {
            Navigator.pushNamed(context, '/settings');
          }),
          _buildDrawerItem(Icons.attach_money, "Add Income", () {
            Navigator.pushNamed(context, '/addIncome');
          }),
          _buildDrawerItem(Icons.add, "Add Expense", () {
            Navigator.pushNamed(context, '/addExpense');
          }),
          _buildDrawerItem(Icons.bar_chart, "Statistics", () {
            Navigator.pushNamed(context, '/statistics');
          }),
          _buildDrawerItem(Icons.calendar_today, "Calendar", () {
            Navigator.pushNamed(context, '/calendar');
          }),
          _buildDrawerItem(Icons.person, "Profile", () {
            Navigator.pushNamed(context, '/profile');
          }),
          Spacer(),
          _buildDrawerItem(Icons.logout, "Logout", () async {
            await AuthService().signOut();
            Navigator.pushReplacementNamed(context, '/login'); // Redirect to login
          }),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurpleAccent),
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}
