import 'package:flutter/material.dart';
import 'package:front_flutter_api_rest/src/cache/ClienteCacheModel.dart';
import 'package:front_flutter_api_rest/src/cache/ProductoCacheModel.dart';
import 'package:front_flutter_api_rest/src/controller/auth/ShareApiTokenController.dart';
import 'package:front_flutter_api_rest/src/services/shoping/payKey.dart';
import 'package:url_launcher/url_launcher.dart';

class EnviarWhatsAppPage extends StatefulWidget {
  final List<ProductoCacheModel> carrito;
  final double? total;

  // Constructor para recibir los datos
  EnviarWhatsAppPage({
    required this.carrito,
    required this.total,
  });

  @override
  State<EnviarWhatsAppPage> createState() => _EnviarWhatsAppPageState();
}

class _EnviarWhatsAppPageState extends State<EnviarWhatsAppPage> {
  String accountName = "";
  String accountApellidoP = "";
  String accountApellidoM = "";
  String accountEmail = "";
  String accountNumero = "";
  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    final loginDetails = await ShareApiTokenController.loginDetails();

    if (loginDetails != null) {
      setState(() {
        accountName = loginDetails.user?.name ?? "";
        accountApellidoP = loginDetails.user?.apellidoP ?? "";
        accountApellidoM = loginDetails.user?.apellidoM ?? "";
        accountEmail = loginDetails.user?.email ?? "";
        accountNumero = loginDetails.user?.codigo ?? "";
      });
    }
  }

  // Función para crear el mensaje con los detalles del cliente y los productos
  String _crearMensaje() {
    String mensaje =
        "🌟 *¡Hola ${accountName} ${accountApellidoP} ${accountApellidoM}! Tu pedido está casi listo* 🌟\n\n";
    mensaje += "🛍️ *Productos en tu carrito*:\n\n";

    for (var producto in widget.carrito) {
      mensaje += "🛒 *${producto.nombre}*\n";
      mensaje += "🔢 *Cantidad*: ${producto.cantidad}\n";
      mensaje += "💲 *Precio unitario*: \$${producto.precio}\n";
      mensaje +=
          "💸 *Subtotal*: \$${double.parse(producto.precio) * producto.cantidad}\n";

      // Enlace a la foto del producto si está disponible
      mensaje += "🖼️ *Ver imagen*: ${producto.foto}\n\n";
    }

    mensaje += "----------------------------------\n";
    mensaje +=
        "📊 *Total de la compra*: \$${widget.total!.toStringAsFixed(2)}\n\n";

    mensaje += "----------------------------------\n";
    mensaje += "ℹ️ *Detalles de tu cuenta*:\n";
    mensaje += "✉️ *Email*: ${accountEmail}\n";
    mensaje += "📱 *Teléfono*: ${accountNumero}";
    mensaje += "🏠 *Dirección*: JOSE DOMINGES \n";

    mensaje += "\n----------------------------------\n";
    mensaje += "🎉 *¡Gracias por tu elección!* 🎉\n";
    mensaje +=
        "📩 *Si tienes alguna duda o necesitas más información, contáctanos a* [empresa@gmail.com](mailto:empresa@gmail.com)\n";
    mensaje += "\n¡Esperamos tu confirmación para procesar tu pedido! 😊";

    return mensaje;
  }

  // Función para enviar el mensaje a WhatsApp Web
  void _enviarWhatsApp(String mensaje) async {
    if (accountNumero.isEmpty) {
      print("Número no válido");
      return;
    }
    final String numero = "51$accountNumero";
    // Crear el enlace para WhatsApp Web
    final url = Uri.parse(
        'https://wa.me/$numero?text=${Uri.encodeComponent(mensaje)}'); // Enlace adecuado para WhatsApp Web

    print("URL generada: $url");

    try {
      // Intentar abrir la URL directamente
      await launchUrl(
        url,
        mode: LaunchMode
            .externalApplication, // Esto asegura que se abre en el navegador externo
      );
      print('URL abierta con éxito');
    } catch (e) {
      print("No se puede abrir WhatsApp Web: $e");
      // Si el enlace no puede abrirse, muestra un mensaje al usuario.
    }
  }

  @override
  Widget build(BuildContext context) {
    String mensaje =
        _crearMensaje(); // Crear el mensaje con los productos y el total

    return Scaffold(
      appBar: AppBar(title: Text("Enviar a WhatsApp Web")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print("Botón presionado, enviando mensaje...");
            _enviarWhatsApp(
                mensaje); // Enviar el mensaje cuando el botón sea presionado
          },
          child: Text("Enviar Productos por WhatsApp Web"),
        ),
      ),
    );
  }
}
