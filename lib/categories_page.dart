import 'package:budget_buddy/home_page.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/new_category_form.dart';
class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Map<String, String>> categories = [
    {'name':'Bills', 'amount': 'Ksh 34,500'},
    {'name':'New Sofa', 'amount':'Ksh 17,000'},
    {'name':'Shopping', 'amount':'Ksh 16,200'}
  ];
  //CategoriesPage({required this.categories});

  void _showCategoryTypeDialog() {
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text('What type would you like?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                child: const Text('Free'),
                onPressed: (){
                  Navigator.pop(context);
                  _showNewCategoryDialog('Free');
                },
              ),
              ElevatedButton(
                child: const Text('Savings'),
                onPressed: () {
                  Navigator.pop(context);
                  _showNewCategoryDialog('Savings');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showNewCategoryDialog(String categoryType) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create New Category'),
          content: NewCategoryForm(
              categoryType: categoryType,
              onSave: (newCategory){
                setState(() {
                  categories.add(newCategory);
                });
                Navigator.pop(context);
              }
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        foregroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  itemCount: categories.length + 1,
                  itemBuilder: (context, index){
                    if (index == categories.length) {
                      return GestureDetector(
                        onTap: _showCategoryTypeDialog,
                        child: Card(
                          color: Colors.grey[200],
                          child: ListTile(
                            title: Text(
                              'New Category',
                              style: TextStyle(color:  Colors.blue),
                            ),
                            trailing: Icon(Icons.add, color: Colors.blue,),
                          ),
                        ),
                      );
                    }
                    final category = categories[index];
                    return BudgetCategoryCard(categoryName: (category['name']!), amount: category['amount']!);
                  },
                ),
            ),
            FloatingActionButton(
                onPressed: () {
                  //navigate to add new category page(not yet implented)
                },
              child:const Icon(Icons.add)
            )
          ],
        ),
      ),
    );
  }

}

class BudgetCategoryCard extends StatelessWidget {
  final String categoryName;
  final String amount;

  BudgetCategoryCard({required this.categoryName, required this.amount});

  @override
  Widget build(BuildContext context){
    return Card(
      child: ListTile(
        title: Text(categoryName),
        subtitle: Text(amount),
        onTap: () {
          //to implement
        },
      ),
    );
  }
}