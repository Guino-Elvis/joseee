import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter_api_rest/src/cache/ProductoCacheModel.dart';
import 'package:front_flutter_api_rest/src/controller/productoController.dart';
import 'package:front_flutter_api_rest/src/controller/sub_categoriaController.dart';
import 'package:front_flutter_api_rest/src/model/productoModel.dart';
import 'package:front_flutter_api_rest/src/model/subCategoriaModel.dart';
import 'package:front_flutter_api_rest/src/pages/home/showProductoPage.dart';

import 'package:front_flutter_api_rest/src/providers/theme.dart';
import 'package:front_flutter_api_rest/src/services/shoping/carrito.dart';
import 'package:provider/provider.dart';

class ProductoSubCategoriaSection extends StatefulWidget {
  const ProductoSubCategoriaSection({Key? key});

  @override
  State<ProductoSubCategoriaSection> createState() =>
      _ProductoSubCategoriaSectionState();
}

class _ProductoSubCategoriaSectionState
    extends State<ProductoSubCategoriaSection> {
  List<ProductoModel> item = [];
  List<Map<String, dynamic>> subCategorias = [];

  ProductoController productoController = ProductoController();
  SubCategoriaController subCategoriaController = SubCategoriaController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    try {
      final productoData = await productoController.getDataProductos();

      setState(() {
        item = productoData
            .map<ProductoModel>((json) => ProductoModel.fromJson(json))
            .toList();
      });

      // Obtener subcategorías
      final subCategoriaData =
          await subCategoriaController.getDataSubCategoria();
      setState(() {
        subCategorias = List<Map<String, dynamic>>.from(subCategoriaData);
      });
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + "...";
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    // Obtener CartService desde el provider
    final cartService = context.watch<CartService>();
    return BounceInUp(
      duration: Duration(milliseconds: 900),
      child: Column(
        children: subCategorias.map<Widget>((subCategoria) {
          String subCategoriaName =
              subCategoria['nombre'] ?? 'Subcategoría sin nombre';

          List<ProductoModel> productosSubCategoria = item
              .where((producto) =>
                  producto.subCategoria?['id'] == subCategoria['id'])
              .toList();

          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      subCategoriaName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'ver mas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: productosSubCategoria.map<Widget>((producto) {
                    return Container(
                      height: 300,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(2, 0),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ShowProductoPage(item: producto),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl: producto.foto.toString(),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/nofoto.jpg'),
                              fit: BoxFit.cover,
                              height: 150,
                              width: 150,
                            ),
                            Container(
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (producto.nombre ?? 'No hay nombre')
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    width: 145,
                                    child: Text(
                                      truncateText(
                                          producto.descrip ?? 'No hay nombre',
                                          32),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.5,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    producto.precio?.toString() ??
                                        'No hay precio',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: InkWell(
                                onTap: () async {
                                  // Crear el modelo de producto
                                  ProductoCacheModel item = ProductoCacheModel(
                                    id: producto.id ?? 0,
                                    nombre: producto.nombre ?? 'No hay nombre',
                                    precio: producto.precio?.toString() ??
                                        'No hay precio',
                                    foto: producto.foto ?? 'No hay foto',
                                    cantidad: 1,
                                  );
                                  cartService.addToCart(item);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 2),
                                  color: Colors.blue,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.shopping_cart,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Añadir',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
