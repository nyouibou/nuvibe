import 'package:flutter/material.dart';

class BuyCoffeeScreen extends StatefulWidget {
  @override
  _BuyCoffeeScreenState createState() => _BuyCoffeeScreenState();
}

class _BuyCoffeeScreenState extends State<BuyCoffeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Me a Coffee'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Cost: Rs 10',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement payment logic or any action on button press
                // For a demo, you can navigate back or show a confirmation dialog.
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text("Payment Confirmation"),
                    content: Text("Thank you for buying me a coffee!"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pop(); // Pop twice to go back to previous screen
                        },
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                'Pay Rs 10',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
