//import 'package:budget_buddy/main.dart';
import 'package:flutter/material.dart';
import 'categories_page.dart';
import 'new_category_form.dart';

//delete these 2 void and class budgetbuddyapp
void main() {
  runApp(BudgetBuddyApp());
}

class BudgetBuddyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BudgetBuddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> categories =[
    {'name':'Bills', 'amount': 'Ksh 34,500'},
    {'name':'New Sofa', 'amount':'Ksh 17,000'},
    {'name':'Shopping', 'amount':'Ksh 16,200'}
  ];

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
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding:const  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Mick-alvin',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
           const SizedBox(height: 10),
           const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'BALANCE\nKsh 525,000',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  'CATEGORIES\n4',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Budget Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon:const Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (context) => CategoriesPage(categories: [],)),
                      MaterialPageRoute(builder: (context) => CategoriesPage()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 3,
                  ),
                  itemCount: categories.length + 1,
                  itemBuilder: (context, index) {
                    //data for categories
                    if (index == categories.length) {
                      return GestureDetector(
                        onTap: _showCategoryTypeDialog,
                        child: Card(
                          color: Colors.blue,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: Colors.white, size: 30),//was size 40
                                SizedBox(height: 10),
                                Text(
                                  'New Category',
                                  style: TextStyle(color: Colors.blue, fontSize: 16),
                                )
                              ]
                            ),
                          ),
                        ),
                      );
                    }

                    final category = categories[index];
                    return BudgetCategoryCard(categoryName: category['name']!, amount: category['amount']!);
                  },
                ),
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}







