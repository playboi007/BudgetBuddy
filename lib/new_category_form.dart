import 'package:flutter/material.dart';

class NewCategoryForm extends StatefulWidget {
  final String categoryType;
  final Function(Map<String, String>) onSave;

  NewCategoryForm({required this.categoryType, required this.onSave});

  @override
  _NewCategoryFormState createState() => _NewCategoryFormState();

}

class _NewCategoryFormState extends State<NewCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _startAmountController = TextEditingController();
  final _targetAmountController = TextEditingController();
  String _priority = 'Low';
  bool _lockTillTarget = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value){
              if (value ==null || value.isEmpty) {
                return 'Please provide a name for the category';
              }
              return null;
            },
          ),
          if (widget.categoryType == "Savings") ...[
            TextFormField(
              controller: _startAmountController,
              decoration: InputDecoration(labelText: 'Start Amount'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _targetAmountController,
              decoration: InputDecoration(labelText: 'Target Amount'),
              keyboardType: TextInputType.number,
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Please enter a target amount';
                }
                return null;
              },
            ),
            DropdownButtonFormField(
                value: _priority,
                items: ['Low', 'medium', 'High']
                    .map((priority) => DropdownMenuItem(
                        value: priority,
                        child: Text(priority)
                    ))
                .toList(),
                onChanged: (value) {
                  setState(() {
                    _priority = value.toString();
                  });
                },
              decoration: InputDecoration(labelText: 'Priority'),
            ),
            CheckboxListTile(
                title: Text('Lock till target amount'),
                value: _lockTillTarget,
                onChanged: (value){
                  setState(() {
                    _lockTillTarget = value!;
                  });
               },
              ),
            ElevatedButton(
              child: Text('Create'),
              onPressed:(){
                if (_formKey.currentState!.validate()) {
                  final newCategory = {
                    'name': _nameController.text,
                    'amount': widget.categoryType == 'Savings'
                        ? 'Ksh ${_targetAmountController.text}'
                        : '',
                  };
                  widget.onSave(newCategory);
                }
              },

            ),
          ],

          if  (widget.categoryType == "Free") ...[
            TextFormField(
              controller: _startAmountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                return null;
              },
            ),
            DropdownButtonFormField(
              value: _priority,
              items: ['Low', 'medium', 'High']
                  .map((priority) => DropdownMenuItem(
                  value: priority,
                  child: Text(priority)
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _priority = value.toString();
                });
              },
              decoration: InputDecoration(labelText: 'Priority'),
            ),
            ElevatedButton(
              child: Text('Create'),
              onPressed:(){
                if (_formKey.currentState!.validate()) {
                  final newCategory = {
                    'name': _nameController.text,
                    'amount': widget.categoryType == 'Savings'
                        ? 'Ksh ${_targetAmountController.text}'
                        : '',
                  };
                  widget.onSave(newCategory);
                }
              },

            ),
            ]

        ],
      ),
    );
  }
}