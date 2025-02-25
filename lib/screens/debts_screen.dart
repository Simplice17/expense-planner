import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/debt_provider.dart';
import '../widgets/debt_item.dart';

class DebtsScreen extends StatelessWidget {
  const DebtsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final debtProvider = Provider.of<DebtProvider>(context);
    final debts = debtProvider.debts;

    return Scaffold(
      appBar: AppBar(
        title: Text('Debts'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: debts.isEmpty
          ? Center(
        child: Text(
          "No debts added yet!",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: debts.length,
          itemBuilder: (context, index) {
            return DebtItem(debt: debts[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addDebt');
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}
