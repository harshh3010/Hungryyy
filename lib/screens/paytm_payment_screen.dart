import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:hungryyy/utilities/user_api.dart';

class PaytmPaymentScreen extends StatefulWidget {
  @override
  _PaytmPaymentScreenState createState() => _PaytmPaymentScreenState();

  final double amount;
  final String orderId;
  PaytmPaymentScreen({@required this.orderId,@required this.amount});
}

class _PaytmPaymentScreenState extends State<PaytmPaymentScreen> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  String orderId;
  String customerId;
  double amount;
  String email;
  UserApi userApi = UserApi.instance;

  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  String status;

  @override
  void dispose() {
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    customerId = userApi.email;
    orderId = '${widget.orderId}-$customerId-${DateTime.now().millisecondsSinceEpoch}';
    amount = widget.amount;
    email = userApi.email;

    flutterWebviewPlugin.close();

    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
          print("onStateChanged: ${state.type} ${state.url}");
        });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          print("URL changed: $url");
          if (url.contains('callback')) {
            flutterWebviewPlugin.getCookies().then((cookies) {
              String status;
              int i=0;
              for(var x in cookies.values){
                if(i == 1){
                  status = x;
                }
                i++;
              }
              Navigator.pop(context,status);
              flutterWebviewPlugin.close();
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final queryParams =
        '?order_id=$orderId&customer_id=$customerId&amount=$amount&email=$email';

    return new WebviewScaffold(
        url: Settings.apiUrl + queryParams,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              padding: EdgeInsets.all(10),
              icon: Icon(
                Icons.arrow_back_ios,
                color: kColorBlack,
              ),
            ),
          ),
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 27),
            child: Text(
              'HUNGRYYY',
              style: kHeadingStyle,
            ),
          ),
        ),
      ),
    );
  }
}

class Settings {
  static String get apiUrl => "http://192.168.43.50:3000/api/v1/paytm/initiatePayment";
}
