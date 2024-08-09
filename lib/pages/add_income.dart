import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddIncomePage extends StatefulWidget {
  final List<Map<String, String>> transactions;

  const AddIncomePage({Key? key, required this.transactions}) : super(key: key);

  @override
  _AddIncomePageState createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedCategory = 'Salary';

  void _addIncome() async {
    final amount = _amountController.text;
    final now = DateTime.now();
    final transaction = {
      'type': 'Income',
      'amount': '\$$amount', // Format amount to include '$' sign
      'category': _selectedCategory,
      'date': '${now.day}/${now.month}/${now.year}',
      'time': '${now.hour}:${now.minute}',
    };

    // Update transactions
    final updatedTransactions = List<Map<String, String>>.from(widget.transactions)..add(transaction);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('transactions', jsonEncode(updatedTransactions));

    Navigator.pop(context, transaction); // Return to the previous page with transaction data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Income'),
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
              items: <String>['Salary', 'Bonus', 'Other Incomes'].map((String value) {
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
              onPressed: _addIncome,
              child: const Text('Add Income'),
            ),
          ],
        ),
      ),
    );
  }
}
