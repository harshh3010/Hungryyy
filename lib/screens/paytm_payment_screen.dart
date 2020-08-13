import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
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
  final email = 'harsh.gyanchandani@gmail.com';
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
    orderId = widget.orderId;
    amount = widget.amount;

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
              print("cookies $cookies");
              print('TXNID $cookies["TXNID"]');
              print('STATUS $cookies["STATUS"]');
              print('RESPCODE $cookies["RESPCODE"]');
              print('RESPMSG $cookies["RESPMSG"]');
              print('TXNDATE $cookies["TXNDATE"]');
              // add logic to make show payment status
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
        appBar: new AppBar(
          title: new Text("Pay using PayTM"),
        ));
  }
}

class Settings {
  static String get apiUrl => "http://192.168.43.50:3000/api/v1/paytm/initiatePayment";
}
