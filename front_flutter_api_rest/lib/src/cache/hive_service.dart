// lib/services/hive_service.dart

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:front_flutter_api_rest/src/cache/ClienteCacheModel.dart';
import 'package:front_flutter_api_rest/src/cache/ProductoCacheModel.dart';
import 'package:front_flutter_api_rest/src/cache/EntregaCacheModel.dart';

class HiveService {
  // Función para inicializar Hive y abrir las cajas
  static Future<void> initializeHive() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDirectory.path);

    // Registramos el adaptador del modelo de ProductoCacheModel
    Hive.registerAdapter(ProductoCacheModelAdapter());
    Hive.registerAdapter(ClienteCacheModelAdapter());
    Hive.registerAdapter(EntregaCacheModelAdapter());

    // Abrir las cajas necesarias
    await openBox('cart', 'ProductoCacheModel');
    await openBox('clientecaja', 'ClienteCacheModel');
    await openBox('entregacaja', 'EntregaCacheModel');
  }

  // Función auxiliar para abrir una caja
  static Future<void> openBox(String boxName, String modelType) async {
    try {
      if (!Hive.isBoxOpen(boxName)) {
        print('Abriendo la caja "$boxName"');
        if (modelType == 'ProductoCacheModel') {
          await Hive.openBox<ProductoCacheModel>(boxName);
        } else if (modelType == 'ClienteCacheModel') {
          await Hive.openBox<ClienteCacheModel>(boxName);
        } else if (modelType == 'EntregaCacheModel') {
          await Hive.openBox<EntregaCacheModel>(boxName);
        }
      } else {
        print('La caja "$boxName" ya estaba abierta');
      }
    } catch (e) {
      print('Error al abrir la caja "$boxName": $e');
    }
  }

  // Función para cerrar todas las cajas al cerrar la app
  static Future<void> closeAllBoxes() async {
    await Hive.close();
  }
}
