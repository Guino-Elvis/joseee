import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter_api_rest/src/cache/ProductoCacheModel.dart';
import 'package:front_flutter_api_rest/src/components/app_bar_show.dart';
import 'package:front_flutter_api_rest/src/model/productoModel.dart';
import 'package:front_flutter_api_rest/src/providers/theme.dart';
import 'package:front_flutter_api_rest/src/routes/route.dart';
import 'package:front_flutter_api_rest/src/services/shoping/carrito.dart';
import 'package:provider/provider.dart';

class ShowProductoPage extends StatefulWidget {
  final ProductoModel item;

  ShowProductoPage({required this.item});

  @override
  _ShowProductoPageState createState() => _ShowProductoPageState();
}

class _ShowProductoPageState extends State<ShowProductoPage> {
  String? selectedColor;
  String? selectedSize;

  final List<String> colors = ["Rojo", "Azul", "Verde", "Negro"];
  final List<String> sizes = ["S", "M", "L", "XL"];

  bool _isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    final cartService = context.watch<CartService>();
    return Scaffold(
      backgroundColor: themeProvider.isDiurno ? themeColors[2] : themeColors[0],
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarShow(
                onBackTap: () {
                  Navigator.pushNamed(context, AppRoutes.userhomeRoute);
                },
                title: widget.item.nombre?.toString() ?? 'Producto',
              ),
              SizedBox(height: 20),
              // Imagen con sombra y bordes con animación
              GestureDetector(
                onTap: () {
                  // Agregar alguna interacción al tocar la imagen (zoom o detalle)
                },
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 4,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.purpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: widget.item.foto.toString(),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/nofoto.jpg'),
                      fit: BoxFit.cover,
                      height: 250,
                      width: 250,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  widget.item.nombre?.toString().toUpperCase() ?? 'SIN NOMBRE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: themeProvider.isDiurno
                          ? themeColors[0]
                          : themeColors[2]),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              // Precio destacado
              Text(
                "Precio: \$${widget.item.precio.toString()}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 10),
              // Stock disponible
              Text(
                "Stock: ${widget.item.stock}",
                style: TextStyle(
                  fontSize: 18,
                  color: widget.item.stock != null ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(height: 20),
              // Categoría del producto

              SizedBox(height: 20),
              // Sección para elegir color con animación
              Text(
                "Color:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:
                      themeProvider.isDiurno ? themeColors[0] : themeColors[2],
                ),
              ),
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 1),
                child: DropdownButton<String>(
                  value: selectedColor,
                  isExpanded: true,
                  hint: Text("Selecciona un color"),
                  items: colors
                      .map((color) =>
                          DropdownMenuItem(value: color, child: Text(color)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedColor = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Talla:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:
                      themeProvider.isDiurno ? themeColors[0] : themeColors[2],
                ),
              ),
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 1),
                child: DropdownButton<String>(
                  value: selectedSize,
                  isExpanded: true,
                  hint: Text("Selecciona una talla"),
                  items: sizes
                      .map((size) =>
                          DropdownMenuItem(value: size, child: Text(size)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSize = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              // Descripción del producto con expansión
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isDescriptionExpanded = !_isDescriptionExpanded;
                  });
                },
                child: AnimatedCrossFade(
                  firstChild: Text(
                    widget.item.descrip?.toString() ?? 'No disponible',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: themeProvider.isDiurno
                          ? themeColors[0]
                          : themeColors[2],
                    ),
                  ),
                  secondChild: Text(
                    widget.item.descrip?.toString() ?? 'No disponible',
                    style: TextStyle(
                      fontSize: 16,
                      color: themeProvider.isDiurno
                          ? themeColors[0]
                          : themeColors[2],
                    ),
                  ),
                  crossFadeState: _isDescriptionExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Duration(seconds: 1),
                ),
              ),
              SizedBox(height: 20),
              // Botón animado para agregar al carrito
              Center(
                child: AnimatedButton(
                  onPressed: () {
                    {
                      // Crear el modelo de producto
                      ProductoCacheModel item = ProductoCacheModel(
                        id: widget.item.id ?? 0,
                        nombre: widget.item.nombre ?? 'No hay nombre',
                        precio:
                            widget.item.precio?.toString() ?? 'No hay precio',
                        foto: widget.item.foto ?? 'No hay foto',
                        cantidad: 1,
                      );
                      cartService.addToCart(item);
                    }
                  },
                  text: "Agregar al Carrito",
                  height: 50,
                  width: 220,
                  color: Colors.orangeAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Botón animado con interacción al tocar
class AnimatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final double height;
  final double width;
  final Color color;

  AnimatedButton({
    required this.onPressed,
    required this.text,
    required this.height,
    required this.width,
    required this.color,
  });

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color: _isHovered ? widget.color.withOpacity(0.8) : widget.color,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: _isHovered ? Colors.black45 : Colors.transparent,
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
