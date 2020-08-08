import 'package:flutter/material.dart';
import 'package:hungryyy/utilities/constants.dart';

class DishItem extends StatefulWidget {
  @override
  _DishItemState createState() => _DishItemState();

  final String name;
  final double price;
  DishItem({@required this.name,@required this.price});
}

class _DishItemState extends State<DishItem> {

  int dishCount = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  widget.name,
                  style: kLabelStyle.copyWith(fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Rs ${widget.price}',
                  style: kLabelStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          dishCount == 0 ?
          FlatButton(
            onPressed: (){
              setState(() {
                dishCount = 1;
              });
            },
            child: Text(
              'Add',
              style: kItemStyle.copyWith(color: kColorRed,fontSize: 12),
            ),
          ) :
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 18),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    setState(() {
                      if(0 <= dishCount){
                        dishCount--;
                      }
                    });
                  },
                  child: Icon(
                    Icons.remove,
                    color: kColorRed,
                    size: 12,
                  ),
                ),
                SizedBox(width: 10,),
                Text(
                  '$dishCount',
                  style: kItemStyle.copyWith(color: kColorRed,fontSize: 12),
                ),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      if(dishCount < 10){
                        dishCount++;
                      }
                    });
                  },
                  child: Icon(
                    Icons.add,
                    color: kColorRed,
                    size: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
