import 'package:flutter/material.dart';
import 'package:sample_project/Model/alert_data.dart';

class AlertUtil {
  static void showAlertDialogWithOneButton(
      BuildContext context, AlertData alertData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
            data: ThemeData.dark(),
            child: AlertDialog(
              title: Text(alertData.title),
              content: Text(alertData.body),
              actions: <Widget>[
                TextButton(
                  child: const Text('확인'),
                  onPressed: () {
                    if (alertData.onComplete != null) {
                      alertData.onComplete!();
                    }
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            ));
      },
    );
  }

  static void showAlertDialogWithTwoButton(
      BuildContext context, AlertData alertData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
            data: ThemeData.dark(),
            child: AlertDialog(
              title: Text(alertData.title),
              content: Text(alertData.body),
              actions: <Widget>[
                TextButton(
                  child: const Text('확인'),
                  onPressed: () {
                    if (alertData.onComplete != null) {
                      alertData.onComplete!();
                    }
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
                TextButton(
                  child: const Text('취소'),
                  onPressed: () {
                    if (alertData.onCancel != null) {
                      alertData.onCancel!();
                    }
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            ));
      },
    );
  }
}
