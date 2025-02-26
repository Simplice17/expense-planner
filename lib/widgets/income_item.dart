import 'package:flutter/material.dart';
import '../models/income.dart';

class IncomeItem extends StatelessWidget {
  final Income income;

  IncomeItem({required this.income});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.attach_money, color: Colors.white),
        ),
        title: Text(income.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text("${income.date.toLocal()}".split(' ')[0]),
        trailing: Text(
          "\$${income.amount.toStringAsFixed(2)}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ),
    );
  }
}
