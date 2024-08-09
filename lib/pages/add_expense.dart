import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddExpensePage extends StatefulWidget {
  final List<Map<String, String>> transactions;

  const AddExpensePage({Key? key, required this.transactions}) : super(key: key);

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedCategory = 'Bills';

  @override
  void initState() {
    super.initState();
  }

  void _addExpense() async {
    final amount = _amountController.text;
    final now = DateTime.now();
    final transaction = {
      'type': 'Expense',
      'amount': '\$$amount',
      'category': _selectedCategory,
      'date': '${now.day}/${now.month}/${now.year}',
      'time': '${now.hour}:${now.minute}',
    };

    // Update transactions
    final updatedTransactions = List<Map<String, String>>.from(widget.transactions)..add(transaction);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('transactions', jsonEncode(updatedTransactions));

    Navigator.pop(context, transaction); // Return to the previous page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: _selectedCategory,
              items: <String>['Bills', 'Groceries', 'EMI', 'Loan', 'Shopping', 'Food', 'Other Expenses'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),
            ElevatedButton(
              onPressed: _addExpense,
              child: const Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
