import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class UiHelper {
  static ShowAlertDialog(String message,
      {title = '', String? navigateTo, String? buttonTitle = ''}) {
    OneContext().showDialog(builder: (ctx) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0))),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                if (navigateTo != null && navigateTo.isNotEmpty) {
                  // Navega a la ruta especificada
                  OneContext().pushNamed(navigateTo);
                }
              },
              child: Text(buttonTitle ?? 'no hay titulo para el boton'))
        ],
      );
    });
  }
}
