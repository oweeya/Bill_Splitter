import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EqualSplit(),
    );
  }
}

class EqualSplit extends StatefulWidget {
  @override
  _EqualSplitState createState() => _EqualSplitState();
}

class _EqualSplitState extends State<EqualSplit> {
  int numberOfPersons = 1;
  double totalAmount = 0.0;
  double splitAmount = 0.0;

  void calculateSplitAmount() {
    setState(() {
      if (numberOfPersons > 0) {
        splitAmount = totalAmount / numberOfPersons;
      } else {
        splitAmount = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equal Split Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter amount',
              ),
              onChanged: (value) {
                setState(() {
                  totalAmount = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter number of persons',
              ),
              onChanged: (value) {
                setState(() {
                  numberOfPersons = int.tryParse(value) ?? 1;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: calculateSplitAmount,
              child: Text('Split'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Split amount: \$${splitAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
