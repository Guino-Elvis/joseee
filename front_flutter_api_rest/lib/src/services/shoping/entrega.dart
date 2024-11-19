import 'package:flutter/material.dart';
import 'package:front_flutter_api_rest/src/cache/EntregaCacheModel.dart';
import 'package:hive/hive.dart';

class EntregaService extends ChangeNotifier {
  Box<EntregaCacheModel>? _entregaCaja;

  EntregaService() {
    // Asegúrate de que la caja ya esté abierta en `main()` antes de llegar aquí.
    if (Hive.isBoxOpen('entregacaja')) {
      _entregaCaja = Hive.box<EntregaCacheModel>('entregacaja');
    } else {
      throw HiveError('La caja "entregacaja" no está abierta.');
    }
  }
  // Getter para obtener la caja
  Box<EntregaCacheModel>? get entregaCaja {
    return _entregaCaja;
  }

  List<EntregaCacheModel> getEntregas() {
    return _entregaCaja?.values.toList() ?? [];
  }

  // Método para crear o agregar un entrega
  Future<void> agregarEntrega(EntregaCacheModel entrega) async {
    final box = _entregaCaja;
    if (box != null) {
      // Guardamos el entrega con el nuevo id
      await box.add(entrega);
      // Imprimimos los contenidos de la caja
      _printEntregaContents();
      notifyListeners();
    } else {
      print('La caja no está abierta, no se pudo agregar el entrega.');
    }
  }

  void _printEntregaContents() {
    if (_entregaCaja != null) {
      List<EntregaCacheModel> entregaItems = _entregaCaja!.values.toList();
      if (entregaItems.isEmpty) {
        print('La caja está vacía.');
      } else {
        print('Contenido de la caja:');
        for (var item in entregaItems) {
          print(
              'Id: ${item.id}, Departamento: ${item.departamento}, Provincia: ${item.provincia}, Distrito: ${item.distrito}, Referencia: ${item.referencia}, AuthUserId: ${item.authUserId}');
        }
      }
    } else {
      print('No se pudo acceder a la caja');
    }
  }

  // Método para obtener un entrega por su ID
  Future<EntregaCacheModel?> obtenerEntrega(int id) async {
    final box = _entregaCaja;
    if (box != null) {
      return box.get(id); // Hive ya usa el ID como la clave
    } else {
      print('La caja no está abierta, no se pudo recuperar el entrega.');
      return null;
    }
  }

  // Método para editar un entrega existente
  Future<void> editarEntrega(
      int id, EntregaCacheModel entregaActualizado) async {
    final box = _entregaCaja;

    if (box != null) {
      if (box.containsKey(id)) {
        await box.put(id, entregaActualizado);
      }
      print(
          'Entrega actualizado: Id: ${entregaActualizado.id}, Departamento: ${entregaActualizado.departamento}, Provincia: ${entregaActualizado.provincia}, Distrito: ${entregaActualizado.distrito}, Referencia: ${entregaActualizado.referencia}, AuthUserId: ${entregaActualizado.authUserId}');
    } else {
      print('La caja no está abierta, no se pudo agregar el entrega.');
    }
  }

  // Método para eliminar un entrega por su ID
  Future<void> eliminarEntrega(int id) async {
    final box = _entregaCaja;
    if (box != null) {
      // Verifica si el id existe en la caja antes de intentar eliminarlo
      if (box.containsKey(id)) {
        await box.delete(id); // Eliminar por la clave del id
        print('Entrega eliminado con id: $id');
      } else {
        print('El entrega con id $id no existe en la caja.');
      }
    } else {
      print('La caja no está abierta, no se pudo eliminar el entrega.');
    }
  }

  Future<void> limpiarEntrega() async {
    final box = _entregaCaja; // Asumiendo que tienes una caja para el carrito
    if (box != null) {
      await box.clear(); // Elimina todos los elementos de la caja
      print('Entrega limpiado');
    } else {
      print('No se pudo acceder al carrito para limpiarlo');
    }
  }
}
