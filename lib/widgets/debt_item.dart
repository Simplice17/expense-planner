import 'package:flutter/material.dart';
import '../models/debt.dart';

class DebtItem extends StatelessWidget {
  final Debt debt;

  const DebtItem({super.key, required this.debt});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(debt.person),
        subtitle: Text('${debt.amount} - ${debt.description}'),
        trailing: Text(debt.date.toString()),
      ),
    );
  }
}