import 'package:flutter/material.dart';
import 'package:hungryyy/utilities/constants.dart';

enum Rating{
  low,
  mid,
  high
}

enum Pricing{
  low,
  mid,
  high
}

class FilterCard extends StatefulWidget {
  @override
  _FilterCardState createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {

  Pricing selectedPricing;
  Rating selectedRating;

  bool freeDeliveryFilter = false,offerFilter = false;

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
                  color: selectedPricing == Pricing.low ? kColorYellow : kColorGrey,
                  child: Text('₹',style: kItemStyle),
                  onPressed: (){
                    setState(() {
                      if(selectedPricing == Pricing.low){
                        selectedPricing = null;
                      }else{
                        selectedPricing = Pricing.low;
                      }
                    });
                  },
                ),
                FlatButton(
                  color: selectedPricing == Pricing.mid ? kColorYellow : kColorGrey,
                  child: Text('₹₹',style: kItemStyle),
                  onPressed: (){
                    setState(() {
                      if(selectedPricing == Pricing.mid){
                        selectedPricing = null;
                      }else{
                        selectedPricing = Pricing.mid;
                      }
                    });
                  },
                ),
                FlatButton(
                  color: selectedPricing == Pricing.high ? kColorYellow : kColorGrey,
                  child: Text('₹₹₹',style: kItemStyle),
                  onPressed: (){
                    setState(() {
                      if(selectedPricing == Pricing.high){
                        selectedPricing = null;
                      }else{
                        selectedPricing = Pricing.high;
                      }
                    });
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
                  color: selectedRating == Rating.low ? kColorYellow : kColorGrey,
                  child: Text('★',style: kItemStyle),
                  onPressed: (){
                    setState(() {
                      if(selectedRating == Rating.low){
                        selectedRating = null;
                      }else{
                        selectedRating = Rating.low;
                      }
                    });
                  },
                ),
                FlatButton(
                  color: selectedRating == Rating.mid ? kColorYellow : kColorGrey,
                  child: Text('★★',style: kItemStyle),
                  onPressed: (){
                    setState(() {
                      if(selectedRating == Rating.mid){
                        selectedRating = null;
                      }else{
                        selectedRating = Rating.mid;
                      }
                    });
                  },
                ),
                FlatButton(
                  color: selectedRating == Rating.high ? kColorYellow : kColorGrey,
                  child: Text('★★★',style: kItemStyle),
                  onPressed: (){
                    setState(() {
                      if(selectedRating == Rating.high){
                        selectedRating = null;
                      }else{
                        selectedRating = Rating.high;
                      }
                    });
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
                  color: freeDeliveryFilter ? kColorYellow : kColorGrey,
                  child: Text('Free Delivery',style: kItemStyle),
                  onPressed: (){
                    setState(() {
                      if(freeDeliveryFilter){
                        freeDeliveryFilter = false;
                      }else{
                        freeDeliveryFilter = true;
                      }
                    });
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                FlatButton(
                  color: offerFilter ? kColorYellow : kColorGrey,
                  child: Text('Offer',style: kItemStyle),
                  onPressed: (){
                    setState(() {
                      if(offerFilter){
                        offerFilter = false;
                      }else{
                        offerFilter = true;
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            MaterialButton(
              onPressed: (){
                Map filterMap = {
                  'pricing' : selectedPricing,
                  'rating' : selectedRating,
                  'freeDelivery' : freeDeliveryFilter,
                  'offer' : offerFilter,
                };
                Navigator.pop(context,filterMap);
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
