import 'package:flutter/material.dart';

class LoadingWidget {
  static showDialogLoading(
    BuildContext context, {
    String title = 'Load Data',
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
