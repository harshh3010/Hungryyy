import 'package:flutter/material.dart';
import 'package:hungryyy/screens/order_track_host.dart';
import 'package:hungryyy/utilities/constants.dart';


class PaymentMethodsScreen extends StatefulWidget {
  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();

  final Widget iconButton;
  PaymentMethodsScreen({@required this.iconButton});
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: widget.iconButton,
          ),
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 27),
            child: Text(
              'Payment Methods',
              style: kHeadingStyle,
            ),
          ),
        ),
      ),
      body: Container(
        child: FlatButton(
          child: Text('GOTO MAP'),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => OrderTrackHostScreen()));
          },
        ),
      ),
    );
  }
}
