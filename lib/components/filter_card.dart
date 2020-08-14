import 'package:flutter/material.dart';
import 'package:hungryyy/utilities/constants.dart';

class FilterCard extends StatelessWidget {
  const FilterCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Filter your search',
                  style: kItemStyle,
                ),
                IconButton(
                  icon: Icon(
                      Icons.close
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Price',
              style: kItemStyle,
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  color: kColorGrey,
                  child: Text('₹',style: kItemStyle),
                  onPressed: (){
                    //TODO:CODE
                  },
                ),
                FlatButton(
                  color: kColorGrey,
                  child: Text('₹₹',style: kItemStyle),
                  onPressed: (){
                    //TODO:CODE
                  },
                ),
                FlatButton(
                  color: kColorYellow,
                  child: Text('₹₹₹',style: kItemStyle),
                  onPressed: (){
                    //TODO:CODE
                  },
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Rating',
              style: kItemStyle,
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  color: kColorGrey,
                  child: Text('★',style: kItemStyle),
                  onPressed: (){
                    //TODO:CODE
                  },
                ),
                FlatButton(
                  color: kColorGrey,
                  child: Text('★★',style: kItemStyle),
                  onPressed: (){
                    //TODO:CODE
                  },
                ),
                FlatButton(
                  color: kColorYellow,
                  child: Text('★★★',style: kItemStyle),
                  onPressed: (){
                    //TODO:CODE
                  },
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Offers',
              style: kItemStyle,
            ),
            Wrap(
              children: <Widget>[
                FlatButton(
                  color: kColorGrey,
                  child: Text('Free Delivery',style: kItemStyle),
                  onPressed: (){
                    //TODO:CODE
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                FlatButton(
                  color: kColorGrey,
                  child: Text('Offer',style: kItemStyle),
                  onPressed: (){
                    //TODO:CODE
                  },
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            MaterialButton(
              onPressed: (){
                //TODO:CODE
              },
              padding: EdgeInsets.all(25),
              color: kColorYellow,
              child: Text(
                'Apply Filters  >',
                style: TextStyle(
                  fontFamily: 'GT Eesti',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}