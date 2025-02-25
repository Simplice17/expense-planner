import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../providers/income_provider.dart';
import '../providers/debt_provider.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final incomeProvider = Provider.of<IncomeProvider>(context);
    final debtProvider = Provider.of<DebtProvider>(context);

    final List<Appointment> appointments = [];

    // Add expenses to calendar
    for (var expense in expenseProvider.expenses) {
      appointments.add(
        Appointment(
          startTime: expense.date,
          endTime: expense.date.add(Duration(hours: 1)),
          subject: 'Expense: ${expense.title}',
          color: Colors.red,
        ),
      );
    }

    // Add income to calendar
    for (var income in incomeProvider.income) {
      appointments.add(
        Appointment(
          startTime: income.date,
          endTime: income.date.add(Duration(hours: 1)),
          subject: 'Income: ${income.title}',
          color: Colors.green,
        ),
      );
    }

    // Add debts to calendar
    for (var debt in debtProvider.debts) {
      appointments.add(
        Appointment(
          startTime: debt.date,
          endTime: debt.date.add(Duration(hours: 1)),
          subject: 'Debt: ${debt.person}',
          color: Colors.orange,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: _AppointmentDataSource(appointments),
      ),
    );
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}