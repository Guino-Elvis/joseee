import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter_api_rest/src/controller/productoController.dart';
import 'package:front_flutter_api_rest/src/model/productoModel.dart';

import 'package:front_flutter_api_rest/src/providers/theme.dart';
import 'package:provider/provider.dart';

class ProductoSection extends StatefulWidget {
  const ProductoSection({Key? key});

  @override
  State<ProductoSection> createState() => _ProductoSectionState();
}

class _ProductoSectionState extends State<ProductoSection> {
  List<ProductoModel> item = [];
  ProductoController productoController = ProductoController();

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

  //  void _navigateToCategoryView(int categoryId) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => CategoriDetail(categoryId: categoryId),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();

    return BounceInUp(
      duration: Duration(milliseconds: 900),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          mainAxisExtent: 380,
        ),
        itemCount: item.length, // Número total de productos
        itemBuilder: (context, index) {
          final producto = item[index];
          return Container(
            height: 320,
            padding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: InkWell(
              onTap: () {
                // _navigateToCategoryView(categoria.id);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CachedNetworkImage(
                    imageUrl: producto.foto.toString(),
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/nofoto.jpg',
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover, // Ajuste de imagen
                    height: 200,
                    width: 200,
                  ),
                  Container(
                    height: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (producto.nombre ?? 'No hay nombre').toUpperCase(),
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 145,
                          child: Text(
                            truncateText(
                                producto.descrip ?? 'No hay nombre', 32),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.5,
                            ),
                          ),
                        ),
                        Text(
                          producto.precio?.toString() ?? 'No hay precio',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          // _navigateToCategoryView(categoria.id);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 2),
                          color: Colors.blue,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
