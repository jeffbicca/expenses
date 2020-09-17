import 'package:flutter/material.dart';
import 'adptative_date_picker.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Título'),
                onSubmitted: (_) => _submitForm(),
              ),
              TextField(
                controller: valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Valor (R\$)'),
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptativeDatePicker(
                selectedDate: selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    selectedDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    child: Text(
                      'Nova Transação',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: _submitForm,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
