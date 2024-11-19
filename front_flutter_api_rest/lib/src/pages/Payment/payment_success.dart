import 'package:flutter/material.dart';
import 'package:front_flutter_api_rest/src/routes/route.dart';

class PaymentSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pago Exitoso")),
      body: Center(
        child: Column(
          children: [
            Text("¡Gracias por tu compra! El pago se completó exitosamente."),
            Text("datos aqui ."),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.userhomeRoute);
              },
              child: Container(
                child: Text("Ir al Inicio"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
