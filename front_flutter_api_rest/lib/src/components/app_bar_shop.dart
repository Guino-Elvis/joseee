import 'package:flutter/material.dart';
import 'package:front_flutter_api_rest/src/pages/home/CarritoPage.dart';
import 'package:front_flutter_api_rest/src/services/shoping/carrito.dart';
import 'package:provider/provider.dart';

class AppBarShow extends StatelessWidget implements PreferredSizeWidget {
  final Color appBarColor;
  AppBarShow({required this.appBarColor});

  @override
  Widget build(BuildContext context) {
    // Usamos Consumer para escuchar los cambios en CartService
    return AppBar(
      backgroundColor: appBarColor,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ), // Icono del drawer
        onPressed: () {
          Scaffold.of(context).openDrawer(); // Abrir el drawer
        },
      ),
      title: Center(
        child: Text(
          'Franchescas',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            letterSpacing: 2.0,
          ),
        ),
      ),
      actions: [
        Consumer<CartService>(
          // Usamos Consumer para obtener el valor actualizado
          builder: (context, cartService, child) {
            int cartCount = cartService.getCartCount();
            String cartCountStr = cartCount.toString();

            return cartCount > 0
                ? Container(
                    margin: EdgeInsets.only(right: 15),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CarritoPage(cliente: null),
                          ),
                        );
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            TextSpan(
                              text: cartCountStr,
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
                : IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarritoPage(cliente: null),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
