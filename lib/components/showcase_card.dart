import 'package:flutter/material.dart';
import 'package:hungryyy/utilities/constants.dart';

class ShowcaseCard extends StatelessWidget {

  final String label;
  final Function viewAll;
  final Widget child;
  ShowcaseCard({@required this.label,@required this.viewAll,@required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 30),
          child: Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                label,
                style: kLabelStyle,
              ),
              GestureDetector(
                onTap: viewAll,
                child: Text(
                  'See All',
                  style: TextStyle(
                    fontFamily: 'GT Eesti',
                    color: Colors.grey.shade500,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        child,
      ],
    );
  }
}