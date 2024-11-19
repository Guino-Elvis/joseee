import 'dart:convert';

import 'package:front_flutter_api_rest/src/providers/provider.dart';
import 'package:hive/hive.dart';
import 'package:front_flutter_api_rest/src/cache/ProductoCacheModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartService extends ChangeNotifier {
  Box<ProductoCacheModel>? _cartBox;

  CartService() {
    // Asegúrate de que la caja ya esté abierta en `main()` antes de llegar aquí.
    if (Hive.isBoxOpen('cart')) {
      _cartBox = Hive.box<ProductoCacheModel>('cart');
    } else {
      throw HiveError('La caja "cart" no está abierta.');
    }
  }
  // Getter para obtener la caja
  Box<ProductoCacheModel>? get cartBox {
    return _cartBox;
  }

  // Future<ProductoCacheModel?> getProductFromDatabase(
  //     {required int productId}) async {
  //   try {
  //     final urls = Providers.provider();
  //     String urlString = urls['productoListProvider']!;

  //     final url = Uri.parse(urlString);
  //     final response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       var productData = data.firstWhere(
  //         (item) => item['id'] == productId,
  //         orElse: () => null,
  //       );

  //       if (productData != null) {
  //         return ProductoCacheModel.fromJson(productData);
  //       } else {
  //         print('Producto no encontrado con ID: $productId');
  //         return null;
  //       }
  //     } else {
  //       throw Exception('Failed to load Productos');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }

  // Future<void> updateCartPrices() async {
  //   if (_cartBox != null) {
  //     for (var cartItem in _cartBox!.values) {
  //       var updatedProduct =
  //           await getProductFromDatabase(productId: cartItem.id);
  //       if (updatedProduct != null &&
  //           updatedProduct.precio != cartItem.precio) {
  //         cartItem.precio = updatedProduct.precio;
  //         int key = _cartBox!.keys.firstWhere(
  //           (key) => _cartBox!.get(key) == cartItem,
  //           orElse: () => -1,
  //         );

  //         if (key != -1) {
  //           await _cartBox!.put(key, cartItem);
  //           print(
  //               'Precio actualizado para ${cartItem.nombre}: ${cartItem.precio}');
  //         }
  //       }
  //     }

  //     _printCartContents();
  //     notifyListeners();
  //   }
  // }

  // Método para agregar un producto al carrito
  Future<void> addToCart(ProductoCacheModel item) async {
    // Verifica si la caja está abierta antes de agregar el producto
    if (_cartBox != null) {
      // Buscar si el producto ya está en el carrito por ID
      ProductoCacheModel? existingProduct = _cartBox!.values.firstWhere(
        (cartItem) => cartItem.id == item.id,
        orElse: () => ProductoCacheModel(
            id: 0,
            nombre: '',
            precio: '',
            foto: '',
            cantidad: 0), // Producto vacío por defecto
      );

      // Comprobar si se encontró el producto válido en el carrito
      if (existingProduct.id != 0) {
        // Comprobamos que no es el producto vacío
        // Si ya está en el carrito, aumentamos la cantidad y no lo agregamos nuevamente
        existingProduct.cantidad += 1;

        // Encontramos la clave del producto para actualizar
        int key = _cartBox!.keys.firstWhere(
          (key) => _cartBox!.get(key) == existingProduct,
          orElse: () => -1, // Si no se encuentra, devuelve -1
        );

        // Si encontramos la clave, actualizamos el producto en la caja
        if (key != -1) {
          await _cartBox!.put(key, existingProduct);
          print(
              'Producto ya existe, cantidad incrementada: ${existingProduct.nombre}, nueva cantidad: ${existingProduct.cantidad}');
        }

        print(
            'Producto ya existe, cantidad incrementada: ${existingProduct.nombre}, nueva cantidad: ${existingProduct.cantidad}');
      } else {
        // Si el producto no está en el carrito, lo agregamos
        await _cartBox?.add(item);
        print('Producto agregado: ${item.nombre}');
      }

      // Imprime el carrito después de agregar o actualizar el producto
      _printCartContents();
      notifyListeners(); // Notifica a los listeners después de modificar el carrito
    } else {
      print('La caja no está abierta, no se pudo agregar el producto.');
    }
  }

  // Método para imprimir todos los productos en el carrito
  void _printCartContents() {
    if (_cartBox != null) {
      List<ProductoCacheModel> cartItems = _cartBox!.values.toList();
      if (cartItems.isEmpty) {
        print('La caja está vacía.');
      } else {
        print('Contenido de la caja:');
        for (var item in cartItems) {
          print(
              'ID: ${item.id}, Nombre: ${item.nombre}, Precio: ${item.precio}, Cantidad: ${item.cantidad}');
        }
      }
    } else {
      print('No se pudo acceder a la caja');
    }
  }

  // Método para obtener el conteo de productos
  int getCartCount() {
    if (_cartBox != null) {
      return _cartBox!.length;
    }
    return 0; // Si la caja no está abierta, retorna 0
  }

  // Método para eliminar un producto del carrito por índice
  Future<void> removeFromCart(int index) async {
    if (_cartBox != null) {
      _cartBox?.deleteAt(index);
      print('Producto eliminado del carrito en el índice $index');
      _printCartContents(); // Imprime el carrito después de eliminar el producto
      notifyListeners(); // Notifica a los listeners después de modificar el carrito
    } else {
      print('La caja no está abierta, no se pudo eliminar el producto.');
    }
  }

  // Método para obtener todos los productos del carrito
  List<ProductoCacheModel> getCartItems() {
    if (_cartBox != null) {
      return _cartBox?.values.toList() ?? [];
    }
    return []; // Retorna una lista vacía si la caja no está abierta
  }

  Future<void> limpiarCarrito() async {
    final box = _cartBox; // Asumiendo que tienes una caja para el carrito
    if (box != null) {
      await box.clear(); // Elimina todos los elementos de la caja
      print('Carrito limpiado');
    } else {
      print('No se pudo acceder al carrito para limpiarlo');
    }
  }
}
