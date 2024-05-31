import 'package:flutter/material.dart';
import 'home_page.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'BudgetBuddy',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'PhoneNumber',
              prefixText: '+254',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 20),
          TextField(
            controller: otpController,
            decoration: InputDecoration(
              labelText: "Otp Verification",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height:20),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('Log In')),

        ],
      ),
      ),
    );
  }
}
