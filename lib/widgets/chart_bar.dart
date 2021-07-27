import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  //variables used for chart bar.
  //label = week days; spending amount = amount of total money spend in that day of the week
  //spendingPercentageOfTotal = height factor for bar
  late final String label;
  late final double spendingAmount;
  late final double spendingPercentageOfTotal;

  //Constructor
  ChartBar(this.label, this.spendingAmount, this.spendingPercentageOfTotal);

  @override
  Widget build(BuildContext context) {
    //LayoutBuilder constraints for make app responsive, for setting height/width etc responsively
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            //Container of spend amount money
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
              ),
            ),
            //Box for free place between widgets
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            //Container of bar
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPercentageOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  )
                ],
              ),
            ),
            //Box for free place between widgets
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            //Container of week days text
            Container(
              child: FittedBox(child: Text(label)),
              height: constraints.maxHeight * 0.15,
            ),
          ],
        );
      },
    );
  }
}
