import 'package:flutter/material.dart';
import 'package:front_flutter_api_rest/src/cache/ClienteCacheModel.dart';
import 'package:front_flutter_api_rest/src/cache/ProductoCacheModel.dart';
import 'package:front_flutter_api_rest/src/components/app_bar_create.dart';
import 'package:front_flutter_api_rest/src/routes/route.dart';
import 'package:front_flutter_api_rest/src/services/shoping/carrito.dart';
import 'package:front_flutter_api_rest/src/services/whatsap.dart';

class CarritoPage extends StatefulWidget {
  final ClienteCacheModel? cliente;

  CarritoPage({required this.cliente});

  @override
  _CarritoPageState createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  final CartService cartService = CartService();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<ProductoCacheModel>> getCartItems() async {
    return cartService.getCartItems();
  }

  void removeItem(int index) async {
    await cartService.removeFromCart(index);
    setState(() {});
  }

  void updateQuantity(int index, int quantity) async {
    List<ProductoCacheModel> cartItems = cartService.getCartItems();
    ProductoCacheModel product = cartItems[index];

    if (quantity <= 0) return; // Evitar cantidades negativas o cero

    ProductoCacheModel updatedProduct = ProductoCacheModel(
      id: product.id,
      nombre: product.nombre,
      precio: product.precio,
      foto: product.foto,
      cantidad: quantity,
    );

    // Eliminar el producto anterior
    await cartService.removeFromCart(index);
    // Volver a agregar el producto con la nueva cantidad
    await cartService.addToCart(updatedProduct);
    setState(() {}); // Recargar la vista después de actualizar la cantidad
  }

  @override
  Widget build(BuildContext context) {
    int cartCount = cartService.getCartCount();
    String cartCountStr = cartCount.toString();
    List<ProductoCacheModel> cartItems = cartService.getCartItems();
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          AppBarCreate(
            onBackTap: () {
              Navigator.pushNamed(context, AppRoutes.userhomeRoute);
            },
          ),
          Expanded(
            child: FutureBuilder<List<ProductoCacheModel>>(
              future: getCartItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error al cargar el carrito'));
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return Center(child: Text('Tu carrito está vacío.'));
                } else if (snapshot.hasData) {
                  List<ProductoCacheModel> cartItems = snapshot.data!;
                  return ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      ProductoCacheModel product = cartItems[index];
                      return Card(
                        margin: EdgeInsets.all(10),
                        elevation: 5,
                        child: ListTile(
                          leading: Image.network(
                            product.foto,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(product.nombre),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Precio: \$${product.precio}'),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        if (product.cantidad > 1) {
                                          updateQuantity(
                                              index, product.cantidad - 1);
                                        }
                                      },
                                    ),
                                    Text('${product.cantidad}'),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        updateQuantity(
                                            index, product.cantidad + 1);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => removeItem(index),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(child: Text('No hay productos en el carrito'));
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: FutureBuilder<List<ProductoCacheModel>>(
        future: getCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return SizedBox.shrink();
          }
          double total = snapshot.data!.fold(0,
              (sum, item) => sum + double.parse(item.precio) * item.cantidad);
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnviarWhatsAppPage(
                        carrito: cartItems,
                        total: total,
                      ),
                    ),
                  );
                },
                child: Text(
                    'Pagar (${cartCountStr}) - \$${total.toStringAsFixed(2)}'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
