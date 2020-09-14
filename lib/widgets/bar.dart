import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  var label;
  double total;
  double perc;
  Bar(this.label, this.total, this.perc);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Column(
          children: <Widget>[
            Container(
              height: constraint.maxHeight * 0.2,
              child: Text(label),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: constraint.maxHeight * 0.5,
              width: 15,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  FractionallySizedBox(
                    heightFactor: perc,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
                height: constraint.maxHeight * 0.15,
                child: FittedBox(
                    child: Text(
                  '\$${total.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontFamily: "UbuntuMono",
                  ),
                ))),
          ],
        );
      },
    );
  }
}
