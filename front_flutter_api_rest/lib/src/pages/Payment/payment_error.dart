import 'package:flutter/material.dart';

class PaymentErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Error en el Pago")),
      body: Center(
        child: Text("Hubo un error con el pago. Inténtalo nuevamente."),
      ),
    );
  }
}
