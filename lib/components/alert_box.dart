import 'package:flutter/material.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertBox{
  static void showErrorBox(BuildContext context,String text){
    Alert(
      context: context,
      type: AlertType.error,
      title: "Error",
      desc: text,
      buttons: [
        DialogButton(
          color: kColorYellow,
          child: Text(
            "Okay",
            style: TextStyle(
              fontFamily: 'GT Eesti',
                color: kColorBlack,
                fontSize: 16),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  static Future<void> showSuccessBox(BuildContext context,String text,String title) async {
    await Alert(
      context: context,
      type: AlertType.success,
      title: title,
      desc: text,
      buttons: [
        DialogButton(
          color: kColorYellow,
          child: Text(
            "Okay",
            style: TextStyle(
                fontFamily: 'GT Eesti',
                color: kColorBlack,
                fontSize: 16),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  static Future<void> showConfirmationBox(BuildContext context,String title,Function onContinue) async {
    await Alert(
      context: context,
      type: AlertType.warning,
      title: title,
      desc: 'Are you sure? Click okay to continue',
      buttons: [
        DialogButton(
          color: kColorYellow,
          child: Text(
            "Cancel",
            style: TextStyle(
                fontFamily: 'GT Eesti',
                color: kColorBlack,
                fontSize: 16),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
        DialogButton(
          color: kColorYellow,
          child: Text(
            "Okay",
            style: TextStyle(
                fontFamily: 'GT Eesti',
                color: kColorBlack,
                fontSize: 16),
          ),
          onPressed: (){
            Navigator.pop(context);
            onContinue();
          } ,
          width: 120,
        )
      ],
    ).show();
  }
}