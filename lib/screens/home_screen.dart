import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../providers/debt_provider.dart';
import '../widgets/expense_item.dart';
import '../widgets/debt_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final debtProvider = Provider.of<DebtProvider>(context);
    final expenses = expenseProvider.expenses;
    final debts = debtProvider.debts;

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Planner'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          _buildSectionTitle('Expenses'),
          expenses.isEmpty
              ? Center(
            child: Text(
              "No expenses added yet!",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          )
              : ListView.builder(
            padding: EdgeInsets.all(10),
            shrinkWrap: true,
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              return ExpenseItem(expense: expenses[index]);
            },
          ),
          _buildSectionTitle('Debts'),
          debts.isEmpty
              ? Center(
            child: Text(
              "No debts added yet!",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          )
              : ListView.builder(
            padding: EdgeInsets.all(10),
            shrinkWrap: true,
            itemCount: debts.length,
            itemBuilder: (context, index) {
              return DebtItem(debt: debts[index]);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addExpense');
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Sidebar Drawer
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Simplice"),
            accountEmail: Text("john.doe@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/profile.png'),
            ),
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
          ),
          _buildDrawerItem(Icons.settings, "Settings", () {
            Navigator.pushNamed(context, '/settings');
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
          _buildDrawerItem(Icons.attach_money, "Add Income", () {
            Navigator.pushNamed(context, '/addIncome');
          }),
          Spacer(),
          _buildDrawerItem(Icons.logout, "Logout", () {
            Navigator.pushNamed(context, '/login');
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
