import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomSplit(),
    );
  }
}

class CustomSplit extends StatefulWidget {
  @override
  _CustomSplitState createState() => _CustomSplitState();
}

class _CustomSplitState extends State<CustomSplit> {
  double amount = 0.0;
  List<double> percentages = [];
  List<double> results = [];

  void calculateSplit() {
    double totalPercentage =
        percentages.reduce((sum, percentage) => sum + percentage);
    if (totalPercentage == 0) {
      // Avoid division by zero
      setState(() {
        results = List.generate(percentages.length, (index) => 0.0);
      });
      return;
    }

    double totalAmount = amount;
    List<double> calculatedResults = percentages
        .map((percentage) => (percentage / totalPercentage) * totalAmount)
        .toList();
    setState(() {
      results = calculatedResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Split Calculator')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Amount'),
              onChanged: (value) {
                setState(() {
                  amount = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Enter Percentages (comma-separated)'),
              onChanged: (value) {
                List<String> percentageStrings = value.split(',');
                percentages = percentageStrings.map((percentage) {
                  return double.tryParse(percentage.trim()) ?? 0.0;
                }).toList();
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: calculateSplit,
              child: Text('Split'),
            ),
            SizedBox(height: 16.0),
            Text('Split amount:'),
            Column(
              children: results
                  .map((result) => Text('\$${result.toStringAsFixed(2)}'))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
